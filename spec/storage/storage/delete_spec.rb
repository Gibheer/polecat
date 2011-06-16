require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Storage#delete" do
  let (:s) { Polecat::Storage::Storage.new }

  it "takes one argument" do
    s.method(:delete).arity.should == 1
  end

  it "raises an error as it is not implemented" do
    lambda { s.delete 1 }.should raise_error(NotImplementedError)
  end
end
