# Ch.10 Recursion

### Definition

- **recursion**

  The definition of an operation in terms of itself

  - solving a problem using recursion depends on solving smaller occurences of the same problem.

- **recursive programming**

  Writing methods that call themselves to solve problems recursively

  - an equally powerful substitue for *iteration (loops)*

- **recursion zen**

  the art of properly identifying the best set of cases for a recursive algorithm and expressing them elegantly



### Cases

> some have **more than 1** base or recursive case, but all have **at least 1 of each**

- **base case** >= 1

  A simple occurrence that can be answered directly. 

- **recursive case** >= 1

  A more complex occurrence of the problem that cannot be directly answered, but can instead be described in terms of smaller occurrences of the same problem.



### Examples

```java
public static void printStars(int n) {
    if (n == 1) // base case
        System.out.println("*");
    else {
        System.out.print("*");
        printStars(n - 1);
    }
}
```

```java
// sum of digits into 1-digit number
// 648 => *72* (18이 아님에 주의!) => 9
public static int mystery(int n) { 
    if (n < 10)
        return n;
    else {
        int a = n / 10;
        int b = n % 10;
        return mystery(a + b);
    }
}
// double each digit
// 348 => 334488
public static int mystery(int n) {
    if (n < 10) 
        return (10 * n) + n;
    else {
        int a = mystery(n / 10);
        int b = mystery(n % 10);
        return (100 * a) + b;
    }
}
```

```java
/* 
not optimized 
예: 3^12 => pow를 11번 call함
*/
public static int pow(int base, int exponent) {
    if (exponent == 0) // base case
        return 1;
    else { // recursive case: x^y = x * x^(y-1)
        return base * pow(base, exponent - 1)
    }
}
/* 
optimized

예(2-1): pow 6번 call함.
pow(3, 12)			= 3^12
pow(3*3, 6) 		= 9^6
pow(9*9, 3) 		= 81^3
81 * pow(81, 2) 	= 81 * 81^2
pow(81*81, 1)		= 6561^1
6561 * pow(6561, 0) = 6561 * 6561^0

예(2-2): pow 5번 call함. 
pow(3, 12)			= 3^12
pow(3*3, 6) 		= 9^6
pow(9*9, 3) 		= 81^3
81 * pow(81*81, 1) 	= 81 * 6561^1
6561 * pow(6561, 0) = 6561 * 6561^0
*/
public static int pow(int base, int exponent) {
    if (exponent == 0) // base case
        return 1;
    else if (exponent % 2 == 0) // recursive case 1 : x^y = (x^2)^(y/2)
        return pow(base * base, exponent / 2);
    else { // recursive case 2 : x^y = x * x^(y-1)
        return base * pow(base, exponent - 1)
    }
    // 혹은 홀수로 처리할 수 있음
    else { // recursive case 2 : x^y = x * (x^2)^(y/2)
        return base * pow(base * base, exponent / 2);
    }
}
```

```java
// given integer's binary representation
public static void printBinary(int n) {
    if (n < 2) // base case: same as base 10
        System.out.println(n);
    else { // recursive case
        // if N's binary representation is	1001010110011
		// (N/2)'s binary representation is	100101011001
		// (N%2)'s binary representation is			    1
        printBinary(n / 2);
        printBinary(n % 2);
    }
}
```

```java
// check if string is palindrome
public static boolean isPalindrome(String s) {
    if (s.length() < 2) // base case
        return true;
    else {
        char first = s.charAt(0);
        char last = s.charAt(s.length() - 1);
        if (first != last)
            return false;
        // recursive case
        String middle = s.substring(1, s.length() -1);
        return isPalindrome(middle);
    }
}
// shortened version
public static boolean isPalindrome(String s) {
    if (s.length() < 2) // base case
        return true;
    else
        return s.charAt(0) == s.charAt(s.length() - 1) && 
            isPalindrome(s.substring(1, s.length() -1));
}
```

``` java
// prints information about this file
// and (if directory) any files inside it
public static void crawl(File f) {
    crawl(f, ""); // call private recursive helper
}
// Recursive helper to implement crawl/indent behavior
private static void crawl(File f, String indent) {
    System.out.println(indent + f.getName());
    if (f.isDirectory()) {
        // recursive case: print contained files/dirs
        for (File subFile : f.listFiles())
            crawl(subFile, indent + "\t");
    }
}
```



=> **public / private pairs**

- We cannot vary the indentation without an extra parameter

  Often the parameters we need for our recursion do not match those the client will want to pass. 

  In these cases, we instead write a pair of methods

  - a public, non-recursive one : with the parameters the client wants
  - a private, recursive one : with the parameters we really want

