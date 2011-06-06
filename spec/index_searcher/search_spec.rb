require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "IndexSearcher#search" do
  let(:path) { prepare_index_dir }
  let(:w) { Polecat::IndexWriter.new(path) }
  let(:s) { Polecat::IndexSearcher.new :path => path }

  it "returns an empty array when the query is empty" do
    s.search(Polecat::Query.new).should == []
  end

  context "searching on a filled index" do
    before do
      w.add Spec::FooDocument.new(:id => 0, :name => 'foo')
      w.add Spec::FooDocument.new(:id => 1, :name => 'bar')
      w.add Spec::FooDocument.new(:id => 2, :name => 'baz')
      w.add Spec::FooDocument.new(:id => 3, :name => 'foobar')
      w.write
    end

    let :s do
      Polecat::IndexSearcher.new(
        :reader => w.create_reader,
        :default_field => :name
      )
    end

    let (:q1) { Polecat::Query.new.add(Polecat::Term.new(:id, :eq, 1)) }
    it "returns an array of documents, when a document was found" do
      s.search(q1).count.should == 1
    end

    let (:q2) { Polecat::Query.new.add(Polecat::Term.new(:name, :eq, 'foo')) }
    it "returns only matches for a String query" do
      s.search(q2).count.should == 1
    end

    let (:q3) { Polecat::Query.new.add(Polecat::Term.new(:name, :eq, /foo/)) }
    it "returns all documents when an regexp is given" do
      s.search(q3).count.should == 2
    end

    let (:q4) { Polecat::Query.new.add(Polecat::Term.new(:id, :eq, 33)) }
    it "returns an empty array when no document matched" do
      s.search(q4).count.should == 0
    end

    let (:q5) {
      Polecat::Query.new.
        add(Polecat::Term.new(:id, :eq, 3)).
        add(Polecat::Term.new(:name, :eq, 'foobar'))
    }
    it "returns a document for a query with multiple terms" do
      s.search(q5).count.should == 1
    end
  end
end
