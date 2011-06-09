require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'polecat/stemmer/simple'

describe Polecat::SimpleStemmer do
  it "creates a new SimpleStemmer" do
    subject.class.should be(Polecat::SimpleStemmer)
  end

  it "is a stemmer" do
    subject.kind_of?(Polecat::Stemmer).should be(true)
  end
end
