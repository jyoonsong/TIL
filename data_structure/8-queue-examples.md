# Ch.08 Queue - Application

### Ex1. Recognizing Palindromes

Palindromes = {w | w reads the same left to right as right to left}

```java
boolean isPal(w) {
    for (i = 1 to w.length()) {
        queue.enqueue( w[i] );
        stack.push( w[i] );
    }
    // start to compare
    while (!queue.isEmpty()) { // !stack.isEmpty() 해도 똑같음
        if (queue.dequeue() != stack.pop()) return false;
    }
    // finished with empty queue & empty stack
    return true;
}
```

---

