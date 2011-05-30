class Polecat
  # handles the writing of new documents to the index.
  #
  # This class is responsible for writing the documents to the index. It takes
  # a path on creation and checks, if it is an empty or a valid index directory.
  #
  # When the documents are getting written to the filesystem, a 'index.lock'
  # file is written as an extra lock. It then writes a new file into the
  # directory, which has all documents.
  class IndexWriter
    attr_reader :path

    # create a new IndexWriter
    #
    # This creates a new IndexWriter set to the given path.
    # @param [String] path the path to the index directory
    def initialize path
      if !File.directory? path
        raise ArgumentError, 'not a directory'
      elsif File.exists? path + '/index.lock'
        raise IOError, 'index is locked'
      else
        @path = path
        @documents = []
      end
    end

    # returns the count of elements not flushed
    #
    # This method returns the count of all elements stored in the Writer, but
    # not yet flushed to a file.
    # @return [Fixnum] count of files
    def count
      @documents.count
    end

    # add a new document to the writer
    #
    # This adds a Document to the temporary storage. Call #write to write them
    # to the filesystem.
    # @param [Document] doc the document to store
    def add doc
      if doc.kind_of? Polecat::Document
        @documents << doc
      else
        raise ArgumentError, 'not a document'
      end
    end

    # write all documents to the disc
    #
    # Write all stored documents to the disc and clear the buffer.
    # @return [Boolean] true when the write was a success
    def write
      lock_path = @path + '/index.lock'
      if File.exists?(lock_path)
        return false
      else
        FileUtils.touch(lock_path)
        last_file = Dir[@path + '/*.ind'].sort.last
        if last_file.nil?
          file_name = @path + '/ind0.ind'
        else
          number = File.basename(last_file).match(/[0-9]+/)[0].to_i
          # we have to match the complete name, because there can be
          # numbers before the file too
          file_name = last_file.gsub(
            /ind#{number}\.ind/,
            "ind#{(number + 1)}.ind"
          )
        end
        
        File.open file_name, 'w' do |file|
          file.write Marshal.dump(@documents)
        end

        @documents = []
        FileUtils.rm lock_path
        return true
      end
    end

    # creates an index reader with the writers path
    #
    # @returns [Polecat::IndexReader] an IndexReader with the same path
    def create_reader
      Polecat::IndexReader.new @path
    end
  end
end
