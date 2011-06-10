require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'polecat/stemmer/simple'
require 'polecat/analyzer/standard'

describe "StandardAnalyzer#new" do
  let (:s) { Polecat::SimpleStemmer.new }

  it "uses the simple stemmer as default" do
    a = Polecat::StandardAnalyzer.new
    a.stemmer.class.should == Polecat::SimpleStemmer
  end

  it "takes an object as an argument which has a method #stem" do
    a = Polecat::StandardAnalyzer.new s
    a.stemmer.should be(s)
  end

  it "raises an error when the argument does not know the method #stem" do
    lambda { Polecat::StandardAnalyzer.new "foo" }.should(
      raise_error(ArgumentError))
  end
end
