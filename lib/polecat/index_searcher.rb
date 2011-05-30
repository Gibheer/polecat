class Polecat
  # interface for searching an index
  #
  # Build on top of an Polecat::IndexReader, this class let's you search through
  # all documents stored in an index.
  class IndexSearcher
    attr_reader :reader

    # creates a new Polecat::IndexSearcher
    #
    # Create a new Polecat::IndexSearcher to search documents. Either a path
    # to a directory or a Polecat::IndexReader has to be given, to make this
    # searcher work.
    # @example
    #   # the following has the same meaning
    #   IndexSearcher.new 'index_dir'
    #   IndexSearcher.new(IndexReader.new 'index_dir')
    def initialize *args
      first = args[0]
      if first.class == Polecat::IndexReader
        @reader = first
      elsif first.class == String
        @reader = Polecat::IndexReader.new first
      end
    end

    # returns the path of the index directory
    # @return [String] path of the index directory
    def path
      @reader.path
    end
  end
end
