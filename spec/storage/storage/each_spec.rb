require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Storage#each" do
  it "raises an error, as it has to be implemented" do
    lambda { Polecat::Storage::Storage.new.each {|k,v| } }.should(
      raise_error(NotImplementedError))
  end
end
