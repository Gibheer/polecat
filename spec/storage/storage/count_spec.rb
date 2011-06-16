require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Storage#count" do
  let (:s) { Polecat::Storage::Storage.new }

  it "takes no argument" do
    s.method(:count).arity.should == 0
  end

  it "raises an error as it is not implemented" do
    lambda { s.count }.should raise_error(NotImplementedError)
  end
end
