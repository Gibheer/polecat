require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Document#initialize" do
  it "creates a new Document object" do
    d = Spec::FooDocument.new
    d.is_a?(Document).should == true
  end

  it "takes a hash as argument" do
    d = Spec::FooDocument.new(
      :id          => 1,
      :name        => 'foo',
      :lastname    => 'bar', 
      :description => 'this is a test'
    )
    d.id.should       == 1
    d.name.should     == 'foo'
    d.lastname.should == 'bar'
    d.description.should == 'this is a test'
  end

  it "sets the attributes to nil as default" do
    d = Spec::FooDocument.new
    d.id.should == nil
  end

  it "raises an error, when the key is not found" do
    lambda { Spec::FooDocument.new(:foo => :bar) }.should(
      raise_error(ArgumentError))
  end
end
