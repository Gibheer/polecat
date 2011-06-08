$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'benchmark'
require 'virtus'
require 'polecat'

class Document
  include Virtus

  attribute :name, Integer
  attribute :text, String
end

begin
  FileUtils.rm_r 'benchmark/index_dir'
rescue
end
Dir.mkdir 'benchmark/index_dir'
writer = Polecat::IndexWriter.new 'benchmark/index_dir'

(1..50000).each do |i|
  writer.add(Document.new(:name => i, :text => "Lorem #{i} Ipsum"))
end

writer.write
searcher = Polecat::IndexSearcher.new :reader => writer.create_reader
query = Polecat::Query.new.add(Polecat::Term.new(:name, :lt, 25000))

puts Benchmark.bm { |x|
  x.report('search') {
    for i in 1..5000 do
      searcher.search query
    end
  }
}
