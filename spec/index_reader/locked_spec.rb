require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "IndexReader#locked?" do
  before do
    @path = prepare_index_dir
  end

  it "returns false when the directory is not locked" do
    r = Polecat::IndexReader.new @path
    r.locked?.should == false
  end

  it "returns true when the directory is locked" do
    FileUtils.touch @path + '/index.lock'
    r = Polecat::IndexReader.new @path
    r.locked?.should == true
  end
end
