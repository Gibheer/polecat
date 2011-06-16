module Polecat
  module Storage
    # This class is a schema for building storage engines which then can be used
    # in the index.
    class Storage
      # creates a new storage
      def initialize
      end

      # add a new value with the key
      #
      # Add a new key with a value attached to this key. The key has to
      # have an implementation of the method #<=> as it is used for comparing
      # all values.
      # @param [#<=>] key a key for searching
      # @param [Object] value the coresponding value
      def add key, value
        raise NotImplementedError
      end

      # delete the element with this key
      #
      # This deletes the given key. The class of key must have an implementation
      # of #<=>.
      # @param [#<=>] key the key for values to be deleted
      def delete key
        raise NotImplementedError
      end

      # counts the number of elements
      def count
        raise NotImplementedError
      end

      # returns the value for this key or nil
      #
      # Finds the key and returns the first value or nil. The key must have an
      # implementation of #<=>.
      # @param [#<=>] key the key to look for
      # @return [Object] the value of the key
      def find key
        raise NotImplementedError
      end

      # return all values where the block is true
      #
      # This methods evaluates the block and stores all values in an array when
      # the block evaluates to true for the given key.
      # A list with all values is returnd.
      # @yield [key] the block which gets yield with the key
      # @return [Array] all found values
      def select &block
        raise NotImplementedError
      end

      # search in an interval
      #
      # Search for values where the key is between the lower and the upper
      # limit. Both lower and upper must implement the method #<=>.
      # All values are returned as a list.
      # @param [#<=>] lower the lower limit
      # @param [#<=>] upper the upper limit
      # @return [Array] a list of all found values
      def interval lower, upper
        raise NotImplementedError
      end
    end
  end
end
