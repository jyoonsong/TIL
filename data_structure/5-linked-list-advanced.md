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
> 4. **응용 **
>    - Doubly & Circular Linked List
>    - Mixed Structure
> 5. **예제 - Sparse Polynomial**



### Circular Linked List

맨 끝 Node의 next가 맨 앞 Node를 가리키는 Linked List

![singly circular linked list](https://user-images.githubusercontent.com/17509651/38652106-73ae5c92-3e3f-11e8-95fc-2a2418b0d11b.png)



### Doubly Linked List

next뿐만 아니라 previous도 가지고 있는 Linked List

![doubly linked list](https://user-images.githubusercontent.com/17509651/38652073-499ec586-3e3f-11e8-945d-b7b288a7fc22.png)

- `delete`

  ```java
  public void remove(int index) {
    // before
    Node prev = find(index-1);
    Node curr = prev.getNext();
    prev.setNext(curr.getNext());
    numItems--;
    // after
    dNode curr = find(index);
    curr.getPrev().setNext(curr.getNext());
    curr.getNext().setPrev(curr.getPrev());
    numItems--;
  }
  ```

- `add`

  ```java
  public void add(int index, Object item) {
    // before
    Node prev = find(index-1);
    Node newNode = new Node(item, prev.getNext());
    prev.setNext(newNode);
    numItems++;
    // after
    dNode curr = find(index);
    dNode newNode = new dNode(item, curr.getPrev(), curr);
    curr.getPrev().setNext(newNode);
    curr.setPrev(newNode);
  }
  ```



### Doubly Circular Linked List

![image](https://user-images.githubusercontent.com/17509651/38652118-7892ce3c-3e3f-11e8-8ed5-f6808f63c323.png)

- `delete`

  ```java
  public void remove(int index) {
    dcNode curr = find(index);
    curr.getPrev().setNext(curr.getNext());
    curr.getNext().setPrev(curr.getPrev());
    numItems--;
  }
  ```

  => 장점? No need of special treatment for the case of absence in any side

  ​	하나의 Node만 남는 경우, next를 `curr.getNext()`로 설정하려고하면 null이 들어간다. 

  ​	이런식으로 하면 null 처리 안해줘도 되고 자기자신 가리키게 할 수 있음.

- `add`

  ```java
  public void add(int index, Object item) {
    dcNode curr = find(index);
    dcNode newNode = new dcNode(item, curr.getPrev(), curr);
    curr.getPrev().setNext(newNode);
    curr.setPrev(newNode);
  }
  ```

  ​