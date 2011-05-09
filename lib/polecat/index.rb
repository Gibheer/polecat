class Polecat
  class Index
    attr_reader :path

    # initialises an index object on the given path
    #
    # This method initialises an index on the path. The Path has to be a
    # directory.
    def initialize path
      if File.directory? path
        @path = path
      else
        raise ArgumentError, "Argument no valid directory"
      end
    end

    # returns true, if it has an index
    def index_dir?
      File.exists?(@path + '/index.txt')
    end

    def write term
      File.open @path + '/index.txt', 'a' do |f|
        f.write "#{term}\n"
        f.flush
      end
    end

    def search term
      File.open @path + '/index.txt' do |f|
        linenr = 0
        while (line = f.gets) do
          return linenr if line =~ /#{term}/
          linenr += 1
        end
        nil
      end
    end
  end
end
