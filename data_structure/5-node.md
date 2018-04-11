# Ch.5 Linked List 중 Node

### Node

Each `Node` contains
- `item` - data (number, string, object...)
- `next` - link (reference variable = 다음 노드의 주소)

![image](https://user-images.githubusercontent.com/17509651/38616740-07ce2742-3dd0-11e8-953b-61d52811da12.png)



1. naive structure

```java
public class IntegerNode {
		public int item;
		public IntegerNode next;
}
```

```java
IntegerNode n1 = new IntegerNode( );
IntegerNode n2 = new IntegerNode( );
n1.item = 5; 
n2.item = 9;
n2.next = null; // BAD information hiding
n1.next = n2; // BAD data abstraction
```

2. Intermediate Version

   **private**으로 item, next에 직접 접근 X Getter, setter 사용 O

```java
public class IntegerNode {
  // private
		private int item;
		private IntegerNode next;
  // getters & setters
		public void setItem(int newItem) {
			item = newItem;
		}
		public int getItem( ) {
			return item;
		}
		public void setNext(IntegerNode nextNode) {
			next = nextNode;
		}
		public IntegerNode getNext( ) {
			return next;
		}
}
```

```java
IntegerNode n1 = new IntegerNode( );
IntegerNode n2 = new IntegerNode( );
n1.setItem(5);
n2.setItem(9);
n2.setNext(null);
n1.setNext(n2);
```

3. Improved Version

   **constructor** 추가됨. 생성 시에 넣을 수 있도록.

```java
public class IntegerNode {
		private int item;
		private IntegerNode next;
		// constructors
		public IntegerNode(int newItem) {
			item = newItem;
			next = null;
		}
		public IntegerNode(int newItem, IntegerNode nextNode) {
			item = newItem;
			next = nextNode;
		}
		// getters & setters (생략)
  		...
}
```

```java
// 1 parameter constructor 사용
IntegerNode n2 = new IntegerNode(9);
IntegerNode n1 = new IntegerNode(5, n2);
// 2 parameter constructor 사용
IntegerNode n1 = new IntegerNode(5, new IntegerNode(9));
```

4. Reusable Version (최종)

   - IntegerNode가 아닌 **범용 Node**

   - single integer field 대신 **Object를 parameter로 받음**

     > Object class is a superclass of every class

```java
public class Node {
		private Object item;
		private Node next;
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

- Since `int` is a primitive type, it **cannot be an inherited class of Object**
- `java.lang.` package의 `Integer` class를 대신 사용한다.

```java
Node n = new Node(new Integer(6));
Node first = new Node(new Integer(9), n);
```

![image](https://user-images.githubusercontent.com/17509651/38617251-6e86955e-3dd1-11e8-89f0-bc8a6c2107f4.png)





### Reference Variable vs Object

생성문 `Node n = new Node(new Integer(9), new Node()`을 통해 만들어지는 것은

- reference variable `n`

- item = reference variable `n`이 가리키는 곳

  integer 9가 들어간다

- next = reference variable `n`이 가리키는 곳

  next에는 또다른 객체의 reference variable이 들어간다.

- 또다른 객체 생성을 함

  next가 가리키는 곳에 새로운 Node 객체 자리가 만들어짐. 아직 field는 생성안됨.

