class Polecat
  # interface for searching an index
  #
  # Build on top of an Polecat::IndexReader, this class let's you search through
  # all documents stored in an index.
  class IndexSearcher
    attr_reader :reader
    attr_reader :default_field

    # creates a new Polecat::IndexSearcher
    #
    # Create a new Polecat::IndexSearcher to search documents. Either a path
    # to a directory or a Polecat::IndexReader has to be given, to make this
    # searcher work.
    # @example
    #   # the following has the same meaning
    #   IndexSearcher.new 'index_dir'
    #   IndexSearcher.new(IndexReader.new 'index_dir')
    def initialize options
      if options.has_key? :path
        @reader = Polecat::IndexReader.new(options[:path])
      elsif options.has_key? :reader 
        @reader = options[:reader]
        raise ArgumentError, 'no reader' unless @reader.kind_of?(Polecat::IndexReader)
      end

      if options.has_key? :default_field
        @default_field = options[:default_field]
      end
    end

    # returns the path of the index directory
    # @return [String] path of the index directory
    def path
      @reader.path
    end

    def search query
      result = []
      @reader.read.each do |doc|
        result << doc if (doc.attributes[@default_field][:value] == (query))
      end
      result
    end
  end
end
