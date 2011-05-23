require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Document#index_dir?" do
  before :all do
    @path = prepare_index_dir
  end

  it "returns false, if the directory does not contain an index" do
    i = Polecat::Index.new @path
    i.index_dir?.should == false
  end

  it "returns true, if the directory contains an index" do
    i = Polecat::Index.new @path
    i.write 'foo'
    i.flush
    i.index_dir?.should == true
  end
end
