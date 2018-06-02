# Ch.15 Graphs - Application

### 3. Topological Sorting

[조건] **Directed Acyclic Graph** (DAG)

[정의] vertex x **precedes** vertex y if there is an edge **from x to y** 성질을 만족하는 정렬

- 그림의 모든 edge에 대해 위 성질만 만족한다면 어떤 순서라도 좋다.

  There are **many** topological orders for a **directed** graph.

- Cycle이 존재한다면 위 성질은 결코 만족될 수 없음

- 수행시간 = `Θ(V + E)` 

  1. for 루프는 **|V|번 반복.**

     매 반복시마다 한 개의 vertex 선택되고, 해당 vertex에 연결된 incoming edges 모두 제거된다. 따라서 **각 edge는 1번씩**만 취급된다

  2. DFS가 **Θ(V + E)** 시간 걸리고

     |V|개의 vertices들을 각각 linked list의 처음으로 보내는데 **O(1)**이 걸리기 때문

```java
// 1. non-recursive
topologicalSort(G) {
    for (int i = 1; i < G.size(); i++) {
        v = Select a vertex v that has no outgoing edges; // incoming
        vertex[i] = v;
        Delete(vertex v, incoming edges to v) // outgoing이면 1..size 순
    }
    List vertex[G.size()], ... , vertex[1]; // 역순 topological order
}
// 2. Using DFS with recursion (쉽알)
topologicalSort2(G) {
    for (v : V)
        visited[v] = false;
    for (v : V)
        if (visited[v] == false) DFS(v);
}
DFS(v) {
    for (each unvisited vertex u adjacent to v)
        DFS(u);
    LinkedList의 맨 앞에 add(v); // 넣는 순서는 역순. 결과는 앞에서 뒤 순서.
}// recursive call은 반복인자 없으므로 배열 index에 접근 불가하여 LL 사용
```

![image](https://user-images.githubusercontent.com/17509651/40838036-5d4e613a-65d7-11e8-99c7-e914e4e919d1.png)

------

### 4. Spanning Trees

[조건] **Undirected Connected Graph** G = (V, E)의 

[정의] Spanning Tree = **Acyclic Connected Subgraph** of G that contains 
					**all** of G's vertices, and **|V| - 1** of G's edges.

> Tree = 그래프에서 최소한의 connected된 상태를 유지. 
> tree with n vertices는 *항상* n-1 edges. 여기서 root 가정하면 rooted tree.

- **DFS Spanning Trees** / **BFS Spanning Trees**

- **Minimum Spanning Trees**

  [조건] **Weighted** Undirected Connected Graph

  [정의] a spanning tree with the **minimum cost**

  [the Cost of a spanning tree] the sum of edge weights(edge rates)

  - **Prim Algorithm**

  ```java
  // ver.01 (쉽알 285)
  PrimAlgorithm(r) {	// r:시작 정점
      S = {};
      for (v : V)	// d: 각 vertex를 집합 S에 있는 vertex와 연결하는 최소비용 
      	d[v] = ∞;
      d[r] = 0;
      while (S != V) {// S: 공집합 ~ V까지 키워나간다. n회 순회 용도.
          u = extractMin(V - S, d); // S가 아닌 것 중 최소비용 (어차피 인접)
          S = S + {u};	// u를 S에 넣는다.
          for (v : L(u)) 	// L(v)는 v의 adjacent vertex 집합
              if (v is in V - S && weight(u, v) < d[v]) {
                  d[v] = weight(u, v); // 최소비용을 갱신한다. "Relaxation"
                  tree[v] = u; 
              }	// tree: 해당 vertex를 MST에 연결시키는 edge
      } 			// 실제로는 해당 edge에서 v의 맞은 편에 있는 vertex를 저장
  } extractMin(Q, d[]) {} // 집합 Q에서 d값이 가장 작은 vertex
  // ver.02 (쉽알 286) 
  PrimAlgorithm(r) {
      Q = V; // Q: S 대신 S에 속하지 않은 vertex 집합 Q를 이용
      for (v : Q) // |V|번 반복 => O(V) 시간을 소요
          d[v] = ∞;
      d[r] = 0;
      while (!Q.isEmpty()) { // |V|번 반복
          u = deleteMin(Q, d); // 따라서 d[]가 배열이면 최대 O(V) 소요
          for (v: L(u)) // while문을 통틀어 2|E| 번 돈다
              if (v is in Q && weight(u, v) < d[v]) {
                  d[v] = weight(u, v);
          		tree[v] = u;
      		}
      }
  }
  // pseudo code (PPT)
  PrimAlgorithm(v) {
      Mark v as visited and include it in the m.s.t.;
      while (there are unvisited vertices) {
          Find a least cost edge (x, u) from a visited vertex x
              						  	to unvisited vertex u;
          Mark u as visited;
          Add the vertex u & the edge (x, u) to the m.s.t.;
      }
  }
  ```

- **귀납적 알고리즘** : 한 번 돌 때마다 cross-edge 중 길이가 가장 짧은 것이 S로 들어옴

- **Relaxation (이완)** : 해당 vertex를 집합 S에 있는 vertex와 연결하는 최소 비용 =`d[]`

  > 현재 상태(능력; 현재 위치)와 되어야 하는 상태(욕망; 집합 S) 사이의 괴리를 줄인다는 의미

- **Greedy Algorithm** : global view가 아닌 local view로 현재 시점에 가장 이익인 것을 선택

  - 알고리즘도 마찬가지로 눈 앞 이익만 챙기다보면 global optimal 솔루션 찾기 힘들다

  - 그런데 greedy algorithm으로도 global optimality 찾아내는 예외적 드문 케이스 있음

    (1) Prim Algorithm (2) Dijkstra's Algorithm

- 반드시 **같은 weight의 edge**가 있어야, **minimum spanning tree가 2개 이상** 있다

  그렇지 않으면, **minimum spanning tree는 유일**

- **수행시간 = `Θ(E log V)`**  (쉽알 287쪽)

  - 첫번째 for loop : |V|회 반복 * 상수시간. 최초의 heap을 만들어도 마찬가지 = `O(V)`

  - while문 안 deleteMin : **|V|회 반복 * 회당 deleteMin 수행시간**

  - while문 안 for문 : while문 통틀어 2|E|번 수행. 이중 d[v] = weight(u,v) 갱신은 최악의 경우 |E|번 일어난다. 따라서 **|E|회 * 회당 d[v] 갱신 시간**

    > u와 인접한 edge를 보게 되는데 어떻게 되든 한 edge는 두 번만 본다. 그래서 2|E|

  **후자의 2가지 중 하나가 시간을 지배: d[]의 자료구조에 따라 시간이 달라진다.**

  1. d[] = sorted array
     - deleteMin = 상수시간 => `O(V)`
     - 갱신 = shift O(V) * 최악의 경우 |E|번 일어남 = O(VE) => `O(VE^2)` (longer)

  2. d[] = unsorted array 
     - deleteMin = 검색 시간이 O(V) => `O(V^2)` (longer)
     - 갱신 = 상수시간 => `O(E)`

  3. d[] = minHeap (most efficient)
     - deleteMin = heap의 검색 시간은 O(log V) => `O(V log V)`
     - 갱신 = heap에 변동 반영 시간은 O(log V) => `O(E log V)` (longer)

- **안전성 정리**

  Weighted undirected connected graph G = (V, E)의 vertices가 임의의 두 집합 S와 V - S로 나누어져 있다고 하자. **Edge (u, v)가 S와 V - S 사이의 최소 cross-edge라면 (u, v)를 포함하는 그래프 G의 M.S.T가 반드시 존재**한다.

  ```markdown
  가정1: 임의의 최소신장트리 T가 최소 cross-edge (u, v)를 포함하고 있지 않다.
  가정2:
  1. T는 u에서 v로 이르는 경로가 반드시 존재(connected)하며 유일(acyclic)하다. 
  2. 이 경로는 S에서 시작해서 V-S에 이르는 (또는 그 반대) 경로이므로, 이 경로 상에는 S와 V-S 사이의 cross-edge가 적어도 1개 이상 존재한다.
  3. 이 cross-edge 중 하나를 임의로 잡아 `(x,y)`라고 하자.
  증명:
  1. T에 `(u,v)`를 더하면 cycle이 만들어지므로 트리가 될 수 없다.
  2. T에서 `(x,y)`를 제거하고 `(u,v)`를 더하면 T'가 만들어진다.
  T와 T' 비교:
  > `(u,v)`는 최소 cross-edge이므로 `weight(u,v) <= weight(x,y)`
  > 따라서 `weight(T') <= weight(T)`
  이때 `weight(u,v) < weight(x,y)`라면 T가 최소신장트리라는 가정1에 위반.
  따라서 `weight(T') == weight(T)`이며 T'도 최소신장트리이다.
  >> 즉 (u,v)를 포함하고 있지 않은 MST가 존재하면 반드시 이를 포함하는 MST로 바꿀 수 있음
  ```

  

------

### 5. Shortest Paths

- **Dijkstra Algorithm**
- **Euler Circuit**