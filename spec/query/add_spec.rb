require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Query#add" do
  let (:term1) { Polecat::Term.new(:id, :eq, 23) }
  let (:term2) { Polecat::Term.new(:name, :eq, 'foo') }
  let (:term3) { Polecat::Term.new(:lastname, :eq, /foo/) }
  let (:query) { Polecat::Query.new }

  it "returns the query object for chaining" do
    query.add(term1).should be(query)
  end

  it "adds the term to the list of terms" do
    query.add(term1).terms.count.should be(1)
  end
end
