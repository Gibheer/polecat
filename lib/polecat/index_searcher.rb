module Polecat
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
      @content = @reader.read if @content.nil?
      @content.select do |doc|
        rs = []
        query.terms.each do |term|
          if term.compare(doc.send(term.field))
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

    # searches through all documents
    #
    # Run the query against the @default_field@ of every stored document to get
    # a list of all matching documents.
    # @param [String] query a String which get's matched against the documents
    # @return [Array] a list of all matching documents
    def search_with_index query
      docs = []
      return docs if query.terms.empty?
      load if @content.nil?
      return docs if @content.nil?
      index = {}
      query.terms.each do |term|
        if term.operator == :eq && term.value.class != Regexp
          set = @attribute_storage[term.field][term.value]
        else
          set = @content.select do |doc|
            term.compare(doc.send(term.field))
          end
        end

        if !set.nil? && !set.empty?
          if docs.empty?
            docs = set
            if query.relation == :and
              docs.each do |value|
                index[value] = nil
              end
            end
          else
            if query.relation == :or
              docs += set
            else
              set.each do |value|
                if !index.has_key? value
                  docs << value
                  index[value] = nil
                end
              end
            end
          end
        end
      end
      docs
    end

    # loads all stuff and builds the indexes
    def load
      @content = @reader.read
      if @content.nil?
        return
      end
      @attribute_storage = {}
      attributes = @content.first.class.attributes
      attributes.each do |key, attribute|
        if attribute.options.has_key? :storage
          @attribute_storage[key] = attribute.options[:storage].new
        else
          @attribute_storage[key] = Hash.new
        end
      end
      @content.each do |doc|
        add_doc doc
      end
    end

    def add_doc doc
      doc.attributes.each do |key, value|
        begin
          store = @attribute_storage[key][value]
        rescue
          store = nil
        end
        if store.nil?
          @attribute_storage[key][value] = [doc]
        else
          store << doc
        end
      end
    end
  end
end
