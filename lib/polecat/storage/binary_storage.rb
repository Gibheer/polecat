module Polecat
  module Storage
    # This class is a storage engine based on a simple hash.
    class BinaryStorage < Storage
      def initialize
        @root = nil
      end

      # add a new key value pair
      def add key, value = nil
        if key.class == Node
          new_node = key
        else
          check_key key
          new_node = Node.new key, value
        end

        if @root.nil?
          @root = new_node
        else
          cur_node = @root
          while cur_node.lower != new_node && cur_node.upper != new_node
            if cur_node.key > new_node.key
              if cur_node.lower.nil?
                cur_node.lower = new_node
              else
                cur_node = cur_node.lower
              end
            elsif cur_node.key <= new_node.key
              if cur_node.upper.nil?
                cur_node.upper = new_node
              else
                cur_node = cur_node.upper
              end
            end 
          end # end of while
        end
      end

      def delete key
        check_key key

        cur_node = @root
        parent = nil
        while !cur_node.nil?
          if cur_node.key == key
            if parent.nil?
              @root = nil
            else
              if parent.lower == cur_node
                parent.lower = nil
              else
                parent.upper = nil
              end
            end

            add cur_node.lower unless cur_node.lower.nil?
            add cur_node.upper unless cur_node.upper.nil?
            return cur_node.value
          else
            if cur_node.key < key
              parent = cur_node
              cur_node = cur_node.upper
            else
              parent = cur_node
              cur_node = cur_node.lower
            end
          end
        end
        nil
      end

      def interval lower, upper, node = @root
        check_key lower
        check_key upper

        select do |key|
          lower <= key && key <= upper
        end
      end

      def find key
        check_key key

        cur_node = @root
        until cur_node.nil?
          if cur_node.key == key
            return cur_node.value
          elsif
            if cur_node.key > key
              cur_node = cur_node.lower
            else
              cur_node = cur_node.upper
            end
          end
        end
        nil
      end

      def select node = @root, &block
        if node.nil?
          []
        else
          rs = []
          rs << node.value if block.call(node.key)
          rs += (select node.lower, &block)
          rs += (select node.upper, &block)
        end
      end

      def count node = @root
        if node.nil?
          0
        else
          1 + (count node.lower) + (count node.upper)
        end
      end

      def check_key key
        unless key.respond_to?(:<=>) && key.respond_to?(:<=)
          raise ArgumentError, 'key does not support #<=>' 
        end
      end
      private :check_key

      class Node
        attr_accessor :value, :lower, :upper
        attr_reader :key
        def initialize key, value
          @key = key
          @value = value
        end
      end
    end
  end
end
