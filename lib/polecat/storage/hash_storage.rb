module Polecat
  module Storage
    # This class is a storage engine based on a simple hash.
    class HashStorage < Storage
      def initialize
        @storage = {}
      end

      def add key, value
        check_key key
        @storage[key] = value
      end
      alias :[]= :add

      def delete key
        check_key key
        @storage.delete key
      end

      def interval lower, upper
        check_key lower
        check_key upper
        select do |key|
          lower <= key && key <= upper
        end
      end

      def find key
        check_key key
        if @storage.has_key? key
          @storage[key]
        else
          nil
        end
      end
      alias :[] :find

      def select &block
        out = []
        @storage.keys.each do |key|
          out << @storage[key] if block.call(key)
        end
        out
      end

      def count
        @storage.count
      end

      # traverse all elements 
      def each &block
        @storage.each &block
      end

      def check_key key
        unless key.respond_to?(:<=>) && key.respond_to?(:<=)
          raise ArgumentError, 'key does not support #<=>' 
        end
      end
      private :check_key
    end
  end
end
