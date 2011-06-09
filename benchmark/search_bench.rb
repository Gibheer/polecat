$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'benchmark'
require 'virtus'
require 'polecat'

n = 2500

def run_threads threadcount, count, searcher, query
  threads = []
  count = count / threadcount
  threadcount.times do
    threads << Thread.new do
      for i in 1..count do
        searcher.search query
      end
    end
  end
  threads.each {|t| t.join }
end

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

Benchmark.bm do |x|
  x.report('1') { run_threads 1, n, searcher, query.dup }
  x.report('2') { run_threads 2, n, searcher, query.dup }
  x.report('4') { run_threads 4, n, searcher, query.dup }
  x.report('8') { run_threads 8, n, searcher, query.dup }
end
