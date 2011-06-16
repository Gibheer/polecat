require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
require 'polecat/storage/hash_storage'

describe "HashStorage#new" do
  it "creates a new storage object" do
    s = Polecat::Storage::HashStorage.new
    s.kind_of?(Polecat::Storage::Storage).should == true
    s.class.should be(Polecat::Storage::HashStorage)
  end
end
