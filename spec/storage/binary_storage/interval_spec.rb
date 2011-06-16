require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
require 'polecat/storage/binary_storage'

describe "BinaryStorage#interval" do
  let (:s) { Polecat::Storage::BinaryStorage.new }
  before do
    s.add 'foo', 'bar'
    s.add 'bar', 'baz'
    s.add 'baz', 'foobar'
    s.add 'zum', 'zum'
  end

  it "returns an empty array when no element was found" do
    s.interval('a', 'b').should == []
  end

  it "returns an array of found elements" do
    s.interval('ba', 'bb').sort.should == ['baz', 'foobar']
  end

  it "includes the search values" do
    s.interval('bar', 'baz').sort.should == ['baz', 'foobar']
  end

  it "raises an error when one of the arguments does not implement #<=>" do
    lambda { s.interval(1, :foo) }.should raise_error(ArgumentError)
  end
end
