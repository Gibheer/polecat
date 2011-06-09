module Polecat
  # abstract class for stemmer
  #
  # This class can be used for inheritence for your own stemmer.
  # A stemmer is responsible to convert an document into an array of fragments
  # which then merged with the index. As every document can be built of
  # different words and fragments, the stemmer is very important to get the
  # best result when searching.
  #
  # Be warned, that you use the same stemmer for the index as for the search
  # input!
  #
  # To build your own stemmer implement the methods #stem and #result.
  class Stemmer
    # stems the word
    #
    # This method changes the word into a form, which get's interted into the
    # index.
    # @param [Object] word word to stem
    # @return [Object] the stemmed variant of the word or the same object
    def stem word
      raise NotImplementedError, 'please implement #stem'
    end
  end
end
