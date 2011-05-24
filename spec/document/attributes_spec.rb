require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Document#attributes" do
  it "returns a hash with all attributes" do
    class FooDoc
      include Document

      field :bar
    end
    d = FooDoc.new
    d.attributes.should == {:bar => Document::OPTIONS}
  end
end
