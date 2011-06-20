$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'benchmark'
require 'virtus'
require 'polecat'
require 'polecat/storage/binary_storage'
require 'polecat/storage/hash_storage'

n = 1500
docs = 50000
find = 25000

def run_threads1 threadcount, count, searcher, query
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

def run_threads2 threadcount, count, searcher, query
  threads = []
  count = count / threadcount
  threadcount.times do
    threads << Thread.new do
      for i in 1..count do
        searcher.search_with_index query
      end
    end
  end
  threads.each {|t| t.join }
end

class Document
  include Virtus

  attribute :name1, Integer, :storage => Polecat::Storage::BinaryStorage
  attribute :name2, Integer, :storage => Polecat::Storage::HashStorage
  attribute :text, String
end

begin
  FileUtils.rm_r 'benchmark/index_dir'
rescue
end
Dir.mkdir 'benchmark/index_dir'
writer = Polecat::IndexWriter.new 'benchmark/index_dir'

(1..docs).each do |i|
  writer.add(Document.new(:name1 => i, :name2 => i, :text => "Lorem #{i} Ipsum"))
end

writer.write
searcher = Polecat::IndexSearcher.new :reader => writer.create_reader
searcher.load

Benchmark.bm do |x|
  query = Polecat::Query.new.add(Polecat::Term.new(:name1, :eq, find))
  x.report('1') { run_threads1 1, n, searcher, query.dup }
  x.report('2') { run_threads1 2, n, searcher, query.dup }
  x.report('4') { run_threads1 4, n, searcher, query.dup }
  x.report('8') { run_threads1 8, n, searcher, query.dup }
  query = Polecat::Query.new.add(Polecat::Term.new(:name1, :eq, find))
  x.report('1') { run_threads2 1, n, searcher, query.dup }
  x.report('2') { run_threads2 2, n, searcher, query.dup }
  x.report('4') { run_threads2 4, n, searcher, query.dup }
  x.report('8') { run_threads2 8, n, searcher, query.dup }
  query = Polecat::Query.new.add(Polecat::Term.new(:name2, :eq, find))
  x.report('1') { run_threads2 1, n, searcher, query.dup }
  x.report('2') { run_threads2 2, n, searcher, query.dup }
  x.report('4') { run_threads2 4, n, searcher, query.dup }
  x.report('8') { run_threads2 8, n, searcher, query.dup }
end
