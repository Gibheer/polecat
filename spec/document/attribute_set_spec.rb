require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Document#attribute_set" do
  before do
    @doc = Spec::FooDocument.new
  end

  it "takes a name and a value as an argument" do
    @doc.attribute_set :id, 23
    @doc.id.should == 23
  end

  it "takes a string as name" do
    @doc.attribute_set 'id', 23
    @doc.id.should == 23
  end

  it "raises an error if the name does not exist" do
    lambda { @doc.attribute_set :foo, 23 }.should raise_error(ArgumentError)
  end
end
