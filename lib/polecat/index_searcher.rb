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
      if args[0].class == Polecat::IndexReader
        @reader = args[0]
      elsif args[0].class == String
        @reader = Polecat::IndexReader.new args[0]
      end
    end

    # returns the path of the index directory
    # @return [String] path of the index directory
    def path
      @reader.path
    end
  end
end
