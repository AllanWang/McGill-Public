import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.LinkedList;

/**
 * Copy output to specified file and run the main method
 * The goal is to traverse the ops and ensure the order is consistent
 * If op starts with enq -> add id to tail
 * If op starts with deq -> remove head and assert head id == supplied id
 * A sequence is valid if all deq's are valid
 */
public class EnqDeqValidator {

    private static final String FILE = "out.txt";

    public static void main(String[] args) {
        try {
            String[] lines = Files.lines(Paths.get(FILE)).toArray(String[]::new);
            validate(lines);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static boolean validate(String[] data) {
        int i = 0;
        LinkedList<String> list = new LinkedList<>();
        boolean valid = true;
        for (String line : data) {
            String[] words = line.split(" ");
            if (words.length < 2)
                continue;
            String op = words[0].toLowerCase();
            String id = words[1];
            switch (op) {
                case "enq":
                    list.addLast(id);
                    break;
                case "deq":
                    if (list.isEmpty()) {
                        p("Failed %d: attempted to dequeue %s on empty list", i, id);
                        return false;
                    }
                    String actualId = list.removeFirst();
                    if (!id.equals(actualId)) {
                        p("Failed %d: dequeued %s, expected %s", i, actualId, id);
                        valid = false;
                    }
                    break;
                default:
                    continue;
            }
            i++;
        }
        p(valid ? "Ops validated" : "Ops are invalid");
        return valid;
    }

    private static void p(String s, Object... args) {
        System.out.println(String.format(s, args));
    }

}
