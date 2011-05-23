require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Index#new" do
  before :all do
    @path = prepare_index_dir
  end

  it "takes a path as an argument" do
    i = Polecat::Index.new @path
    i.path.should == @path
  end

  it "raises an ArgumentError, when no path is given" do
    lambda { Polecat::Index.new }.should raise_error(ArgumentError)
  end

  it "raises an ArgumentError, when the path is no directory" do
    lambda {
      Polecat::Index.new "/dev/null" 
    }.should raise_error(ArgumentError)
  end
end
