require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "HashStorage#delete" do
  let (:s) { Polecat::Storage::HashStorage.new }
  before do
    s.add 'foo', 'bar'
    s.add 'bar', 'baz'
    s.add 'baz', 'foo'
  end

  it "decrements the element count" do
    s.delete('foo')
    s.count.should == 2
  end

  it "returns the value of the deleted key" do
    s.delete('foo').should == 'bar'
  end

  it "returns nil when the element was not found" do
    s.delete('foobar').should be(nil)
  end

  it "raises an error when the argument does not support #<=>" do
    lambda { s.delete(:foo) }.should raise_error(ArgumentError)
  end
end
