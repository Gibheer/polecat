require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
require 'polecat/storage/hash_storage'

describe "HashStorage#find" do
  let (:s) { Polecat::Storage::HashStorage.new }
  before do
    s.add 'foo', 'bar'
    s.add 'bar', 'baz'
    s.add 'baz', 'foobar'
    s.add 'zum', 'zum'
  end

  it "returns nil when the element was not found" do
    s.find('baba').should be(nil)
  end

  it "returns the value of the key" do
    s.find('foo').should == 'bar'
  end

  it "raises an error when the type does not know #<=>" do
    lambda { s.find(nil) }.should raise_error(ArgumentError)
  end
end
