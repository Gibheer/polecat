require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Storage#interval" do
  let (:s) { Polecat::Storage::Storage.new }

  it "takes two arguments" do
    s.method(:interval).arity.should == 2
  end

  it "raises an error when one of the arguments type does not match" do
    lambda { s.interval(1, 2) }.should raise_error(NotImplementedError)
  end
end
