# Ch.12 Balanced K-ary Search Trees

> special case of B-trees

## 1. 2-3 Tree

#### 1.1. 정의

- Intuitive
  - each internal node는 **2 or 3** children (1 or 2 keys)
  - all **leaves** are at the **same level** (강력한 성질. heap이나 BST는 없었다.)
- `T` is a 2-3 tree of height `h` if
  - `T` is empty (h = 0) or
  - `T` is of the form (root node `r`이 `Tl` `Tm` `Tr`로 분개) where `Tl` `Tm` `Tr` are
    - 2-3 tree, 
    - each of **height `h-1`**
    - only `Tr` can be empty - 1개 key in the node `r`
  - 2-3 tree of height 3

#### 1.2. Implementation

- node

  ```java
  public class Node {
      private Comparable smallItem; 
      private Comparable largeItem;
      private Tree23Node leftChild;
      private Tree23Node midChild;
      private Tree23Node rightChild;
  }
  ```

- insertion

  ```java
  insert(tree, key) {
      Find the leafnode l to which key should belong;
      Add key to l;
      if (l now has 3 items) // overflow
          split(l);
  }
  split(n) {// n: node with 3keys. if n is internal, it has 4 children
      if (n == root)
          p = create a new node;
      else
          p = parent of n;
      Move up the middle key of n to p;
      Split the remaining 2 keys of node n to 2 nodes;
      if (p now has 3 items) split(p);
  }
  ```

  ![](/Users/mac/Pictures/2-3treeinsert.png)

- deletion

  ```java
  
  ```

  





## 2. 2-3-4 Tree

#### 2.1. 정의

- Intuitive
  - each internal node는 **2 or 3 or 4** children (1 or 2 or 3 keys)
  - all **leaves** are at the **same level** (강력한 성질)
- `T` is a 2-3-4 tree of height `h` if
  - `T` is empty (h = 0) or
  - `T` is of the form (root node `r`이 `T1` `T2` `T3` `T4`로 분개) where `T1~4` are
    - 2-3-4 tree,
    - each of **height `h-1`**
    - only `T3` `T4` can be empty - 1 or 2개의 keys in the node `r`

#### 2.2. Implementation

- 