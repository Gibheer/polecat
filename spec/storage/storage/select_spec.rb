require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Storage#select" do
  let (:s) { Polecat::Storage::Storage.new }

  it "takes a block as an argument" do
    s.method(:select).arity.should == 0
  end

  it "raises an error as it is not implemented" do
    lambda { s.select }.should raise_error(NotImplementedError)
  end
end
