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

      def check_key key
        raise ArgumentError, 'key does not support #<=>' unless key.respond_to?(:<=>)
      end
      private :check_key
    end
  end
end
