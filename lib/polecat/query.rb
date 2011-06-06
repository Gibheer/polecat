class Polecat
  # The Query manages a number of terms or queries which are set into a
  # relation. A relation is needed to say, which documents shall be
  # returned.
  # In a @and@ relation only the documents, which are returned of the query
  # parts get returned. For @or@ all documents found in a part get returned.
  class Query
    # returns the relation of the terms
    # @return [Symbol] :and, :or
    attr_accessor :relation

    # returns the list of all terms
    attr_reader :terms

    # creates a new query object
    #
    # Create a new query object. As a default, the relation is set to @:and@
    # (@see Query#relation)
    def initialize relation = :and
      if relation == :and || relation == :or
        @relation = relation
      else
        raise ArgumentError, 'no valid relation'
      end

      @terms = []
    end

    # add a new term or query
    def add term
      @terms << term
      self
    end
  end
end
