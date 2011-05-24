require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Document#flush" do
  before do
    @path = prepare_index_dir
    @file = @path + '/index.txt'
    @doc  = Spec::FooDocument.new(:id => 1)
  end

  it "does not write anything to the file, until the #flush was called" do
    i = Polecat::Index.new @path
    i.flush
    i.write @doc 
    File.read(@file).should == Marshal.dump([])
  end

  it "writes the content in the buffer to the file" do
    i = Polecat::Index.new @path
    i.write @doc
    i.flush
    File.read(@file).should == Marshal.dump([@doc])
  end
end
