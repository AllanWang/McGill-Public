# Concurrency

```java
try {
    lock.lock(); //Reentrant Lock
    // do stuff
} catch (InterruptedException e) {
    // handle stuff
    return; // finally will still be called
} finally {
    lock.unlock();
}
```

# Serialization

```java
public class Data {

    private String name;
    private int count;
    private String value;

    /**
     * @param name  must not have a space
     * @param count
     * @param value must not have a space
     */
    public Data(String name, int count, String value) {
        this.name = name;
        this.count = count;
        this.value = value;
    }

    public static Data deserialize(String data) {
        if (data.charAt(0) != '"' || data.charAt(data.length() - 1) != '"')
            throw new IllegalArgumentException("data not in serialized form");
        String[] parts = data.substring(1, data.length() - 1).split(" ");
        return new Data(parts[0], Integer.parseInt(parts[1]), parts[2]);
    }

    public String serialize() {
        return String.format("\"%s %d %s\"", name, count, value);
    }

    public static void write(String path, Data... data) throws IOException {
        try (PrintWriter out = new PrintWriter(new FileWriter(path))) {
            for (Data d : data)
                out.println(d.serialize());
        }
    }

    public static Data[] read(String path) throws IOException {
        List<Data> data = new ArrayList<>();
        try (BufferedReader in = new BufferedReader(new FileReader(path))) {
            for (String line = in.readLine(); line != null; line = in.readLine())
                data.add(Data.deserialize(line));
        }
        Data[] result = new Data[data.size()];
        data.toArray(result);
        return result;
    }

}
```