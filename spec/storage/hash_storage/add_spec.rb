require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
require 'polecat/storage/hash_storage'

describe "HashStorage#add" do
  let (:s) { Polecat::Storage::HashStorage.new }

  it "raises the element count" do
    s.add('foo', 'bar')
    s.count.should == 1
  end

  it "raises the element count with every add" do
    s.add('foo', 1)
    s.add('bar', 2)
    s.add('baz', 3)
    s.count.should == 3
  end

  it "raises an error when the attribute does not support #<=>" do
    lambda { s.add(nil, 'baz') }.should raise_error(ArgumentError)
  end
end
