require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "IndexWriter#add" do
  let (:path) { prepare_index_dir }
  let (:doc1) { Spec::TestDocument.new :id => 1 }
  let (:doc2) { Spec::TestDocument.new :id => 2 }
  let (:w) { w = Polecat::IndexWriter.new path }

  it "adds the object to the list of objects" do
    w.add doc1
    w.count.should == 1
  end

  it "takes multiple documents and stores them" do
    w.add doc1
    w.add doc2
    w.count.should == 2
  end

  it "raises an error, when the object is not a document" do
    lambda { Polecat::IndexWriter.new(path).add "foo" }.should(
      raise_error(ArgumentError))
  end
end
