require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Index#count" do
  before :all do
    @path = prepare_index_dir
  end

  it "returns 0 on a fresh index" do
    i = Polecat::Index.new @path
    i.count.should == 0
  end

  it "returns 1 when 1 entry is in the index" do
    i = Polecat::Index.new @path
    i.write Spec::FooDocument.new(:id => 1)
    i.flush
    i.count.should == 1
  end

  it "does not count entries, which got not flushed" do
    i = Polecat::Index.new @path
    i.write Spec::FooDocument.new(:id => 1)
    i.count.should == 0
  end
end
