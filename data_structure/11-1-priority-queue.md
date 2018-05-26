# Ch.11 Table & Priority Queue

### Static vs Dynamic Data

- **static data sets**

  - 한 번 데이터 집합이 형성된 후에는 변하지 않는 데이터 (예: 책)

- **dynamic data sets**

  - data sets can grow or shrink. (예: 기업)

    - **Table (= Dictionary)** : dynamic data set that supports

      `insertion` `deletion` and **`membership test`** (key로 검색해서 꺼낼 수 있음)

    - **Priority Queue** : dynamic data set that supports

      `insertion` `deletion` and **`retrieval of max element`** (priority가장 높은 애만 꺼낼 수 있음)



## Priority Queue

### 1. Comparison: Table VS Priority Queue

| ADT            | Table           | Priority Queue                                               |
| -------------- | --------------- | ------------------------------------------------------------ |
| **Insertion**  | key 사용        | key 사용                                                     |
| **Deletion**   | search key 제공 | search key 사용 안함<br />= priority 가장 높은 item만 삭제 가능 |
| **Key값 중복** | 불허            | 허용                                                         |

- 우선순위를 가진 여러 개의 data 들어올 때: 항상 priority 가장 큰 놈 가져올 준비 되어야 함.

  - 단순 Array? 

    Sorting된 형태로 유지되어야 함. 가져오는 건 쉽지만 집어넣을 땐 또다시 shift 필요.

  - Binary Search Tree? 

    평균적으로 우선순위 제일 큰 놈(= 오른쪽으로 더 갈 데 없을 때까지 내려가면 maximum)에게 접근하는 시간 = log n의 시간이 든다. 얘를 빼주고 넣어주는 것도 log n의 시간.

    BUT 색인은 모든 key가 서로 다르다는 전제조건을 만족해야 하므로, priority가 2개 이상인 key의 중복이 일어날 수 있다.

    > 이제 3개 이상의 자료구조가 복합적으로 연결될 수 있다. BST에 Linked List, Hash Table 매달려 있는 형식으로.

  - Heap이라는 자료구조가 Priority Queue의 핵심.



### 2. Heap: 대표적인 Priority Queue

- 정의
  - [조건1] complete binary tree (맨 마지막 레벨 꽉 채우려다가 노드 숫자가 안 맞아서 최대한 full에 가깝게 왼쪽부터 채운 것)
  - [조건2] key of each node is greater than or equal to the keys of both children (모든 children보다 parent가 크다)
- root는 최고/저 우선순위
  - maxheap: root = max key (기준)
  - minheap: root = min key
- Node `i` (Array로 나타낸 Heap에서)
  - children = `2i` & `2i+1`
  - parent = `[i/2]` (내림)



### 3. Implementation 

- **ADT Operations**

  - Constructor - create an empty priority queue
  - `isEmpty` - determine whether the priority queue is empty
  - `add` a new item to the priority queue
  - `remove` the item with **highest priority value** from priority queue
  - `retrieve` the item with **highest priority value** from priority queue

- **Array-based**

  ```java
  public class Heap {
      private int size;
      private Comparable [] key;
      
      public Heap() {
          key = new Comparable [MAX];
          size = 0;
      }
      public boolean isEmpty {
          return size == 0;
      }
      public int length() {
          return size;
      }
      public void heapInsert(Comparable x) {
          key[size+1] = x; // insert item into bottom of complete tree
          percolateUp(size+1); // percolate up until heap is valid
      }
      public void percolateUp(int i) {
          int parent = i/2;
          if (parent >= 1 && key[i] > key[parent]) {
              swap(key, i, parent);
              percolateUp(parent);
          }
      }
      public Comparable heapRetrieve() {
          if (!isEmpty())
              return key[1];
          else return null;
      }
      public Comparable heapDelete() {
          if (!isEmpty()) {
              Comparable rootItem = key[1]; // return the root item
              key[1] = key[size]; // move it to root
              size--; // remove the last node
              percolateDown(1); // // percolate down until heap is valid
              return rootItem;
          } 
          else return null;
      }
      public void percolateDown(int i) {
          int child = 2*i; // left child
          int right = 2*i + 1; // right child
          if (child <= size) {
              if ( (right <= size) && (key[child] < key[right]) )
                  child = right; // index of larger child
              if ( key[i] < key[child] ) {
                  swap(key, i, child);
                  percolateDown(child);
              }
          }
      }
  }
  ```
  - insert

    > 뭘 좀 비틀어 보면 낼 게 있나?

    ```java
    //non-recursive
    public void heapInsert(Node x) {
        int i = size+1;
        key[i] = x;
        int parent = i/2;
        while (parent >= 1 && key[i] > key[parent]) {
            swap(key, i, parent);
            i = parent;
            parent = i/2;
        }
    }
    //recursive
    public void heapInsert(Node x) {
        key[size+1] = x; // insert item into bottom of complete tree
        percolateUp(size+1); // percolate up until heap is valid
    }
    public void percolateUp(int i) {
        int parent = i/2;
        if (parent >= 1 && key[i] > key[parent]) {
            swap(key, i, parent);
            percolateUp(parent);
        }
    }
    ```




### 4. Heapsort

- **Time Efficiency**
  - 1단계 - Heap Construction (Heap Building)
    - complete binary tree가 heap성질을 만족하도록 고쳐주는 단계.
    - `O(n)` - linear time 소요
  - 2단계 - Sorting
    - `O(log n)` - Root를 빼고 수선하는 과정
    - `O(n log n)` - 을 n-1번 반복하면 빠져나온 순서가 소팅됨.
- **Implementation**

```java
public void heapsort(Comparable[] A, int n) {
    // 1단계: build initial heap A[1...n]
    for (int i = n/2; i >= 1; i--) // n/2는 최초로 heap 수선이 필요할 수 있는 부모
        percolateDown(A, i, n);
    // 2단계: delete one by one
    for (int size = n-1; size >= 1; size--) {
        swap(A, 1, size+1);
        percolateDown(A, 1, size);
    }
    // 이 지점에서 A[1..n]은 sorting 되어 있다.
}
public void percolateDown(Comparable[] A, int i, int size) {
    int child = 2*i; // left child
    int right = 2*i + 1; // right child
    if (child <= size) {
        if ( right <= size && key[child] < key[right] )
            child = right; // index of larger child
        if ( key[i] < key[child] ) {
            swap(key, i, child);
            percolateDown(child);
        }
    }
}
```

- **Comparison**

  - input이 특수한 조건을 만족하지 않을 경우 n*log n 의 시간을 보장하는 또 하나의 정렬.

    - merge는 균형이 늘 맞아서 이론적으로 더 좋은 BUT in-place가 아님
    - quick은 균형이 안 맞는 경우에 취약. 최악의 경우를 보장 못함 BUT in-pace는 됨
    - heap은 **최악의 경우를 보장하면서 in-place sorting이다.**

  - n log n보다 작은 시간 가능한가?

    - merge, quick : 불가능
    - heap : **모든 key가 같다면? 각각의 percolate down에 자신의 자식과의 비교 즉 단 한 번의 비교만 필요하다. 따라서 n log n보다 낮아질 수 있음**

  - 최악의 경우에 n log n보다 작아질 수 있는가?

    - No

      **Comparison Sort를 하는 한 Worst Case Time은 `Ω(n log n)`을 밑돌 수 없다.**