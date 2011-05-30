require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "IndexReader#read" do
  before do
    @path = prepare_index_dir
  end

  it "returns a array with all documents" do
    r = Polecat::IndexReader.new @path
    r.read.class.should == Array
  end

  it "returns an empty hash for a empty directory" do
    r = Polecat::IndexReader.new @path
    r.read.count.should == 0
  end

  it "returns the document count found in the index directory" do
    w = Polecat::IndexWriter.new @path
    w.add Spec::FooDocument.new(:id => 23)
    w.write
    r = Polecat::IndexReader.new @path
    r.read.count.should == 1
  end

  it "returns an array of documents" do
    w = Polecat::IndexWriter.new @path
    w.add Spec::FooDocument.new(:id => 23)
    w.write
    w.create_reader.read[0].kind_of?(Polecat::Document).should == true
  end

  it "merges all documents from different files together" do
    w = Polecat::IndexWriter.new @path
    w.add Spec::FooDocument.new(:id => 23)
    w.write
    w.add Spec::FooDocument.new(:id => 24)
    w.write
    w.create_reader.read.count.should == 2
  end

  it "raises an error when the directory is locked" do
    FileUtils.touch @path + '/index.lock'
    r = Polecat::IndexReader.new @path
    lambda { r.read }.should raise_error(IOError)
  end
end
