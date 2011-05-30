require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "IndexSearcher#new" do
  before do
    @path = prepare_index_dir
  end

  it "takes a path as an arugment" do
    s = Polecat::IndexSearcher.new @path
    s.path.should == @path
  end

  it "takes an IndexReader as an argument" do
    s = Polecat::IndexSearcher.new(Polecat::IndexReader.new @path)
    s.path.should == @path
  end
end
