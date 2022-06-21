class PigLatinizer

    LETTERS = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]    
    VOWELS = ['a','e','i','o','u','y']

    def piglatinize(input)
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

        if strings.first == [] then strings.shift end
        if word.count > 0 then strings << word end

        # strings is now an array of arrays
        # each array within strings is an array of characters
        # either all letters, or all non-letters
        strings

        # now I need to loop through the arrays
        # if the array has non-letter characters in it
        # I'll immediately concat it to a result array
        # otherwise I'll do the pig latin, then append
        # to result array
        result = ""

        for arr in strings do
            if !LETTERS.include?(arr.first.downcase) then
                # this is a non-letters array
                result.concat(arr.join)
            else
                # this is an array of letters
                if VOWELS.include?(arr.first.downcase) then
                    # this is a vowel-started word
                    # add way and send to result
                    result.concat(arr.join + "way")
                else
                    # this is a consonant-started word
                    # shovel shifted characters from the array
                    # until the first char is a vowel
                    # weird edge case to make sure there are vowels
                    if VOWELS.any? {|vowel| arr.include?(vowel) } then
                        until VOWELS.include?(arr.first.downcase) do
                            arr << arr.shift
                        end
                    end

                    result.concat(arr.join + "ay")
                end
            end
        end
        result

        # this is broken! turns into an infinite loop for the word "My"
    end
end