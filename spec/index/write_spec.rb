require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Document#write" do
  before :all do
    @doc1 = Spec::FooDocument.new(:id => 1)
    @doc2 = Spec::FooDocument.new(:id => 2)
  end

  before do
    @path = prepare_index_dir
    @file = @path + '/index.txt'
  end

  it "writes a document to a file" do
    i = Polecat::Index.new @path
    i.write @doc1
    i.flush
    File.read(@file).should == Marshal.dump([@doc1])
  end

  it "appends new entries to the end of the file" do
    i = Polecat::Index.new @path
    i.write @doc1 
    i.write @doc2
    i.flush
    File.read(@file).should == Marshal.dump([@doc1, @doc2])
  end

  it "raises an error, if the object is not a Polecat::Document" do
    lambda { Polecat::Index.new(@path).write "foo" }.should(
      raise_error(ArgumentError))
  end
end
