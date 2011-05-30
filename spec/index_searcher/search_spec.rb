require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "IndexSearcher#search" do
  let(:path) { prepare_index_dir }
  let(:w) { Polecat::IndexWriter.new(path) }
  let(:s) { Polecat::IndexSearcher.new :path => path }

  it "returns an empty array when nothing was found" do
    s.search("foo").should == []
  end

  context "searching on a filled index" do
    before do
      w.add Spec::FooDocument.new(:name => 'foo')
      w.add Spec::FooDocument.new(:name => 'bar')
      w.add Spec::FooDocument.new(:name => 'baz')
      w.add Spec::FooDocument.new(:name => 'foobar')
      w.write
    end

    let :s do
      Polecat::IndexSearcher.new(
        :reader => w.create_reader,
        :default_field => :name
      )
    end

    it "returns an array of documents, when a document was found" do
      s.search('foo').count.should == 1
    end
  end
end
