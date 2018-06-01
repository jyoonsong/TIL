# Ch.12 Balanced Binary Search Trees

## 1. Red-Black Tree

#### 1.1. 정의

> **2-3-4 tree**의 binary-tree representation

- Balanced Binary Search Tree where
  - each reference(혹은 node) is given a color **red or black**
    - `black` - edge from original 2-3-4 tree

    - `red` - edge generated in transformation into binary search tree

      > 빨간 색으로 연결된 애들은 사실 2-3-4의 **하나의 노드 안에 있는 keys**



#### 1.2. Implementation

codes

#### 1.3. 정리

observation



## 2. AVL Tree

#### 2.1. 정의

- Balanced Binary Search Tree such that
  - **heights** of left & right subtrees of any node differ by **at most 1**



#### 2.2. Implementation

```java
public class AVLTreeNode {
    private Comparable item;
    private AVLTreeNode leftChild;
    private AVLTreeNode rightChild;
    private int leftHeight;
    private int rightHeight;
}
```

