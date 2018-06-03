# Ch.14 B-tree

### 0. 정의

- B-tree는 디스크 환경에서 사용하기에 적합한 Balanced 외부 다진 검색트리.

  - 외부검색트리: 검색트리가 디스크에 있는 상태로 사용됨. 메모리에 모두 올려놓지 못하기 때문.
  - 다진검색트리(K-ary): 검색 트리의 분기 수를 늘리면 검색트리의 기대 깊이를 낮출 수 있다.

- 성질

  - search tree:  `Ti` < keyi < `Ti+1`
  - balanced search tree: 모든 leaf node는 같은 깊이를 가진다. => guarantees `O(log n)` 
  - k-ary tree: root를 제외한 모든 노드는 `[k/2] ~ k`개의 key를 가진다. floor 5/2 = 2

  > 분기의 수를 가능하면 늘리되 균형을 맞추기 위해 각 노드가 채울 수 있는 최대 허용량의 반 이상을 채워야 한다

- Node의 구조

  - key
  - pointer (자식 노드로의 분기를 위한 reference)
  - pointer (부모 노드로의 reference)
  - index (record를 가져올 수 있는 페이지 번호) = pi

  ![](/Users/mac/Pictures/node.png)

