require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Document#write" do
  before do
    @path = prepare_index_dir
    @file = @path + '/index.txt'
  end

  it "writes a string to a file" do
    i = Polecat::Index.new @path
    i.write "foobar"
    i.flush
    File.read(@file).should == Marshal.dump(["foobar"])
  end

  it "appends new entries to the end of the file" do
    i = Polecat::Index.new @path
    i.write "foo"
    i.write "bar"
    i.flush
    File.read(@file).should == Marshal.dump(["foo", "bar"])
  end
end
