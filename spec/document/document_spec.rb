require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Document" do
  describe "#initialize" do
    it "creates a new Document object" do
      d = Spec::FooDocument.new
      d.is_a?(Polecat::Document).should == true
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

    it "creates a method to get an attribute value" do
      class FooDoc
        include Polecat::Document
        field :doc
      end
      FooDoc.new.respond_to?(:doc).should == true
    end

    it "creates a method to set an attribute" do
      class FooDoc
        include Polecat::Document
        field :doc
      end
      d = FooDoc.new
      d.doc = 'foo'
      d.doc.should == 'foo'
    end

    it "raises an error, when the key is not found" do
      lambda { Spec::FooDocument.new(:foo => :bar) }.should(
        raise_error(ArgumentError))
    end
  end

  describe "#attributes" do
    it "returns a hash with all attributes" do
      class FooDoc
        include Polecat::Document

        field :bar
      end
      d = FooDoc.new
      d.attributes.should == {:bar => Polecat::Document::OPTIONS}
    end
  end
end
