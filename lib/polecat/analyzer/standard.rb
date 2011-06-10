require 'polecat/stemmer/simple'

module Polecat
  # a simple analyzer which is enough for most english content
  #
  # This class analyzes content in a standard english way, which should be
  # enough for the most cases.
  # It splits words of the content at whitespaces and applies the stemmer on
  # every part found.
  class StandardAnalyzer
    # return the used stemmer
    # @return [Stemmer, #stem] an object which knows the method #stem
    attr_reader :stemmer

    # create a new analyzer
    #
    # This creates a new analyzer with the given stemmer or a simple stemmer. A
    # stemmer has to know the method stem, as it is used in the analyzer to
    # stem the chunks found in the content.
    #
    # As this is a standard analyzer it should work for most cases. Change the
    # stemmer if the words found do not match your expectations.
    # @param [Stemmer, #stem] a stemmer with the method #stem
    def initialize(stemmer = Polecat::SimpleStemmer.new)
      unless stemmer.respond_to? :stem
        raise ArgumentError, 'stemmer does not know #stem'
      end
      @stemmer = stemmer
    end

    # analyzes the content and stems every chunk found
    #
    # This method splits the content into chunks and applies the stemmer on it.
    # The result get's put into the index.
    def analyze content
      unless content.respond_to? :split
        raise ArgumentError, "#{content.class} has no #split"
      end
      content.split(/\s/).map {|w| @stemmer.stem w }
    end
  end
end
