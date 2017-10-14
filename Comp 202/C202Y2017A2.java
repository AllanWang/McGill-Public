import java.util.HashSet;
import java.util.Set;

/**
 * Created by Allan Wang on 2017-10-13.
 * <p>
 * Put this class in the same folder as Mexico.java
 * and run this class with no arguments
 */
public class MexicoTest {

    public static void main(String[] args) {
        diceRoll();
        getScore();
        getWinner();
        canPlay();
        if (errorLess)
            p("Congratulations; no errors found!");
        else
            p("An error was found somewhere above");
    }

    private static void diceRoll() {
        header("Dice Roll");
        Set<Integer> data = new HashSet<Integer>();
        for (int i = 0; i < 1000; i++) {
            int val = Mexico.diceRoll();
            if (val < 1 || val > 7) {
                p("Invalid dice roll value found: %d", val);
                return;
            }
            data.add(val);
            if (data.size() == 6)
                return;
        }
        p("After 1000 iteration, we still did not receive all values from 1 - 6; something may be wrong");
    }

    private static void getScore() {
        header("Get Score");
        assertScore(1, 1, 11);
        assertScore(1, 2, 21);
        assertScore(2, 1, 21);
        assertScore(4, 5, 54);
    }

    private static void getWinner() {
        header("Get Winner");
        assertGiulia(21, 66);
        assertGiulia(21, 54);
        assertDavid(22, 33);
        assertDavid(65, 11);
        assertTie(21, 21);
        assertTie(55, 55);
        assertTie(13, 13);
    }

    private static void canPlay() {
        header("Can Play");
        assertPlay(10, 5, true);
        assertPlay(10, 10, true);
        assertPlay(2, 4, false);
        assertPlay(3, 2, false);
        assertPlay(-4, 2, true);
    }

    private static void assertPlay(double buy, double bet, boolean exp) {
        assertTrue(exp == Mexico.canPlay(buy, bet),
                String.format("Expected buy of %f amd bet of %f to result in '%b', but failed", buy, bet, exp));
    }

    private static void assertScore(int r1, int r2, int score) {
        assertTrue(score == Mexico.getScore(r1, r2), String.format("Inputs %d & %d did not result in %d", r1, r2, score));
    }

    private static void p(String s, Object... o) {
        System.out.println(String.format(s, o));
    }

    private static boolean errorLess = true;

    private static void header(String header) {
        p("\n-----------------------------");
        p(header);
        p("-----------------------------\n");
    }

    private static void assertTrue(boolean condition, String message) {
        if (!condition) {
            p(message);
            errorLess = false;
        }
    }

    private static void assertTie(int score1, int score2) {
        assertTrue("tie".equalsIgnoreCase(Mexico.getWinner(score1, score2)),
                String.format("Result for scores %d & %d was not a tie", score1, score2));
    }

    private static void assertGiulia(int score1, int score2) {
        assertTrue("Giulia".equalsIgnoreCase(Mexico.getWinner(score1, score2)),
                String.format("Result for scores %d & %d was not Giulia", score1, score2));
    }

    private static void assertDavid(int score1, int score2) {
        assertTrue("David".equalsIgnoreCase(Mexico.getWinner(score1, score2)),
                String.format("Result for scores %d & %d was not David", score1, score2));
    }


}
