require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Storage#add" do
  let (:s) { Polecat::Storage::Storage.new }

  it "takes two parameters" do
    s.method(:add).arity.should == 2
  end

  it "raises an error because it is not implemented" do
    lambda { s.add 1, 2 }.should raise_error(NotImplementedError)
  end
end
