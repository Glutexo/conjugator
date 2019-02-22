module Conjugator
  class Imperative
    VOWEL_LIKES = ['a', 'e', 'i', 'o', 'u', 'y', 'l', 'r']
    ENDING_CHANGES = {'k' => 'č', 'n' => 'ň'}
    
    class << self
      def strip_ending(third_person_plural)
        match = third_person_plural.match(/^(.+)(ou|í)$/)
        raise ArgumentError if match.nil?
        match[1]
      end
      
      def make_imperative(without_ending)
        transformations = [
          # Add -i if ends with a consonant cluster.
          lambda do |word|
            if ends_with_two_consonants?(word)
              word
            else
              "#{word}i"
            end
          end,
          
          # Change the ending consonant.
          lambda do |word|
            word.sub(/.$/) do |match|
              if ENDING_CHANGES.key?(match[0])
                ENDING_CHANGES[match[0]]
              else
                match[0]
              end
            end
          end,
          
          # Change the ending vowel.
          lambda do |word|
            word.sub(/aj$/, 'ej')
          end
        ]
        transformations.reduce(without_ending) do |word, transformation|
          transformation.call(word)
        end
      end
      
      private
      
      def vowel_like?(letter)
        VOWEL_LIKES.include?(letter)
      end
      
      def ends_with_two_consonants?(word)
        vowel_like?(word[-1]) || vowel_like?(word[-2])
      end
    end
  end
end
