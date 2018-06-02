# Ch.15 Graphs

### 0. 개념

- Definitions

  - `G = (V, E)` 그래프란, 현상이나 사물을 Vertex나 Edge로 표현한 것.
    - Subgraph : a subset of a graph's vertices and edges
    - Edge : 간선 => `E` = set of Edges
    - Vertex : 정점  => `V` = set of Vertices/Nodes
      - Adjacent : if two vertices are joined by **an** edge
  - Path : a sequence of connected **edges**
    - Cycle : a path whose starting & ending vertex are the **same**
    - Simple Path : a path that contains **no cycle**
    - Simple Cycle : a cycle that contains **no cycle** in it

- 그래프의 종류

  - Connected (모든 쌍 적어도 **1 path**) vs Complete Graph (모든 쌍이 적어도 **1 edge**)

  - Directed Graph (digraph) vs Undirected Graph

  - Weighted Graph vs Unweighted Graph (**edge**: 친밀도의 크기, 비행시간 등)

    >  NOT considered as graphs : Multigraph, Loop

![image](https://user-images.githubusercontent.com/17509651/40780014-005bd982-6512-11e8-85cf-a23d052e1cf8.png)

---

### 1. Graph Representation

- **Adjacency Matrix**

  - N x N matrix (N = # of vertices)

    where `matrix[i][j]` = **btw** vertex i **&** vertex j에 edge가 있으면 1 없으면 0

    - drigraph: **from** vertex i **to** vertex j 
    - weighted graph: 1 대신 weight value

  - 장점

    - edge의 존재 여부를 (i, j)원소나 (j, i)원소의 값만 보면 즉각 알 수 있다.  `Θ(1)` 소모.
    - edge의 밀도가 아주 높은 그래프에서는 적합 (예: 전체 쌍 중 1/2이 edge 있는 경우)

  - 단점

    - **n^2에 비례하는 공간** 필요. edge의 밀도가 낮은 경우 부적절.

      예: 100만 개 vertex, 200만 개 edge => 행렬 원소 1조 개 중 200만 개(dir) 또는 400만 개만 1로 채워짐

    - **n^2에 비례하는 시간** 소요.

      O(n^2) 미만의 시간이 소요되는 알고리즘이 필요한 경우, 행렬의 준비 과정에서 행렬의 모든 원소를 채우는 데만 이미 `Θ(n^2)` 소모하여 부적절.

- **Adjacency List**

  - N Linked Lists

    where `list i` is the list of vertices that is **adjacent** to vertex i

    - weighted graph: list에 vertices와 함께 weight values 저장

  - 장점: **공간이 edge의 수에 비례**하는 양만큼만 필요

    > 각 vertex당 평균적으로, `해당 vertex의 평균 degree(연결된 vertex 개수)` 만큼 노드를 가진 LL을 만들게 된다.

    - undirected: edge 하나당 2 nodes (i의 LL에 j가, j의 LL에 i가)
    - directed: edge하나당 1 node

  - 단점: **list 만드는/훑는 Overhead**. edge의 밀도가 높은 경우 부적절.

    - 거의 모든 vertex 쌍에 대해 edge가 존재하는 그래프의 경우, 인접행렬과 비교했을 때, 오히려 리스트를 만드는 데 필요한 overhead만 더 든다.
    - **edge 존재 여부**를 알기 위해 list를 차례로 훑어야 함. 최악의 경우 `Θ(n)` 소모.

![image](https://user-images.githubusercontent.com/17509651/40782977-fbabad9a-651b-11e8-8a14-90300d35e7b1.png)

---

### 2. Graph Traversals

: vertex u에서 시작해 vertex u로부터 path를 가진 모든 vertices v를 방문.

> tree traversal(preorder 등) vs Graph traversal
>
> (1) Graph 일반에 대한 것  (2)  각 노드의 방문이 서로 독립적 vs visited라는 집합으로 종속적
> (3) global 변수 없이 구조적으로 재귀호출 vs global 변수를 이용. 개별 node 관점의 알고리즘.

- **DFS (Depth-first search)**

  - 수행시간 `Θ(V + E)` : 
    - 궁극적으로 DFS(v)를 **|V|번** 호출
    - DFS(v)안의 adjacent vertex check for문 다 합치면 **2|E|번** 실행

  ```java
  // non-recursive
  DFS(s) {
      for (v : V - {s})
          visited[v] = false;
      stack.push(s);
     	visited[s] = true;
      
      while (!stack.isEmpty()) {
          if (no unvisited vertices are adjacent to stack.peek())
          	stack.pop(); // backtracking
          else {
              v = select an unvisited vertex adjacent to stack.peek();
              stack.push(v);
              visited[v] = true;
          }
      }
  }
  // recursive
  DFS(G) {
      for (v : V)
          visited[v] = false;
      for (v : V)
          if (visited[v] == false) DFS(v); // 여기선 1번만 실행됨
  }
  DFS(v) {
      visited[v] = true;
      for (each unvisited vertex u adjacent to v)
          DFS(u); // 궁극적으로는 모든 정점에 대해 DFS(v)가 1번씩 호출됨
  }
  ```

  - **DFS Spanning Tree** : 각 vertex를 처음으로 방문할 때 사용한 edge들로 만들어진 tree

  ```java
  DFSTree(v) {
      visited[v] = true;
      for (each unvisited vertex u adjacent to v) {
          // edges marked in DFSTree() constitute a DFS spanning tree
          Mark the edge (u, v);
          DFSTree(u);
      }
  ```

- **BFS (Breadth-first search)**

  - 수행시간 `Θ(V + E)` 
    - BFS가 수행되는 동안 enqueue와 dequeue를 각각**|V|번**씩 호출.
    - while문 안의 adjacent vertex check for문 다 합치면 **2|E|번** 실행

  ```java
  // non-recursive
  BFS(s) {
      for (v : V - {s})
          visited[v] = false;
      queue.enqueue(s);
     	visited[s] = true;
      
      while (!queue.isEmpty()) {
          w = queue.dequeue();
          for (each vertex u adjacent to w) {
              queue.enqueue(u);
              visited[u] = true;
          }
      }
  }
  // recursive
  function이 컴퓨터 구조적으로 stack frame이라는 이름에 걸맞게 stack에 쌓임. 자료구조 쓰지 않으면서 recursive하려면 queue로 function 관리하는 architecture 필요.
  ```

  - **BFS Spanning Tree** : 각 vertex를 처음으로 방문할 때 사용한 edge들만 남긴 tree

  ```java
  BFSTree(v) { // 나머진 위와 같음
   ...for (each vertex u adjacent to w) {
          queue.enqueue(u);
          visited[u] = true;
      	Mark the edge (u, v);// edges marked constitute BFSspnningtree
      }
  ```

  
