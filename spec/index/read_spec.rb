require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Index#read" do
  before :all do
    @path = prepare_index_dir
  end

  it "does not read any entries, when no files are in the directory" do
    i = Polecat::Index.new @path
    i.read
    i.count.should == 0
  end

  it "loads all documents in the index directory" do
    i = Polecat::Index.new @path
    i.write "foo"
    i.flush
    i = Polecat::Index.new @path
    i.read
    i.count.should == 1
  end
end
