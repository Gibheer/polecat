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

    # searches through all documents
    #
    # Run the query against the @default_field@ of every stored document to get
    # a list of all matching documents.
    # @param [String] query a String which get's matched against the documents
    # @return [Array] a list of all matching documents
    def search query
      @reader.read.select do |doc|
        #doc.attributes.fetch(@default_field).fetch(:value) == query
        rs = []
        query.terms.each do |term|
          val = doc.send(term.field.to_sym)
          if compare val, term.operator, term.value
            rs << true
          end
        end
        if query.relation == :and
          rs.count == query.terms.count
        else
          !rs.empty?
        end
      end
    end

    # compare the document value with the searched value
    #
    # This compares the two values with the operator
    # @return [Any] trueish for matches or falsey
    # @private
    def compare ival, op, tval
      if op == :eq
        if tval.class == Regexp
          ival.match tval
        else
          ival == tval
        end
      elsif op == :gt
        ival < tval
      elsif op == :lt
        ival > tval
      else
        false
      end
    end
    private :compare
  end
end
