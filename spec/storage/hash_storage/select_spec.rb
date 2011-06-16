require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "HashStorage#select" do
  let (:s) { Polecat::Storage::HashStorage.new }
  before do
    s.add 'key', 'value'
    s.add 'foo', 'bar'
    s.add 'bar', 'baz'
    s.add 'baz', 'foobar'
  end

  it "returns an empty array, when no element was selected" do
    (s.select {|element| false }).should == []
  end

  it "takes a block as an argument" do
    (s.select {|element| element.match /ba*/ }).sort.should == ['baz', 'foobar']
  end

  it "does not handle errors" do
    lambda { s.select {|element| raise ArgumentError }}.should(
      raise_error(ArgumentError))
  end
end
