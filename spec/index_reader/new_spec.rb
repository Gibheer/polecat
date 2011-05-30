require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "IndexReader#new" do
  before do
    @path = prepare_index_dir
  end

  it "takes a directory path as an argument" do
    r = Polecat::IndexReader.new @path
    r.path.should == @path
  end

  it "raises an error when no path is given" do
    lambda { Polecat::IndexReader.new }.should raise_error(ArgumentError)
  end

  it "raises an error when the path is not a directory" do
    lambda { Polecat::IndexReader.new '/dev/null' }.should(
      raise_error(ArgumentError))
  end
end
