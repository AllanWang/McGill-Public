/**
 * Created by Allan Wang on 18/10/2017.
 */
public class Scores {

    public static void main(String[] args) {
        //test
        System.out.println(scoreString("belloo 123")); //should be 95
        System.out.println(scoreString("bookkeeper")); //should be 105
        System.out.println(findMaxString(new String[]{"belloo 123", "bookkeeper"})); //should be bookkeeper
    }

    /**
     * Return a character's score based on the following table:
     * <p>
     * Character       |    Score
     * ---------------------------
     * b, m, or g      |    5
     * (lowercase)     |
     * |
     * Any digit (0-9) |    10
     * |
     * A space         |    -10
     * |
     * Anything else   |    0
     * <p>
     * Note that a return will stop the method,
     * which is why you don't need else in this case
     */
    public static int scoreChar(char input) {
        if (input == 'b' || input == 'm' || input == 'g') {
            return 5;
        }
        if (input >= '0' && input <= '9') {
            return 10;
        }
        if (input == ' ') {
            return -10;
        }
        return 0;
    }

    /**
     * Returns an integer score of a given string,
     * which is the sum of the scores of each character
     * <p>
     * Add 30 whenever there are two of the same characters in a row
     * <p>
     * Add the length of the String to the score
     */
    public static int scoreString(String input) {
        char prevChar = '\0'; //holds the value of the previous character
        //this is defaulted to the null character (assuming it will never be in your string)
        int score = input.length(); //holds cumulative score of input; starts of as string length
        //note that this is created before the loop, as we want to keep the sum
        for (int i = 0; i < input.length(); i++) {
            char current = input.charAt(i);
            score += scoreChar(current);    //add score of current char
            if (current == prevChar) {      //check for two of the same characters
                score += 30;
            }
            prevChar = current;             //save current char for next iteration
        }
        return score;
    }

    /**
     * Given an array of Strings, return the String with the highest score
     */
    public static String findMaxString(String[] inputs) {
        String maxString = null; //holds current max String
        int maxScore = 0; //holds score of maxString above
        for (int i = 0; i < inputs.length; i++) {
            String currentString = inputs[i];
            int currentScore = scoreString(currentString);
            if (currentScore > maxScore) { //better score found; save String & score
                maxString = currentString;
                maxScore = currentScore;
            }
        }
        return maxString;
    }
}
