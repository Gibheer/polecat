require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Index#search" do
  before :all do
    @doc1 = Spec::FooDocument.new :id => 1, :description => 'foo'
    @doc2 = Spec::FooDocument.new :id => 2, :description => 'bar'
    @doc3 = Spec::FooDocument.new :id => 3, :description => 'foo bar baz'
  end

  before do
    @path = prepare_index_dir
    @file = @path + '/index.txt'
  end

  it "returns an array of lines, where the match was found" do
    i = Polecat::Index.new @path
    i.write @doc1
    i.write @doc2
    i.write @doc1.clone
    i.flush
    i.search("foo").should == [0, 2]
  end

  it "returns an array of lines, where the match is somewhere in it" do
    i = Polecat::Index.new @path
    i.write @doc3
    i.flush
    i.search("baz").should == [0]
  end

  it "returns an empty array, when no match was found" do
    i = Polecat::Index.new @path
    i.write @doc1
    i.write @doc2
    i.flush
    i.search("baz").should == []
  end
end
