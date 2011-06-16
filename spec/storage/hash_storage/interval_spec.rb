require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "HashStorage#interval" do
  let (:s) { Polecat::Storage::HashStorage.new }
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

  it "raises an error when one of the arguments type does not match" do
    lambda { s.interval(1, 2) }.should raise_error(ArgumentError)
  end
end
