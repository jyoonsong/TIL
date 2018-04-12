# Ch.5 Linked List

> 1. 개념 
>    - 왜?
>    - 정의
> 2. Node 
>    - Head Node
>    - Dummy Head Node
> 3. Linked List 구현
>    - Interface
>    - Implementation
>    - 각 Operations
> 4. 응용 
>    - Doubly & Circular Linked List
>    - Mixed Structure
> 5. 예제 - Sparse Polynomial

### 왜?

| List (Array)                             | Linked List                              |
| ---------------------------------------- | ---------------------------------------- |
| + intuitively simple                     | - **overhead for linking**               |
| - **overflow** : 크기가 고정으로 reallocation이 필요 | + **no overflow** : 길이의 제한이 없음.          |
| - needs **shift** operation for insertion/deletion | + **free from shift overhead** for insertion/deletion |



### 개념



![b) insertion c) deletion](https://user-images.githubusercontent.com/17509651/38616361-c6dad1e6-3dce-11e8-94b0-da42c2aa34e4.png)





### Node (5-node 참고)

```java
public class Node {
		private Object item; // real object
		private Node next; // reference variable
  // Constructors
		public Node(Object newItem) {
			item = newItem;
			next = null;
		}
		public Node(Object newItem, Node nextNode) {
			item = newItem;
			next = nextNode;
		}
  // getters & setters
		public void setItem(Object newItem) {
			item = newItem;
		}
		public Object getItem( ) {
			return item;
		}
		public void setNext(Node nextNode) {
			next = nextNode;
		}
		public Node getNext( ) {
			return next;
		}
}
```

```java
Node n = new Node(new Integer(6));
// n이 가리키는 object의 item field에 6이 들어감
Node first = new Node(new Integer(9), n);
// first가 가리키는 object의 next field에 n이 가리키는 object에 대한 reference variable이 들어감
```

![image](https://user-images.githubusercontent.com/17509651/38617251-6e86955e-3dd1-11e8-89f0-bc8a6c2107f4.png)



### Head Node

Linked lists usually have a `head` reference = **a simple reference variable**

![image](https://user-images.githubusercontent.com/17509651/38617733-bafb6dd2-3dd2-11e8-970c-dc9a2646de3c.png)

```java
Node head = null; // reference variable만 선언됨. item, next 이런 fields 생성조차 안됨
Node head = new Node(new Integer(5)); // 5를 담고 있는 Object를 가리키기만 함.

// head에 getter&setter를 쓰면 
// head자체가 아닌 head가 가리키는 1st Node에 대해 get&set 하는 것
head.getItem(); // 5 = 1st Node
Node n = head.getNext(); n.getItem(); // 8 = 2nd Node
```

```java
for (Node curr = head; curr != null; curr = curr.getNext())
  System.out.println(curr.getItem()); // 5 8 ... 100
```

- method에 parameter로 linked list를 보낼 때는

  `printList(head)` 처럼 reference variable만 보내주면 됨

  ​

### Dummy Head Node

- Why? 

  No need of special handling related to the first node.

![image](https://user-images.githubusercontent.com/17509651/38620361-4063f9de-3dd9-11e8-8901-7ef4e8ac83ba.png)

- How? 

  **Constructor에서 initialization** 다르게 해주면 된다

```java
// before
public ListReferenceBased( ) {
  numItems = 0;
  head =  null; // 첫번째 노드의 주소 저장. 아직 첫번째 노드 없으므로 null
}
// after
public ListReferenceBased( ) {
  numItems = 0;
  head = new Node( ); // dummy head node
  head.setNext(null); // 일단 next는 null로 시작
}
```

- Utilization of Dummy Node

  We can use the empty item field to contain **List Information**

  ![image](https://user-images.githubusercontent.com/17509651/38627733-9fd5db10-3dea-11e8-94f0-3e52c90481ce.png)

  ```java
  public class ListInfo{
    private int length;
    private Object smallestItem, largestItem;
    // setters&getters
    ...
  }
  // 사용 예
  public ListReferenceBased( ) {
    // numItems = 0; 이제 불필요
    head = new ListInfo( ); // dummy head node
    head.setNext(null);
  }
  ```

  ​

---



### Operations

1. createList( )
2. isEmpty( )
3. size()
4. add(newPosition, newItem)
5. remove(index)
6. removeAll( )
7. get(index)



### Interface

```java
public interface ListInterface {
		// 위 operations를 그대로
		public boolean isEmpty( );
		public int size( );
		public void add(int index, Object item);
		public void remove(int index);
		public Object get(int index);
		public void removeAll( );
}
```



### Implementation

```java
Public class ListReferenceBased implements ListInterface {
		private Node head;
		private int numItems;
  // 1. createList
		public ListReferenceBased( ) {
			numItems = 0;
			head = new Node( );
			head.setNext(null);
		}
  // 2. isEmpty
		public boolean isEmpty( ) { 
			return numItems == 0;
		}
  // 3. size
		public int size( ) {
			return numItems;
		}
  // 4. add
 		public void add(int index, Object item) {
			if (index >= 1 && index <= numItems+1) {
              	Node prev = find(index – 1);
              	Node newNode = new Node(item, prev.getNext( ));
              	prev.setNext(newNode);
             	numItems++;
			} else {Exception handling;} 
		}
  // 5. remove
  		public void remove(int index) {
			if (index >= 1 && index <= numItems) {
				Node prev = find(index-1);
                Node curr = prev.getNext();
              	prev.setNext(curr.getNext());
                numItems--;
			} else {Exception handling;} 
		}
  // 6. removeAll
        public void removeAll() {
			
        }
  // 7. get
        public Object get(int index) {
			if (index >= 1 && index <= numItems) {
				Node curr = find(index);
				return curr.getItem( );
			} else {
				Exception handling;
			}
		}
		private Node find(int index) {
			Node curr = head; 
			for (int i = 1; i < index; i++) {
				curr = curr.getNext( );
			}
			return curr;
		}
  // getters & setters
		…

```



**자세히 하나하나 뜯어보자**

- `get` index => 해당 Node의 item

  - 우선 `find`로 index => 그 index Node reference variable

    > ADT operation을 만들기 위한 부속 method이므로 **private!!**

    ```java
    private Node find(int index) {
      // return reference to i th node
      Node curr = head;  // 1st node's reference
      for (int i = 1; i < index; i++) {
        // curr = ist node's reference : 1 ~ index-1
        curr = curr.getNext( );
        // curr = (i+1)st node's reference : 2 ~ index
      }
      return curr; // index st node's reference
    }
    ```

  - `.getItem` 이용

    ```java
    public Object get(int index) {
        Node curr = find(index); // index st node's reference
        return curr.getItem( ); // item field에 있는 object를 리턴
    }
    ```

  ​

- `delete`

  - what?

    - `curr`가 가리키는 Node 삭제하기.

      > curr의 바로 앞 Node는 `prev`가 가리킨다고 가정.

  - how?

    - Case1: 1st Node아닌 경우

      ![image](https://user-images.githubusercontent.com/17509651/38618655-466ac1e0-3dd5-11e8-8026-87f566ab9933.png)

    - Case2: 1st Node인 경우

      `head = head.getNext();` 

      Before: 1st Node의 주소

      After:  1st Node의 `next` field가 가리키던 2nd Node의 주소

      ![image](https://user-images.githubusercontent.com/17509651/38618706-62647486-3dd5-11e8-9912-d2e2e7de3663.png)

    ```java
    public void remove(int index) {
        // case 2
        if (index == 1) head = head.getNext( );
        // case 1
        else {
          Node prev = find(index – 1);
          Node curr = prev.getNext( );
          prev.setNext(curr.getNext( ));
        }
        numItems--;
    }
    ```

  - With Dummy Node? Just case1

    ```java
    public void remove(int index) {
      Node prev = find(index-1);
      Node curr = prev.getNext();
      prev.setNext(curr.getNext());
      numItems--;
    }
    ```

    ​

- `add`

  - what?

    - `prev`와 `curr` 사이에 Node 삽입하기

  - how?
    - Case1: 1st Node아닌 경우

    ![image](https://user-images.githubusercontent.com/17509651/38625944-84172fc2-3de6-11e8-81ad-3419769046bb.png)

    ​	마지막에 삽입하는 경우도 포함

    ![image](https://user-images.githubusercontent.com/17509651/38625958-8b98ae92-3de6-11e8-96cf-607e3fce858f.png)

    - Case2: 1st Node인 경우

      `head = head.getNext();` 

      Before: 1st Node의 주소

      After:  1st Node의 `next` field가 가리키던 2nd Node의 주소

      ![image](https://user-images.githubusercontent.com/17509651/38625951-86b10f82-3de6-11e8-8762-1622f9f00991.png)

    ```java
    public void add(int index, Object item) {
      // case 2
      if (index == 1) {
        Node newNode = new Node(item, head);
        head = newNode;
      }
      // case 1
      else {
        // prev reference
        Node prev = find(index – 1);
        // 인자로 받은 object => newNode의 item
        // prevNode의 next에 저장되어 있던 reference 변수 => newNode의 next로
        Node newNode = new Node(item, prev.getNext( ));
        // 이제 prev Node의 next에는 newNode의 reference 변수를 넣어줌
        prev.setNext(newNode);
      }
      // 개수 update
      numItems++; 
    }
    ```

  - With Dummy Node? Just case1

    ```java
    public void add(int index, Object item) {
      Node prev = find(index-1); 
      Node newNode = new Node(item, prev.getNext());
      prev.setNext(newNode);
      numItems++;
    }
    ```



### Ch.5 S34

Call by Reference

- call 시, formal variable은 actual variable을 가리키는 reference variable
  - actual variable 값 바뀜

Call by Value

- call 시, formal variable은 actual variable의 주소가 아니라 **값을 복사**
  - actual variable 값 불변

```java
Integer x = new Integer(9);
changeNumber(x, new Integer(5)); // 안 바뀜

public void changeNumber(Integer n, Integer k) {
	n = k;
}

changeNumber2(x, 5); // 바뀜

public void changeNumber2(Integer n, int k) {
	n.setValue(k);
}
```



> 함수 call은 stack을 사용해서 이루어짐. (대조적 개념: queue)

```java
main() {
  b();
  c();
}

b() {
  d();
  e();
}
// main 쌓임 => b 쌓임 => d 쌓임 => d 빼고 e 쌓임 => e뺌 => b 빼고 c 쌓임 => c빼고 main 종료
```



> 시간을 dominate하는 작업이 무엇인가가 성능을 결정
>
> ex. 정렬 => 비교하는 작업. 이에 소요되는 overhead를 최소화 시키는 것이 최적화 목적.



>global variable 최대한 피하자
>
>필요없는 scope에까지 닿는 variable은 에러 유발.

- - - ​