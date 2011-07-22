require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
require 'polecat/storage/binary_storage'

describe "BinaryStorage#each" do
  let (:s) { Polecat::Storage::BinaryStorage.new }
  before do
    s.add(1,1)
    s.add(2,2)
  end

  it "yields the key and the value" do
    s.each do |key, value|
      value.should == 1 if key == 1
    end
  end

  it "yields all elements" do
    count = 0
    s.each do
      count += 1
    end
    count.should == s.count
  end
end
