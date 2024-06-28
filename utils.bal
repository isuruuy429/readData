import ballerina / random;
                        
    function shuffleSubstring(string input, int startIndex, int length) returns string|random:Error {
        if (startIndex < 0 || startIndex + length > input.length()) {
            return input; // Invalid parameters, return original string
        }

        // Extract the specified substring
        string substringToShuffle = input.substring(startIndex, startIndex + length);

        // Convert the substring to a string array
        string[] charArray = [];
        foreach int i in 0 ..< substringToShuffle.length() {
            charArray.push(substringToShuffle.substring(i, i + 1));
        }

        // Shuffle the string array
        charArray = check shuffleStringArray(charArray);

        // Convert the shuffled string array back to a string
        string shuffledSubstring = "";
        foreach string char in charArray {
            shuffledSubstring += char;
        }

        // Replace the specified substring in the original string with the shuffled characters
        string newString = input.substring(0, startIndex) + shuffledSubstring + input.substring(startIndex + length);

        return newString;
    }

    // Function to shuffle a string array
    function shuffleStringArray(string[] charArray) returns string[]|random:Error {
        int length = charArray.length();
        foreach int i in 0 ..< length {
            int j = check random:createIntInRange(0, length);
            string temp = charArray[i];
            charArray[i] = charArray[j];
            charArray[j] = temp;
        }
        return charArray;
    }

