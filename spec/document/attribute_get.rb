require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Document#attribute_get" do
  before do
    @doc = Document.new :id => 23
  end

  it "returns the value of the named attribute" do
    @doc.attribute_get(:id).should == 23
  end

  it "returns the value if a string is given" do
    @doc.attribute_get('id').should == 23
  end

  it "raises an error if the attribute does not exist" do
    lambda { @doc.attribute_get('foo') }.should raise_error(ArgumentError)
  end
end
