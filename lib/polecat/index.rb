class Polecat
  # storage of documents
  #
  # This is the core of the search platform, the index. It stores the documents,
  # stores and reads them and make them searchable.
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

    def write doc
      if (doc.kind_of? Document)
        @buffer << doc
      else
        raise ArgumentError, "not a document"
      end
    end

    # read all stored documents from the index files into the index
    def read
      index_file = @path + '/index.txt'
      if (File.exists? index_file)
        @documents = Marshal.load(File.read(index_file))
      end
    end

    def flush
      @documents += @buffer
      File.open @path + '/index.txt', 'w' do |file|
        file.write Marshal.dump(@documents)
      end
    end

    def search term
      matches = []
      linenr = 0
      @documents.each do |doc|
        doc.attributes.each do |key, value|
          matches << linenr if value[:value] =~ /#{term}/
        end
        linenr += 1
      end
      matches
    end
  end
end
