module Polecat
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
        value = /^#{value}$/
      else
        value = value
      end
      @value = value

      method_string = 'def compare(inval);'
      if value.class == Regexp
        if operator == :eq
          method_string += "  inval.match(@value);"
        else
          raise ArgumentError, "operation #{operator} does not work with a regexp"
        end
      else
        if operator == :eq
          method_string += "  inval == @value;"
        elsif operator == :lt
          method_string += "  inval < @value;"
        elsif operator == :gt
          method_string += "  inval > @value;"
        end
      end
      method_string += 'end;'
      self.instance_eval method_string
    end
  end
end
