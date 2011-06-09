require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Stemmer#stem" do
  let (:s) { Polecat::Stemmer.new }

  it "takes one argument" do
    s.method(:stem).arity.should == 1
  end

  it "raises an error, because it's an abstract class" do
    lambda { s.stem "word" }.should raise_error(NotImplementedError)
  end
end
