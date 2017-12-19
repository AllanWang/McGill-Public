# A few pointers for your midterm

## Arrays

1. If there are any questions with arrays and for loops, check for `ArrayOutOfBoundsExceptions`.
1. If loops change the values of arrays based on other indices of the same array, write down the changed values. 
They may affect the end of the loop!
<br><br>For instance, what prints?
```java
int[] a = {1, 2, 3, 4, 5};
for (int i = 0; i <= a.length; i++) {
  a[i % a.length] = a[(i + 1) % a.length] + 1;
}
System.out.println(Arrays.toString(a));
```

## If Else
1. If you encounter an `if` without an `else` or `else if`, any proceeding `if`s will still be executed. These blocks are not nested:

```java
int x = 0;
//block 1
if (x > 0) {
  x = 2;
} else {        //called
  //this is a nested block
  if (x == 0) {
    x--;        //called
  } else {
    x++;
  }
  x--;          //called; x = -1
}
//block 2
if (x >= 0) {
  x = 5;        //not called
}
//block 3
if (x == 5) {
  x = 2;
} else {
  x = 1;        //called
}
//result: x = 1
```

## Know the Basics

Which types can be auto casted into which other types? 
How do you properly cast to a float when dividing two ints? 
(What is a garbage collector?)

## Know the Order & Be Careful

What prints?

```Java
public static int m(int x, int y) {
  System.out.println(x++);
  System.out.println(++y);
  return x + y + 2;
}

public static void main(String[] args) {
  int x = 2;
  int y = 5;
  System.out.println(m(y, x));
}
```

This is probably the most important point. 
Especially when you're new to programming, you'll see that small, sometimes unnoticable differences may change a method entirely.

Good luck!
