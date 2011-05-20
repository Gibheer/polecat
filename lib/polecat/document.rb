require 'polecat/document_resource'

module Document
  OPTIONS = {
    :index => true,
    :lazy  => false,
    :value => nil
  }

  def self.included o
    o.extend(DocumentResource)
    o.instance_variable_set :@attributes, {}
  end

  def initialize fields = {}
    fields.each do |key, value|
      attribute_set key, value
    end
  end

  def attribute_get name
    attributes[name.to_sym][:value]
  end

  def attribute_set name, value
    if attributes.has_key? name.to_sym
      attributes[name.to_sym][:value] = value
    else
      raise ArgumentError, "attribute #{name} does not exist"
    end
  end

  def attributes
    return @attributes if @attributes
    @attributes = Marshal.load(Marshal.dump(
      self.class.instance_variable_get :@attributes))
  end
end
