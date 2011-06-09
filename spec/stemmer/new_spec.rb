require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Stemmer#new" do
  it "creates a new stemmer" do
    s = Polecat::Stemmer.new
    s.class.should be(Polecat::Stemmer)
  end
end
