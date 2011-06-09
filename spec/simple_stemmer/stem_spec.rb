require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'polecat/stemmer/simple'

describe Polecat::SimpleStemmer do
  it "takes one argument" do
    subject.method(:stem).arity.should be(1)
  end 

  it "returns nil if nil was given" do
    subject.stem(nil).should be(nil)
  end

  it "returns the word if nothing was done" do
    subject.stem("a").should == "a"
  end

  it "deletes 'ing' from the end" do
    subject.stem("finding").should == "find"
  end

  it "deletes 'ed' from the word end" do
    subject.stem("coded").should == "cod"
  end

  it "returns numbers not as a string" do
    subject.stem(1).class.should be(Fixnum)
  end

  it "returns a float not as a string" do
    subject.stem(1.1).class.should be(Float)
  end

  it "takes an array and stems every element in it" do
    subject.stem(['coding'])[0].should == 'coding'
  end
end
