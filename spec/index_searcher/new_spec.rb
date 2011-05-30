require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "IndexSearcher#new" do
  before do
    @path = prepare_index_dir
  end

  it "takes a hash with options as an argument" do
    s = Polecat::IndexSearcher.new(
      :path          => @path,
      :default_field => :description
    )
    s.path.should          == @path
    s.default_field.should == :description
  end

  it "takes a reader in the options" do
    r = Polecat::IndexReader.new(@path)
    s = Polecat::IndexSearcher.new :reader => r
    s.reader.should == r
  end

  it "raises an error, when the reader is not an IndexReader" do
    lambda { Polecat::IndexSearcher.new(:reader => "foo") }.should(
      raise_error(ArgumentError))
  end
end
