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

    it "returns true, if the directory contains an index"
  end

  describe "#write" do
    before do
      @path = prepare_index_dir
      @file = @path + '/index.txt'
    end

    it "writes a string to a file" do
      i = Polecat::Index.new @path
      i.write "foobar"
      File.read(@file).should == "foobar\n"
    end

    it "appends new entries to the end of the file" do
      i = Polecat::Index.new @path
      i.write "foo"
      i.write "bar"
      File.read(@file).should == "foo\nbar\n"
    end
  end

  describe "#search" do
    before do
      @path = prepare_index_dir
      @file = @path + '/index.txt'
    end

    it "returns the line of the first found occurence" do
      i = Polecat::Index.new @path
      i.write "foo"
      i.search("foo").should == 0
    end
  end
end
