# Ch.07 Stack - Implementation

### 정의

- 유일하게 접근(remove, retrieve) 가능한 것이 맨위의 원소(most recently added item)
  - 이 원소의 값을 알아보는 것만 (가능)
  - 그 밑 원소 값 알아봐달라 (불가능)

------

### Interface

```java
public interface StackInterface {
    public boolean isEmpty( );
    public void push(Object newItem); 
    public Object pop( ); 
    public void popAll ( );
    public Object peek( );
}
```

---

### 1. Array-based Implementation

```java
public class StackArrayBased implements StackInterface {
    final int MAX_STACK = 50;
    private Object items[];
    private int top; // index for stack top
    
    public StackArrayBased() {
        items = new Object[MAX_STACK];
        top = -1;
    }
    public boolean isEmpty() {
        return (top < 0);
    }
    public boolean isFull() {
        return (top == MAX_STACK -1);
    }
    public void push(Object newItem) {
        if (!isFull()) items[++top] = newItem;
        // top++;	
        // items[top] = newItem; 를 한 줄로 합친 것
        else FullException
    }
    public Object pop() {
        if (!isEmpty()) return items[top--];
        // return items[top]; 
        // top--; 를 한 줄로 합친 것
        else EmptyException
    }
    public void popAll() {
        items = new Object[MAX_STACK]; // 기존 데이터는 garbage collection 처리 대상이 됨
        top = -1; // array-based에서는 top만 바꾸면 나머진 다 그대로 차지. 낭비.
    }
    public Object peek() {
        if (!isEmpty()) return items[top];
        else EmptyException
    }
}
```

![image](https://user-images.githubusercontent.com/17509651/39066828-73206008-4511-11e8-8538-67c6026194db.png)



---

### 2. Reference-based Implementation

- Linked List + Stack => Stack은 **앞**에 붙여야 할 것
- type은 `Node` type => 5과에서 등장한 범용 Node

```java
public class StackReferenceBased implements StackInterface {
    private Node top;
    public StackReferenceBased() {
        top = null;
    }
    public boolean isEmpty() {
        return (top == null);
    }
    public void push(Object newItem) {
        top = new Node(newItem, top); // 아래 두 가지를 한 줄로 한 것
        // Node newNode = new Node(newItem, top) : 위에 붙이고
        // top = newNode : top을 바꿔주고 
    }
    public Object pop() {
        if (!isEmpty()) {
            Node temp = top;
            top = top.getNext();
            return temp.getItem();
        } else EmptyException
    }
    public void popAll() {
        top = null; // linked list는 애초에 array처럼 storage를 할당받는 것이 아니므로, top 없애면 다 지울 대상이 된다
    }
    public Object peek() {
        if (!isEmpty()) return top.getItem();
        else EmptyException
    }
}
```



------

### 3. "ADT List"-based Implementation

- Stack을 구현하기 위해 앞에 만들어 놓은 `ListReferenceBased` Class를 가져다가 한 레벨 더 abstraction 해보자 - 5과 참고

- The **reuse** made the code simple

  > 사실 필요는 없다. 코드가 심플해지는 효과 정도.

  > 수행시간을 지배하는 부분의 코드는 abstraction level을 너무 높이면 치명적일 수 있다
  >
  > 하지만 요새는 성능이 워낙 좋다 보니 이런 일이 흔하지 않다.

- 아래 코드는 **list position 1을 stack top으로 삼겠다고 그냥 결정해버린 것.** 결정하기 나름.

```java
public class StackListBased implements StackInterface {
    private ListInterface list; 

    public StackListBased( ) {
        list = new ListReferenceBased( );
    }
    public boolean isEmpty() {
        return list.isEmpty();
    }
    public void push(Object newItem) {
        list.add(1, newItem); // 1에만 push
    }
    public Obejct pop() {
        if (!list.isEmpty()) { // 1만 pop
            Object tmp = list.get(1);
            list.remove(1);
            return tmp;
        } else EmptyException;
    }
    public popAll() {
        list.removeAll();
    }
    public Object peek() {
        if (!isEmpty) return list.get(1); // 1만 peek
        else EmptyException
    }
}
```

