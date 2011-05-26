require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "IndexWriter#count" do
  before :all do
    @path = prepare_index_dir
  end

  it "returns 0 on an empty writer" do
    w = Polecat::IndexWriter.new @path
    w.count.should == 0
  end

  it "returns the number of documents stored in the storage" do
    w = Polecat::IndexWriter.new @path
    w.add Spec::FooDocument.new
    w.count.should == 1
  end
end
