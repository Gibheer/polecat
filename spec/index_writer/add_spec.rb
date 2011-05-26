require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "IndexWriter#add" do
  before :all do
    @doc1 = Spec::FooDocument.new :id => 1
    @doc2 = Spec::FooDocument.new :id => 2
  end

  before do
    @path = prepare_index_dir
  end

  it "adds the object to the list of objects" do
    w = Polecat::IndexWriter.new @path
    w.add @doc1
    w.count.should == 1
  end

  it "raises an error, when the object is not a document" do
    lambda { Polecat::IndexWriter.new(@path).add "foo" }.should(
      raise_error(ArgumentError))
  end
end
