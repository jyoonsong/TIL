# Ch.11 Table & Priority Queue

### Static vs Dynamic Data

- **static data sets**

  - 한 번 데이터 집합이 형성된 후에는 변하지 않는 데이터 (예: 책)

- **dynamic data sets**

  - data sets can grow or shrink. (예: 기업)

    - **Table (= Dictionary)** : dynamic data set that supports

      `insertion` **`deletion` and `membership test`** (key로 검색해서 꺼내고 지움)

    - **Priority Queue** : dynamic data set that supports

      `insertion` **`deletion` and `retrieval of max element`** 



## Priority Queue

### 1. Comparison: Table VS Priority Queue

| ADT            | Table           | Priority Queue                                               |
| -------------- | --------------- | ------------------------------------------------------------ |
| **Insertion**  | key 사용        | key 사용                                                     |
| **Deletion**   | search key 제공 | search key 사용 안함<br />= priority 가장 높은 item만 삭제 가능 |
| **Key값 중복** | 불허            | 허용                                                         |

- 우선순위를 가진 여러 개의 data 들어올 때: 항상 priority 가장 큰 놈 가져올 준비 되어야 함.

  - 단순 Array? shift 필요.

  - Binary Search Tree? 

    - 평균적으로 우선순위 제일 큰 놈(= 오른쪽으로 더 갈 데 없을 때까지 내려가면 maximum)에게 접근하는 시간 = log n의 시간이 든다. 얘를 빼주고 넣어주는 것도 log n의 시간.

    - 색인은 모든 key가 서로 다르다는 전제조건을 만족해야 함.

  - Heap이라는 자료구조가 Priority Queue의 핵심.

    - 우선순위 제일 큰 놈에게 접근하는 시간 = 상수 시간이 걸린다
    - 중복을 허용한다. If two elements have the same priority, they are served according to their order in the queue. 하면 되기 때문.



### 2. Heap: 대표적인 Priority Queue

- 정의
  - [조건1] **complete binary tree**

    (맨 마지막 레벨 꽉 채우려다가 노드 숫자가 안 맞아서 최대한 full에 가깝게 왼쪽부터 채운 것)

  - [조건2] **모든 children보다 parent가 크거나 같다**
    - maxheap: 크거나 같다: root = max key (기준)
    - minheap: 작거나 같다: root = min key
- Node `i` (Array로 나타낸 Heap에서) => 링크나 포인터 불필요
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
              //자신보다 작지 않은 parent를 만나면 즉시 중단
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
              if ( key[i] < key[child] ){
                  //자신보다 크지 않은 child를 만나면 즉시 중단
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

- **Implementation**

```java
public void heapsort(Comparable[] A, int n) {
    // 1단계: build initial heap A[1...n] 
    // 즉 complete binary tree가 heap성질을 만족하도록 고쳐주는 단계.
    for (int i = n/2; i >= 1; i--) // n/2는 최초로 heap 수선이 필요할 수 있는 부모
        percolateDown(A, i, n); 
    	// 전체 노드 2^(k+1)-1개일 때 맨 마지막 레벨 2^k개 가지므로 
    	// 나머지 2^k - 1/2개 즉 n/2개가 후보. leaf node는 어차피 검토 필요 없다. 
    
    // 2단계: delete one by one
    for (int i = n; i >= 2; i--) {
        swap(A, 1, i);
        percolateDown(A, 1, i - 1);
    }
    // 이 지점에서 A[1..n]은 sorting 되어 있다. (heap은 더이상 아님)
}

// A[k]를 루트로 하는 트리가 힙성질을 만족하도록 수선한다. 
// 이때 두 자식을 루트로 하는 subtree는 힙성질은 만족한다. 그래서 위에 n/2 DOWNTO 1.
public void percolateDown(Comparable[] A, int i, int size) {
    int bigger, left = 2*i, right = 2*i + 1;
    if (left <= size) {
        // 더 큰 자식 고르기
        if ( right <= size && key[child] < key[right] )
            bigger = right;
        else bigger = left;
        // 재귀적 조정
        if ( key[i] < key[bigger] ) {
            swap(key, i, bigger);
            percolateDown(bigger);
        }
    }
}
```

- **Time Efficiency**

  - `percolateDown`의 수행시간

    - 해당 서브트리의 **높이**가 시간을 좌우한다.

      중간에 루트가 자식 중 큰 값보다 작지 않은 경우를 만나면 즉시 중단. 최악의 경우에는 내려갈 수 있는 곳까지 내려가므로 힙의 높이에 비례.

    - 어떤 서브트리도 높이가 **log n**을 넘지 않으므로, 한 번 수행하는 데 `O(log n)` 소요

  - **1단계 - Heap Construction (Heap Building)** 

    `O(n)` - linear time 소요 (최선 = 평균 = 최악)

    > 쉽알 96page

    - percolateDown을 호출하는 횟수 = [n/2]번  *  O(log n)  =  O(n log n) ? **(X)**

      => 부를 때마다 percolateDown에 넘어가는 해당 서브트리의 "높이"가 달라진다. 처음에 call하는 높이 1짜리 heap에 대해서도 log n으로 잡는 건 과한 상한.

    - 레벨이 k인 노드의 수 * 내려가는 칸의 수

      예: [n/2] floor ~ (n/4-1) 은 최초 부모인 레벨로, (n/4+1)개. 0칸 내려감.

      => ceil `[n/2^(k+1)] * O(k)` 의 시그마 k= 0~[log n] floor = `O(n)` 소요 **(O)** 

  - **2단계 - Sorting**

    `Θ(n log n)` 

    - percolateDown을 호출하는 횟수 = n-1번  *  O(log n) = `O (n log n)` **(O)**

      => 역시 하나씩 줄여나가는 데 반하여, 과한 상한이긴 하다.

    - BUT 비교 정렬을 하는 한 Worst Case Time은 절대 `Ω (n log n)` 밑돌 수 없다 **(O)**

      => 최악의 경우에 `n log n`보다 작은 시간 가능한가? NO

      => 최선의 경우에 `n log n`보다 작은 시간 가능한가? YES (아래 참고)

- **Comparison**

  - input이 특수한 조건을 만족하지 않을 경우 n*log n 의 시간을 보장하는 또 하나의 정렬.

    - merge는 균형이 늘 맞아서 이론적으로 더 좋음. BUT in-place가 아님.
    - quick은 in-pace는 됨. BUT 균형이 안 맞는 경우에 취약. 최악의 경우를 보장 못함.
    - heap은 **최악의 경우를 보장하면서 in-place sorting이다.**

  - `n log n` 보다 작은 시간 가능한가?

    - merge, quick : 불가능

    - heap : 아주 드물게 힙성질이 깨지지 않는 경우가 있다.

      => **모든 key가 같다면? 각각의 percolate down에 자신의 자식과의 비교 즉 단 한 번의 비교만 필요하다. 따라서 n log n보다 낮아질 수 있음** = `O(n)`

      => 단순히 이미 정렬된 상태, 역순 정렬된 상태는 도움 안됨. 

  - stable sorting인가?

    - NO: HeapSort, QuickSort, SelectionSort