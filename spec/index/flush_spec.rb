require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Document#flush" do
  before do
    @path = prepare_index_dir
    @file = @path + '/index.txt'
  end

  it "does not write anything to the file, until the #flush was called" do
    i = Polecat::Index.new @path
    i.flush
    i.write "foo"
    File.read(@file).should == Marshal.dump([])
  end

  it "writes the content in the buffer to the file" do
    i = Polecat::Index.new @path
    i.write "foo"
    i.flush
    File.read(@file).should == Marshal.dump(["foo"])
  end
end
