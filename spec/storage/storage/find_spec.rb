require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Storage#find" do
  let (:s) { Polecat::Storage::Storage.new }

  it "takes one argument" do
    s.method(:find).arity.should == 1
  end

  it "raises an error as this method is not implemented" do
    lambda { s.find(23) }.should raise_error(NotImplementedError)
  end
end
