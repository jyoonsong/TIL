# Ch.09 Sorting

### 정의

- Stack - LIFO(Last In First Out)

- Queue - FIFO (First In First Out) 

  > 민주적 ㅋㅋ 대부분의 줄 서기에 적용. (급식줄, 오래된 우유부터 먹기 등)
  >
  > 새치기 기능 있지만 나중에 배울 것

------

### Interface

```java
public interface QueueInterface {
    public boolean isEmpty( );
    public void enqueue(Object newItem); 
    public Object dequeue( ); // remove the earliest added item
    public void dequeueAll( );
    public Object peek( ); // retrieve the earliest added item
}
```

---

### Circular Queue

- 문제점 - `front=0` `back+1`만 해줌 : Rightward drift can cause the queue to **appear full**

  ![image](https://user-images.githubusercontent.com/17509651/39081397-97286a94-457b-11e8-8292-968246822c91.png)

- 해결책 - **Circular Queue** : `front+1` `back+1` 하며 돌리면서 운영하면 된다.

  ![image](https://user-images.githubusercontent.com/17509651/39081414-db235e84-457b-11e8-854f-ad481bba361e.png)

  - `empty` : front passes back 

  - `full` : back catches up front 

    > 골치아프니 numItems 도입으로 해결

---

### 1. Array-based Implementation (Circular)

```java
public class QueueArrayBased implements QueueInterface {
    final int MAX_QUEUE = 50;
    private Object items[];
    private int front, back, numItems; // Circular
    
    public QueueArrayBased() {
        items = new Object[MAX_QUEUE];
        front = 0;
        back = MAX_QUEUE - 1;
        numItems = 0;
    }
    public boolean isEmpty() {
        return (numItems == 0);
    }
    public boolean isFull() {
        return (numItems == MAX_QUEUE);
    }
    public void enqueue(Object newItem) {
        if (!isFull()) {
          	back = (back+1)%MAX_QUEUE; // MAX-1에서 0 넘어가는 예외를 고려. 이를 제외하면 back = back+1과 동일하다
            items[back] = newItem;
            numItems;
        } else FullException
    }
    public Object dequeue() {
        if (!isEmpty()) {
          	Object queueFront = items[front];
            front = (front+1)%MAX_QUEUE; // 직접적 삭제 안해줘도 나중에 차례가 돌아오면 enqueue하면서 저절로 사라지게 됨.
            --numItems;
            return queueFront;
        } else EmptyException
    }
    public void dequeueAll() {
        items = new Object[MAX_QUEUE]; // 기존 데이터는 garbage collection 처리 대상이 됨 (same with stack)
        front = 0; // array-based에서는 front, back, numItems만 바꾸면 나머진 다 그대로 차지. 낭비.
        back = MAX_QUEUE -1;
        numItems = 0;
    }
    public Object peek() {
        if (!isEmpty()) return items[front];
        else EmptyException
    }
}
```



---

### 2. Reference-based Implementation (Circular)

1. **Linear** Linked List with **2 external references** (front, back)

   > Stack은 Linear Linked List with 1 external reference (stackTop 즉 head)

   ![image](https://user-images.githubusercontent.com/17509651/39081578-e4122072-457e-11e8-9da1-12180cac2c62.png)

2. **Circular** Linked List with **1 external references** (back = lastNode)

   ![image](https://user-images.githubusercontent.com/17509651/39081580-eb689b26-457e-11e8-8e89-ac072f5f6d09.png)

```java
public class QueueReferenceBased implements QueueInterface {
    private Node lastNode; // back
    public QueueReferenceBased() {
        lastNode = null;
    }
    public boolean isEmpty() {
        return (lastNode == null);
    }
    public void enqueue(Object newItem) { // 3개의 화살표 처리
        Node newNode = new Node(newItem);
        if (isEmpty()) 
            newNode.setNext(newNode); // 자신이 자신을 가리킴
        else {
            newNode.setNext(lastNode.getNext()); // newNode가 front를 가리키도록 함
            lastNode.setNext(newNode); // 원래 lastNode였던 녀석이 newNode를 가리키도록 함
        }
        lastNode = newNode; // lastNode가 newNode를 가리키도록 함
    }
    public Object dequeue() {
        if (!isEmpty()) {
            Node firstNode = lastNode.getNext();
            if (firstNode == lastNode) // 자신이 자신을 가리킴 = only 1 node
                lastNode = null;
            else // more than 1 node
            	lastNode.setNext(firstNode.getNext());
            return firstNode.getItem();
        } else EmptyException
    }
    public void dequeueAll() {
        lastNode = null; // linked list는 애초에 array처럼 storage를 할당받는 것이 아니므로, lastNode 없애면 다 지울 대상이 된다 (same with stack)
    }
    public Object peek() { // lastNode.getNext() is firstNode
        if (!isEmpty()) return lastNode.getNext().getItem();
        else EmptyException
    }
}
```

- `enqueue`

  ![image](https://user-images.githubusercontent.com/17509651/39081643-1249ccb4-4580-11e8-8dd7-96c3e6dc18a8.png)

- `dequeue`

  ![image](https://user-images.githubusercontent.com/17509651/39081697-d02fccba-4580-11e8-8b25-bc2a2691bb8c.png)

------

### 3. "ADT List"-based Implementation (Non-Circular)

- Queue을 구현하기 위해 앞에 만들어 놓은 `ListReferenceBased` Class를 가져다가 한 레벨 더 abstraction 해보자 - 5과 참고

- 아래 코드는 **list position 1을 queueFront으로 삼겠다고 그냥 결정해버린 것.** 결정하기 나름.

  > 여기서는 Stack과의 유일한 차이 = enqueue
  >
  > Stack은 last가 top에 가있고, Queue는 frist가 front에 간다. remove는 알아서 차이남.

```java
public class QueueListBased implements QueueInterface {
    private ListInterface list; 

    public QueueListBased( ) {
        list = new ListReferenceBased( );
    }
    public boolean isEmpty() {
        return list.isEmpty();
    }
    public void enqueue(Object newItem) {
        list.add(list.size()+1, newItem); // 뒤에 add (얘만 stack과 다름!)
    }
    public Obejct dequeue() {
        if (!list.isEmpty()) { // 앞을 remove
            Object queueFront = list.get(1);
            list.remove(1);
            return queueFront;
        } else EmptyException;
    }
    public popAll() {
        list.removeAll();
    }
    public Object peek() {
        if (!isEmpty) return list.get(1); // 앞을 get
        else EmptyException
    }
}
```

