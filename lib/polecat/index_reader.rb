class Polecat
  # reads an index directory
  #
  # This class reads the content of an index directory and builds the
  # necessary structures for the index type.
  class IndexReader
    attr_reader :path

    # initialize a new reader
    #
    # Create a new reader for the given path. If the directory is empty, you
    # will get an empty index, else all documents stored in that directory.
    # @param [String] path the path to the index directory
    def initialize path
      @path = path
      raise ArgumentError, 'no valid directory' unless File.directory? @path
    end

    # read the content of the directory
    #
    # Read all files of the directory and return an index object.
    # @raise [IOError] raised when the directory is locked
    # @return [Polecat::Index] the index with all documents
    def read
      raise IOError, 'index is locked' if locked?
      files = Dir[@path + '/*']
      if files.count > 0
        documents = []
        files.each do |file|
          documents += Marshal.load(File.read(file))
        end
      else
        {}
      end
    end

    # checks whether the directory is locked or not
    def locked?
      if File.exists? @path + '/index.lock'
        true
      else
        false
      end
    end
  end
end
