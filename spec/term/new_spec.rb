require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Term#new" do
  it "takes a field, a operator and a value" do
    t = Polecat::Term.new :id, :eq, 23
    t.field.should be(:id)
    t.operator.should be(:eq)
    t.value.should be(23)
  end

  it "converts Strings to Regexps, if the operator is :eq" do
    t = Polecat::Term.new :name, :eq, "foo"
    t.value.should == /^foo$/
  end

  it "creates a method #compare with one argument after initialization" do
    t = Polecat::Term.new :name, :eq, "foo"
    t.respond_to?(:compare).should == true
    t.method(:compare).arity.should == 1
  end

  it "raises an error if a regexp shall be compared for larger or minor" do
    lambda { Polecat::Term.new(:name, :lt, /foo/) }.should(
      raise_error(ArgumentError))
  end

  it "raises an error if no argument is given" do
    lambda { Polecat::Term.new }.should raise_error
  end
end
