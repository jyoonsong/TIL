## 1. Why Study Networks and Basics on NetworkX

### 1.4. Bipartite Graphs

- **definition**

  a graph whose nodes can be split into two sets L and R 

  and every edge connects an node in L with a node in R
  
  (all the edges go from one set of nodes to another set of nodes)
  
  - ex) Fans (L) - Basketball Teams (R)
  - edge: a particular fan <u>is a fan of</u> a particular team
    - nodes: fans, players

- **construction**

  ```python
  from networkx.algorithms import bipartite
  B = nx.Graph() # no separate class for bipartite graphs
  B.add_nodes_from(["A", "B", "C", "D", "E"], bipartite = 0) # label one set of nodes 0
  B.add_nodes_from([1, 2, 3, 4], bipartite = 1) # label other set of nodes 1
  B.add_edges_from([("A", 1), ("B", 1), ("C", 1), ("C", 3), ("D", 2), ])
  ```

- **checking if a graph is bipartite**

  ```python
  bipartite.is_bipartite(B)
  # output: True
  
  B.add_edge("A", "B")
  bipartite.is_bipartite(B)
  # output: False
  
  B.remove_edge("A", "B")
  ```

- **checking if a set of nodes is a bipartition of a graph**

  ```python
  X = set([1, 2, 3, 4])
  bipartite.is_bipartite_node_set(B, X)
  # output: True
  
  X = set(["A", "B", "C", "D", "E"])
  bipartite.is_bipartite_node_set(B, X)
  # output: True
  
  X = set([1, 2, 3, 4, "A"])
  bipartite.is_bipartite_node_set(B, X)
  # output: False
  ```

- **getting each set of nodes of a bipartite graph**

  ```python
  bipartite.sets(B)
  # output: ({"A", "B", "C", "D", "E"}, {1, 2, 3, 4})
  
  B.add_edge("A", "B")
  bipartite.sets(B)
  # outpu: NetworkXError: Graph is not bipartite
  
  B.remove_edge("A", "B")
  ```

- **Projected graphs**

  - **L-Bipartite graph projection**: Network of nodes in group L, where a pair of nodes is connected if they have a common neighbor in R in the bipartite graph. 

    ex) network of fans who have a team in common

  - (You would have a similar definition for **R-Bipartite graph projection**)

    ex) network of teams who have a fan common

    => we need weights on the edges!

  ```python
  B = nx.Graph()
  B.add_edges_from([("A", 1), ("B", 1), ("C", 1), ("D", 1), ("H", 1), ("B", 2), ("C", 2), ("D", 2), ("E", 2), ("G", 2), ("E", 3), ("F", 3), ("H", 3), ("J", 3), ("E", 4), ("I", 4), ("J", 4) ])
  
  X = set(["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]) # fans
  P = bipartite.projected_graph(B, X)
  # output: network of fans who have a team in common
  
  X = set([1, 2, 3, 4]) # teams
  P = bipartite.projected_graph(B, X)
  # output: network of teams who have a fan common
  ```

  - **L-BIpartite weighted graph projection**: An L-Bipartite graph projection with weights on the edges that are proportional to the number of common neighbors between the nodes

    ex) weighted network of teams who have a fan common

  ```python
  X = set([1, 2, 3, 4])
  P = bipartite.weighted_projected_graph(B, X)
  ```

  

### 정리

- No separate class for bipartite graphs in NetworkX
  - Use `Graph(), DiGraph(), MultiGraph()` etc
  - Use `from networkx.algorithms import bipartite` for bipartite related algorithms (Many algorithms only work on `Graph()`)

| what                                                | code                                       |
| --------------------------------------------------- | ------------------------------------------ |
| check if B is bipartite                             | `bipartite.is_bipartite(B)`                |
| check if node set X is a bipartition                | `bipartite.is_bipartite_node_set(B, X)`    |
| get each set of nodes of bipartite graph B          | `bipartite.sets(B)`                        |
| get the bipartite projection of node set X          | `bipartite.projected_graph(B, X)`          |
| get the weighted bipartite projection of node set X | `bipartite.weighted_projected_graph(B, X)` |

