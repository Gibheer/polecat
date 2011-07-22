require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
require 'polecat/storage/hash_storage'

describe "HashStorage#each" do
  let (:s) { Polecat::Storage::HashStorage.new }
  before do
    s.add(1, 1)
    s.add(2, 2)
  end

  it "yields the key and value" do
    s.each do |key, value|
      value.should == 1 if key == 1
    end
  end
end
