class PigLatinizer

    LETTERS = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]    
    VOWELS = ['a','e','i','o','u','y']

    def piglatinize(input)
        
        # Turn input into an array of arrays
        # Each array is an array of characters
        # Each array contains either ONLY letters or ONLY non-letters
        strings = input_to_arrays(input)

        # Turn this array of arrays into the corrected arrays
        arrays_to_piglatin_arrays!(strings)

        # Flatten the arrays into one level and join into a string
        strings.flatten.join
    end

    def input_to_arrays(input)

        chars = input.chars
        strings = []

        # this loop takes the array of characters from
        # the input string, and splits it into
        word = []
        inword = false
        for c in chars do
            if LETTERS.include?(c.downcase) then
                if inword then
                    word << c
                else
                    strings << word
                    word = [c]
                    inword = true
                end
            else
                if !inword then
                    word << c
                else
                    strings << word
                    word = [c]
                    inword = false
                end
            end
        end

        # handle a single non-consonant start creating
        # an empty array in my array
        if strings.first == [] then strings.shift end
          
        # handle the fact that the last word will not be
        # added to the string by the last character
        if word.count > 0 then strings << word end

        # strings is now an array of arrays
        # each array within strings is an array of characters
        # either all letters, or all non-letters
        strings
    end
    
    # given an array of arrays, apply piglatin, and return string
    def arrays_to_piglatin_arrays!(arrays)
        arrays.each {|arr| piglatinize_word_array!(arr)}

        arrays
    end

    # given an array of characters, modify it to its piglatinized version
    def piglatinize_word_array!(arr)
        if VOWELS.include?(arr.first.downcase) then
            # this is a vowel-started word
            # just add way
            arr << "way"
        elsif LETTERS.include?(arr.first.downcase) then
            # this is a consonant-started word

            # shovel shifted characters from the array
            # until the first char is a vowel

            # be sure to check there is at least one vowel in this word!
            if VOWELS.any? {|vowel| arr.include?(vowel) } then
                until VOWELS.include?(arr.first.downcase) do
                    arr << arr.shift
                end
            end

            arr << "ay"
        end
        # else, this is not a word of letters, so no modification necessary
    end


end

# gets all non character strings (although adds a "" to the beginning if starts with a non-letter):
# "asdf as f DDDd   f f  ... . .d asdf".split(/[a-z,A-Z]+/)

# gets all the character strings:
# "asdf as f DDDd   f f  ... . .d asdf".split(/[^a-z,A-Z]+/)

# so for recombining, would literally just recombine starting with non-character strings and alternate