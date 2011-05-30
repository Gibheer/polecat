require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "IndexSearcher#search" do
  let(:path) { prepare_index_dir }
  let(:s) { Polecat::IndexSearcher.new :path => path }

  it "takes a string as an argument" do
    s.search("foo").should == []
  end
end
