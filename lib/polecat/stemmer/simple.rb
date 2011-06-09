module Polecat
  # simple stemmer for cleaning in a simple way
  #
  # This class can be used for cleaning strings in the most simple way. If it
  # does not do, what you intent it to do, inherit from Polecat::Stemmer and
  # implement your own.
  class SimpleStemmer < Polecat::Stemmer
    def stem word
      if word.class == Array
        word.each {|w| self.stem w }
      elsif word.class == String && word.length > 1
        word.gsub /(ing|ed)$/, ''
      else
        word
      end
    end
  end
end
