require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "IndexReader#read" do
  before do
    @path = prepare_index_dir
  end

  it "returns a IndexReader" do
    w = Polecat::IndexWriter.new @path
    w.create_reader.class.should == Polecat::IndexReader
  end

  it "returns a different object everytime it is called" do
    w = Polecat::IndexWriter.new @path
    w.create_reader.should_not == w.create_reader
  end

  it "returns an IndexReader with the same path" do
    w = Polecat::IndexWriter.new @path
    w.create_reader.path.should == w.path
  end
end
