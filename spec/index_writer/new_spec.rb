require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "IndexWriter#new" do
  before :all do
    @path = prepare_index_dir
  end

  it "takes a path as an argument" do
    writer = Polecat::IndexWriter.new @path
    writer.path.should == @path
  end

  it "raises an Argument when no path is given" do
    lambda { Polecat::IndexWriter.new }.should raise_error(ArgumentError)
  end

  it "raises an error, when the path is not directory" do
    lambda {
      Polecat::IndexWriter.new "/dev/null" 
    }.should raise_error(ArgumentError)
  end

  it "raises an error when a index.lock file is in the directory" do
    FileUtils.touch @path + '/index.lock'
    lambda { Polecat::IndexWriter.new @path }.should raise_error(IOError)
  end
end
