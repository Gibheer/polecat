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
        @buffer = []
        @documents = []
      else
        raise ArgumentError, "Argument no valid directory"
      end
    end

    # returns the document count currently loaded
    def count
      @documents.count
    end

    # returns true, if it has an index
    def index_dir?
      File.exists?(@path + '/index.txt')
    end

    def write term
      @buffer << term
    end

    # read all stored documents from the index files into the index
    def read
      if (File.exists?(@path + '/index.txt'))
        @documents = Marshal.load(File.read(@path+'/index.txt'))
      end
    end

    def flush
      @documents += @buffer
      File.open @path + '/index.txt', 'w' do |f|
        f.write Marshal.dump(@documents)
      end
    end

    def search term
      matches = []
      linenr = 0
      @documents.each do |line|
        matches << linenr if line =~ /#{term}/
        linenr += 1
      end
      matches
    end
  end
end
