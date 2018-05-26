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



## Table

### 1. Average Efficiency of Table Operations

![image](https://user-images.githubusercontent.com/17509651/39756561-14daf650-5305-11e8-9eb8-a03cd3798aa0.png)

- array based
  - unsorted
    - 삽입: 이보다 효율적일 수 없다.
    - 검색: 대신 검색이 실패한다. 이에 따라 deletion, retrieval 평균적으로 n에 비례
  - sorted
    - 앞에서부터 쭉 찾고 shift로 인해 평균 반 정도의 시간 소요
- linked list
  - unsorted
    - 삽입: 뒤나 head에 붙일 수 있으므로 아주 단순
    - 검색: 원시적
  - sorted
    - Array에 비해 shift는 해결되어 끼워 넣는 것은 상수시간이지만 검색에 마찬가지로 linear time 소요된다.
- Binary Search Tree
  - 평균적으로 아무렇게나 만든 BST에서의 검색은 O(log n)의 시간을 소요한다.



### 2. Implementation 

- **ADT Operations**

  - Constructor - create an empty table
  - `isEmpty` - determine whether the table is empty
  - `length` - determine the number of items in the table
  - `add` a new item to the table
  - `remove` the item with a given search key from table
  - `retrieve` the item with a given search key from table

- **Sorted Array-based**

  ```java
  public class TableArrayBased {
      final int MAX_TABLE = 100;
      protected Comparable [] items;
      private int size;
      public TableArrayBased() {
          items = new Comparable[MAX_TABLE];
          size = 0;
      }
      public boolean isEmpty {
          return size == 0;
      }
      public int length() {
          return size;
      }
      public void insert(Comparable newItem) {
          if (size < MAX_TABLE) {
              int spot = position(newItem);
          	if ((spot < size) && items[spot].compareTo(newItem) == 0)
                  duplicated items; // Exception 처리
              else {
                  for (int i = size - 1; i >= spot; --i) // shift right
                      items[i+1] = items[i];
                  items[spot] = newItem; // insert
                  ++size;
              }
          }
          else table full; // Exception 처리
      }
      public boolean delete(Comparable searchKey) {
          int spot = position(searchKey);
          boolean success = (spot < size) &&
              			  (items[spot].compareTo(searchKey) == 0);
          if (success) {
              size--;
              for (int i = spot; i < size; ++i) // shift left
                  items[i] = items[i+1];
          }
      }
      public Comparable retrieve(Comparable searchKey) {
          int spot = position(searchKey);
          boolean success = (spot < size) &&
              			  (items[spot].compareTo(searchKey) == 0);
          if (success) return items[spot];
          else no such element; // Exception 처리
      }
      protected int position(Comparable searchKey) {
          int pos = 0;
          while ((pos < size) && searchKey.compareTo(items[pos]) > 0)
              pos++;
          return pos;
      }
  }
  ```

- **Tree-based**

  ```java
  public class Table {
      private int size;
      private BinarySearchTree bst;
      
      public Table() {
          bst = new BinarySearchTree();
          size = 0;
      }
      public boolean isEmpty {
          return size == 0;
      }
      public int length() {
          return size;
      }
      public void tableInsert(Comparable newItem) {
          if (bst.retrieve(newItem) == null) {
              bst.insert(newItem);
              size++;
          }
          else duplicated items; // Exception 처리
      }
      public Comparable tableRetrieve(Comparable searchKey) {
          return bst.retrieve(searchKey);
      }
      public boolean tableDelete(Comparable searchKey) {
          if (bst.deleteItem(searchKey)) { // successful deletion
              size--;
              return true;
          }
          else return false;
      }
  }
  ```