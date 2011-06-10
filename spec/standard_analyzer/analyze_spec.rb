require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'polecat/analyzer/standard'

describe "StandardAnalyzer#analyze" do
  let (:s) { s = double; s.stub(:stem); s }
  let (:a) { Polecat::StandardAnalyzer.new s }

  it "takes an argument" do
    a.method(:analyze).arity.should be(1)
  end

  it "takes an object which implements the method split" do
    s.stub(:stem) { "foo" }
    a.analyze("foo").should == ["foo"]
  end

  it "returns an array of found elements" do
    a.analyze("foo").count.should be(1)
  end

  it "calls the method #stem of the stemmer for every chunk found" do
    s.stub(:stem) { "stem" }
    s.should_receive(:stem).with("stemmed")
    a.analyze("stemmed").should == ["stem"]
  end

  it "splits the content at whitespaces" do
    a.analyze("foo bar baz").count.should == 3
  end

  it "calls the method #stem for every word in the content" do
    s.stub(:stem) { "stem" }
    s.should_receive(:stem).with("stemmed")
    a.analyze("stemmed stemmer").should == ["stem", "stem"]
  end

  it "raises an error when the argument has not method split" do
    lambda { a.analyze 2 }.should raise_error(ArgumentError)
  end
end
