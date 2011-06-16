require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Storage#new" do
  it "creates a new storage object" do
    s = Polecat::Storage::Storage.new
    s.class.should be(Polecat::Storage::Storage)
  end
end
