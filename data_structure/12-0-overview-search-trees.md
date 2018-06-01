# Ch.12 Search Trees

### 0. Search Trees

- 한 노드에서 최대 몇 개의 자식 노드로 분기를 할 수 있느냐
  - 이진검색트리 (최대 2개)
  - 다진검색트리 (최대 3개 이상)
    - k진검색트리 (최대 k개까지 가질 수 있는 검색트리)
- 저장되는 장소
  - 내부검색트리
    - 검색트리가 메인 메모리 내에 존재 
    - 메인 메모리에서 모든 키를 수용할 수 있으면, 
      메인 메모리로 한 번만 탑재한 후 내부검색트리로 사용 가능.
  - 외부검색트리
    - 검색트리가 외부(주로 디스크)에 존재
    - 메인 메모리에서 모든 키를 수용할 수 없을 정도로 크면,
      디스크 공간에 저장된 상태로 검색
      => **디스크 접근 시간**이 검색의 효율을 좌우
- 검색 키가 포함하는 필드의 수
  - 일차원 검색트리 (all)
  - 다차원 검색트리 (KD-tree, KDB-tree, R-tree 등)



### 1. Balanced Search Trees

Search Tree의 정의:  `Ti` < keyi < `Ti+1`

> retrieval(search), insertion, deletion의 시간은 search가 소요시간을 지배한다.
>
> 이는 트리의 높이에 따라 결정된다.

> Traversal은 average도  `Ө(n)` 

#### 기존의 Binary Search Trees

- average case `Ө(log n)` 
- worst case `Ө(n)` 
  - Binary Tree의 정의: 
    - T = empty || 3 disjoint subsets (root, left subtree, right subtree)
    - left subtree, right subtree = Binary Tree
  - Binary Search Tree의 정의:
    - Ti < key i < Ti+1 (no duplicates)
    - Ti, Ti+1 = Binary Search Tree

#### 균형 잡힌 Balanced Search Trees

- guarantees `O(log n)` 

  1.1. **Balanced Binary** Search Trees

  - Red-black tree

    

  - AVL tree

  1.2. **Balanced K-ary** Search Trees

  - 2-3 tree
  - 2-3-4 tree
  - B-trees