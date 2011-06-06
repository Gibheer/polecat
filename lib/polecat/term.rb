class Polecat
  class Term
    # the field name which should be found
    attr_reader :field
    # the operator to match the field with the value
    attr_reader :operator
    # the search value which get's matched against the document field
    attr_reader :value

    # create a new Term for a query
    def initialize field, operator, value
      @field = field
      @operator = operator
      if @operator == :eq && value.class == String
        @value = /^#{value}$/
      else
        @value = value
      end
    end
  end
end
