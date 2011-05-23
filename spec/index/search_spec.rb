require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Index#search" do
  before do
    @path = prepare_index_dir
    @file = @path + '/index.txt'
  end

  it "returns an array of lines, where the match was found" do
    i = Polecat::Index.new @path
    i.write "foo"
    i.write "bar"
    i.write "foo"
    i.flush
    i.search("foo").should == [0, 2]
  end

  it "returns an array of lines, where the match is somewhere in it" do
    i = Polecat::Index.new @path
    i.write "foo bar baz"
    i.flush
    i.search("baz").should == [0]
  end

  it "returns an empty array, when no match was found" do
    i = Polecat::Index.new @path
    i.write "foo"
    i.write "bar"
    i.flush
    i.search("baz").should == []
  end
end
