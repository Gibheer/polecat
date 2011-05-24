require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "DocumentRessource#field" do
  it "creates a method to get an attribute value" do
    class FooDoc
      include Document
      field :doc
    end
    FooDoc.new.respond_to?(:doc).should == true
  end

  it "creates a method to set an attribute" do
    class FooDoc
      include Document
      field :doc
    end
    d = FooDoc.new
    d.doc = 'foo'
    d.doc.should == 'foo'
  end
end
