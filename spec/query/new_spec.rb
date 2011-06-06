require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Query#new" do
  it "uses 'and' as an default" do
    q = Polecat::Query.new
    q.relation.should be(:and)
  end

  it "takes a relation operator as an argument" do
    q = Polecat::Query.new :or
    q.relation.should be(:or)
  end

  it "raises an error, when the relation is not known" do
    lambda { Polecat::Query.new :foo }.should raise_error(ArgumentError)
  end
end
