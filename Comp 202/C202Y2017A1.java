import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Allan Wang on 2017-09-27.
 * <p>
 * Tester class for Comp 202, Fall 2017, Assignment 1
 * You may choose to run tasks selectively by commenting
 * out the method you don't want to run
 * <p>
 * This file should be located in the same directory as your other classes
 * To run the class, execute `run C202Y2017A1` with no further inputs
 * <p>
 * Note that for judge scores, this test will treat 4.0 as a bad response if 4 is expected
 * This may not be the case for your actual marking, but it is to match the sample given
 */
public class C202Y2017A1 {

    public static void main(String[] args) {
        testIsbn();
        testDayOfWeek();
        testJudgeScore();
        if (errorLess) h("All tests passed!");
    }

    private static void testIsbn() {
        h("Begin ISBN Tests");
        testIsbn(2956, 4);
        testIsbn(5724, 10);
        testIsbn(1521, 0);
        testIsbn(1000, 6);
        testIsbn(9999, 6);
    }

    private static void testIsbn(int num, int expected) {
        p("Test input %d", num);
        ISBN.main(s(num));
        assertEquals("ISBN error", expected == 10 ? "X" : String.valueOf(expected));
    }

    private static void testDayOfWeek() {
        h("Begin DayOfWeek Tests");
        testDayOfWeek(1953, 8, 2, "SUNDAY");
        testDayOfWeek(1893, 12, 26, "TUESDAY");
        testDayOfWeek(2000, 1, 1, "SATURDAY");
        testDayOfWeek(2000, 1, 3, "MONDAY");
        testDayOfWeek(2000, 1, 5, "WEDNESDAY");
        testDayOfWeek(2000, 1, 6, "THURSDAY");
        testDayOfWeek(2000, 1, 0, "FRIDAY");
    }

    private static void testDayOfWeek(int y, int m, int d, String expected) {
        p("Test input y=%d m=%d d=%d", y, m, d);
        DayOfTheWeek.main(s(y, m, d));
        assertEquals("DayOfWeek error", expected);
    }

    private static void testJudgeScore() {
        h("Begin JudgeScore Tests");
        testJudgeScore(1, 2, 3, 4, "2.5");
        testJudgeScore(3, 5, 3, 7, "4");
        testJudgeScore(10, 10, 10, 10, "10");
        testJudgeScore(4, 3, 2, 1, "2.5");
    }

    private static void testJudgeScore(int j1, int j2, int j3, int j4, String expected) {
        p("Test scores %d, %d, %d, %d", j1, j2, j3, j4);
        JudgeScore.main(s(j1, j2, j3, j4));
        assertEquals("JudgeScore error", expected);
    }

    private static String[] s(int... ii) {
        String[] s = new String[ii.length];
        for (int i = 0; i < s.length; i++)
            s[i] = String.valueOf(ii[i]);
        return s;
    }

    private static void clear() {
        output.clear();
    }

    private static final List<String> output = new ArrayList<String>();
    private static final PrintStream defaultStream = System.out;
    private static final PrintStream testStream = new PrintStream(System.out) {
        @Override
        public void println(int x) {
            output.add(String.valueOf(x));
        }

        @Override
        public void println(long x) {
            output.add(String.valueOf(x));
        }

        @Override
        public void println(float x) {
            output.add(String.valueOf(x));
        }

        @Override
        public void println(double x) {
            output.add(String.valueOf(x));
        }

        @Override
        public void println(String x) {
            output.add(x);
        }
    };

    private static boolean errorLess = true;

    static {
        System.setOut(testStream);
    }

    private static void h(String header) {
        p("\n---------------\n%s\n---------------\n", header);
        clear();
    }

    private static void p(String s, Object... args) {
        System.setOut(defaultStream);
        System.out.println(String.format(s, args));
        System.setOut(testStream);
        try {
            /*
             * This is not good practice!
             * Printing to the test stream takes time,
             * so this ensures that things are passed in an orderly fashion
             */
            Thread.sleep(100L);
        } catch (InterruptedException ignored) {

        }
    }

    private static void assertEquals(String msg, String... expected) {
        for (int i = 0; i < Math.min(output.size(), expected.length); i++) {
            if (!expected[i].equals(output.get(i))) {
                System.err.println(
                        String.format("%s: expected %s but printed %s",
                                msg,
                                expected[i],
                                output.get(i)));
                errorLess = false;
            }
        }
        clear();
    }
}