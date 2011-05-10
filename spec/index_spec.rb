require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Index" do
  before :all do
    @path = prepare_index_dir
  end

  describe "#initialize" do
    it "takes a path as an argument" do
      i = Polecat::Index.new @path
      i.path.should == @path
    end


    it "raises an ArgumentError, when no path is given" do
      lambda { Polecat::Index.new }.should raise_error(ArgumentError)
    end

    it "raises an ArgumentError, when the path is no directory" do
      lambda {
        Polecat::Index.new "/dev/null" 
      }.should raise_error(ArgumentError)
    end
  end

  describe "#index_dir?" do
    it "returns false, if the directory does not contain an index" do
      i = Polecat::Index.new @path
      i.index_dir?.should == false
    end

    it "returns true, if the directory contains an index" do
      i = Polecat::Index.new @path
      i.write 'foo'
      i.flush
      i.index_dir?.should == true
    end
  end

  describe "#write" do
    before do
      @path = prepare_index_dir
      @file = @path + '/index.txt'
    end

    it "writes a string to a file" do
      i = Polecat::Index.new @path
      i.write "foobar"
      i.flush
      File.read(@file).should == "foobar\n"
    end

    it "appends new entries to the end of the file" do
      i = Polecat::Index.new @path
      i.write "foo"
      i.write "bar"
      i.flush
      File.read(@file).should == "foo\nbar\n"
    end
  end

  describe "#flush" do
    before do
      @path = prepare_index_dir
      @file = @path + '/index.txt'
    end

    it "does not write anything to the file, until the #flush was called" do
      i = Polecat::Index.new @path
      i.flush
      i.write "foo"
      File.read(@file).should == ""
    end

    it "writes the content in the buffer to the file" do
      i = Polecat::Index.new @path
      i.write "foo"
      i.flush
      File.read(@file).should == "foo\n"
    end
  end

  describe "#search" do
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
end
