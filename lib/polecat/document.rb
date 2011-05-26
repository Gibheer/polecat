require 'polecat/document_resource'

class Polecat
  module Document
    OPTIONS = {
      :index => true,
      :lazy  => false,
      :value => nil
    }

    def self.included klass
      klass.extend(DocumentResource)
      klass.instance_variable_set :@attributes, {}
    end

    # creates a new document
    #
    # It is possible to create a new document with a hash, which has all values
    # of the fields.
    # Example:
    # class Foo
    #   include Polecat::Document
    #
    #   field :id
    #   field :description
    # end
    # f = Foo.new :id => 1, :description => 'foo'
    def initialize fields = {}
      fields.each do |key, value|
        attribute_set key, value
      end
    end

    # get an attribute of the document
    def attribute_get name
      attributes[name.to_sym][:value]
    end

    # set an attribute of the document
    def attribute_set name, value
      name = name.to_sym
      att = attributes
      if att.has_key? name
        att[name][:value] = value
      else
        raise ArgumentError, "attribute #{name} does not exist"
      end
    end

    # get all attributes
    def attributes
      return @attributes if @attributes
      @attributes = Marshal.load(Marshal.dump(
        self.class.instance_variable_get :@attributes))
    end
  end
end
