module DocumentResource
  def field name, options = {}
    attributes = self.instance_variable_get :@attributes
    attributes[name.to_sym] = Document::OPTIONS.merge(options)

    create_reader_for name
    create_writer_for name
  end

  def mod
    if !@mod
      @mod = Module.new
      self.class_eval do
        include @mod
      end
    end
    @mod
  end

  def create_reader_for name
    mod.module_eval <<-RUBYCODE
      def #{name.to_s}
        attribute_get :#{name}
      end
    RUBYCODE
  end
  
  def create_writer_for name
    mod.module_eval <<-RUBYCODE
      def #{name.to_s}= o
        attribute_set :#{name}, o
      end
    RUBYCODE
  end
end
