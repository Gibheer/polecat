require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
require 'polecat/storage/binary_storage'

describe "BinaryStorage#new" do
  it "creates a new storage object" do
    s = Polecat::Storage::BinaryStorage.new
    s.kind_of?(Polecat::Storage::Storage).should == true
    s.class.should be(Polecat::Storage::BinaryStorage)
  end
end
