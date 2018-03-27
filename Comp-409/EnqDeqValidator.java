import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.LinkedList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * Copy output to specified file and run the main method
 */
public class EnqDeqValidator {

    private static final String FILE = "out.txt";

    public static void main(String[] args) {

        LinkedList<String> list = new LinkedList<>();

        try (Stream<String> stream = Files.lines(Paths.get(FILE))) {
            List<String[]> data = stream.map(line -> {
                String[] words = line.split(" ");
                if (words.length < 2)
                    return null;
                return words;
            }).filter(Objects::nonNull).collect(Collectors.toList());
            for (int i = 0; i < data.size(); i++) {

                String op = data.get(i)[0].toLowerCase();
                String id = data.get(i)[1];
                switch (op) {
                    case "enq":
                        list.addLast(id);
                        break;
                    case "deq":
                        if (list.isEmpty()) {
                            p("Failed %d: attempted to dequeue %s on empty list", i, id);
                            return;
                        }
                        String actualId = list.removeFirst();
                        if (!id.equals(actualId)) {
                            p("Failed %d: dequeued %s, expected %s", i, actualId, id);
                        }
                        break;
                    default:
                        p("Unknown flag %s", op);
                        break;
                }

            }
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    private static void p(String s, Object... args) {
        System.out.println(String.format(s, args));
    }

}
