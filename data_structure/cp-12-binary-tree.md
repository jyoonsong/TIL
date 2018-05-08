# Ch.12 Binary Trees

### Definition

- **Linked Data Structures**

  a set of **linked objects**, each storing one element and one or more reference(s) to other element(s)

  예: `LinkedList` `TreeSet` `TreeMap`



### ListNode

- each node object stores 

  - one piece of data
  - a reference to another list node

- **can be linked into chains to store a list of values**

  ```java
  list1 = new Node (9);
  list2 = new Node (17, list1);
  list3 = new Node(-3, list2);
  list4 = new Node(42, list3);
  
  // 한 줄로 하면
  list = new Node(42, new Node(-3, new Node(-17, new Node(9))));
  
  // next를 사용하면
  list.data = 42;
  list.next = new Node(-3);
  list.next.next = new Node(17);
  list.next.next.next = new Node(9);
  
  // 모두 결과는
  list=> data:42 next=> data:-3 next=> data:17 next=> data:9 next:null
  ```

- implementation

  ```java
  public class ListNode {
      int data;
      ListNode next;
  
      public ListNode(int data) {
          this(data, null);
      }
      public ListNode(int data, ListNode next) { 
          this.data = data;
          this.next = next;
      }
  }
  ```

- problem

  예: list1 => 10 => 20 / list2 => 30 => 40 에서 list1 => 10 => 30 => 20 / list2 => 40?

  ```java
  // `new` 사용
  list1.next = new ListNode(30, list1.next);
  list2 = list2.next
  
  // `new` 안 쓰고
  ListNode tmp = list1.next;	// 20 임시 보관
  list1.next = list2;			// list1에 30을 연결 (10 30 40)
  list2 = list2.next;			// list2에서 30 제외 (40)
  list1.next.next = tmp;		// list1의 30 뒤에 20을 연결 (10 30 20)
  ```

  수가 많아지면 헷갈린다.



### References vs. Objects

`variable = value;`

- `variable` is an arrow (the base of an arrow)

- `value` is an object (a box; what an arrow points at)

  ```java
  ListNode a = new Node(2), b = new Node(3), c;
  a.next = b; // b is value (a.next가 point하는 곳에 b가 들어감)
  c = a.next; // c is variable (c는 a.next와 함께 b를 가리키게 됨)
  
  d.next = e.next;
  // = Make the variable d.next refer to the same value as e.next
  // = Make d.next point to the same place that e.next points.
  
  ListNode curr = front;
  curr = null; // doesn't change the list
  ```



### Traversing a List

- print data values in all the nodes

```java
ListNode curr = list;
while (curr != null) {
    System.out.println(curr.data);
    curr = curr.next;
}
```



### LinkedList Class

- the list is internally implemented as a chain of linked nodes

  - front = reference to its front as a field
  - null = end of the list

  ```java
  public class LinkedList {
      private ListNode front;
      public LinkedList() {
          front = null; // empty list (front == end)
      }
  }
  ```

- **add**

  ```java
  // 마지막에 삽입
  public void add(int value) {
      if (front == null)
          front = new ListNode(value);
      else {
          ListNode curr = front;
          while (curr.next != null) // Don't fall off the edge!
              curr = curr.next;
          curr.next = new ListNode(value);
      }
  }
  // given index에 삽입
  public void add(int index, int value) {
      if (index == 0)
          front = new ListNode(value, front);
      else {
          ListNode curr = front;
          for (int i = 0; i < index; i++) // 그 index 현재 차지한 녀석까지
              curr = curr.next;
          curr.next = new ListNode(value, curr.next);
      }
  }
  ```

- **get**

  ```java
  public int get(int index) { // 0 <= index <= size() -1 가정
      ListNode curr = front;
      for (int i = 0; i < index; i++)
          curr = curr.next;
      return curr.data;
  }
  ```

- **remove**

  ```java
  // 첫번째를 삭제
  public int remove() {
      if (front == null)
          throw new NoSuchElementException();
      else {
          int result = front.data;
          front = front.next;
          return result;
      }
  }
  // given index를 삭제
  public void remove(int index) {
      if (index == 0)
          front = front.next;
      else {
          ListNode curr = front;
          for (int i = 0; i < index -1; i++) // 삭제 대상 직전까지
              curr = curr.next;
          curr.next = curr.next.next; // curr은 (index-1) 번째
      }
  }
  ```

  

### 응용: addSorted

```java
// adds given value to a sorted list in sorted order
public void addSorted(int value) {
    if (front == null || // empty list인 경우
        value <= front.data) // insert at front of list
        front = new ListNode(value, front);
    else {
        ListNode curr = front;
        while (curr.next != null && // 젤 큰 값 넣을 때 NullPointer에러 방지
               curr.next.data < value) // next아니면 stops too late
            curr = curr.next;
        // 현재 curr < value <= curr.next
        curr.next = new ListNode(value, curr.next);
    }
}
```



### Abstact Class

- hybrid between an `interface` and `class`

  defines a **super class type** that can contain

  - **method declarations** like `interface` AND/OR

    declare generic behaviors that subclasses must implement

  - **method bodies** like `class`

    implementation of common state and behavior that will be inherited by subclasses

- `abstract` vs `class`

  - abstract methods**can claim to implement an interface without writing its methods**
  - subclasses must implement the methods

- `abstract` vs `interface`

  - abstract = interface처럼 method declaration + class처럼 method bodies
  - interface = 오로지 method declaration

- abstract이 interface역할과 함께 더 많은 걸 할 수 있는데 **그럼에도 `interface` 왜 쓰는가?**

  Having interfaces allows a class to be part of a hierarchy (polymorphism) without using up its inheritance relationship.

  - can **extend only one superclass** (abstract class)
  - can **implement many interfaces**

```java
// abstract vs interface
public interface ConsoleCommand {
    void parse(String input) throws CommandParseException;
}
public abstract class Name implements ConsoleCommand {
    // non-abstract mehtod도 가질 수 있음
    @Override 
    public void parse(String input) throws CommandParseException {
        String[] args = input.split(" *% *%? *");
        if (input.isEmpty())
            args = new String[0];
        parseArguments(args);
    }
    public abstract type name(parmas); // any subclass must implement it
}

// abstract vs class
public abstract class Empty implements ConsoleCommand {} // NO ERROR
public class NoEmptyAllowed extends Empty() {} // ERROR
```

- A class can be abstract even if it has **no abstract methods** (O)
- You can create **variables (but not objects) of the abstract type** (O)