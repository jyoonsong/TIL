## 2. Network Connectivity

### 2.2. Distance Measures

**Distance**

* motivation

  * How "far" is node A from node H?
  * Are nodes far away or close to each other in this network?
  * Which nodes are the "closest" and "farthest" to other nodes?

  => We need a sense of distance between nodes to answer these questions

* **Path**: a sequence of nodes connected by an edge

  * example: Find two paths from node G to node C
    * `G - F - C`
    * `G - F - E - C`
  * **Path length**: number of steps it contains from beginning to end

* **Distance**: the length of the *shortest* path between them

  * networkx:

    ```python
    nx.shortest_path(G, "A", "H")
    # output: ["A", "B", "C", "E", "H"]
    nx.shortest_path_length(G, "A", "H")
    # output: 4
    ```

* Finding the **distance from node A to every other node**

  1. **Breadth-first search**

     - a systematic and efficient procedure for computing distances from a node to all other nodes in a large network by "*discovering*" nodes in layers

     ```python
     A
     B K 		# distance = 1
     C 			# distance = 2
     E F 		# distance = 3
     D I H G # distance = 4
     J 			# distance = 5
     ```

     - networkx

     ```python
     T = nx.bfs_tree(G, "A")
     T.edges 
     # output: [(A, K), (A, B), (B, C), (C, E), (C, F), (E, I), (E, H), (E, D), (F, G), (I, J)]
     
     nx.shortest_path_length(G, "A")
     # output: {A: 0, B: 1, C: 2, D: 4, E: 3, F: 3, H: 4, I: 4, J: 5, K: 1} 
     ```

* How to summarize/characterize the **distance between all pairs of nodes** in a graph? 

  > Are nodes in general far away or close to each other? If some are close and some are far, then how can we figure out which nodes are close and which are far?

  1. **average distance** between every pair of nodes

     ```python
     nx.average_shortest_path_length(G)
     # output: 2.527272727
     ```

  2. **Diameter**: maximum distance between any pair of nodes

     ```python
     nx.diameter(G)
     # output: 5
     ```

  3. **Eccentricity** of a node n is the largest distance between n and all other nodes

     ```python
     nx.eccentricity(G)
     # output {A: 5, B: 4, C: 3, D: 4, E: 3, F: 3, G: 4, H: 4, I: 4, J: 5, K: 5}
     ```

  4. **Radius** of a graph is the minimum eccentricity

     ```python
     nx.radius(G)
     # output: 3
     ```

  5. **Periphery** of a graph is the set of nodes that have eccentricity equal to the *diameter* (largest eccentricity you can have)

     ```python
     nx.periphery(G)
     # output: [A, J, K]
     ```

  6. **Center** of a graph is the set of nodes that have eccentricity equal to the *radius* (minimum eccentricity you can have)

     ```python
     nx.center(G)
     # output: [C, E, F]
     ```

* example

  ```python
  G = nx.karate_club_graph()
  G = nx.convert_node_labels_to_integers(G, first_label = 1)
  
  nx.average_shortest_path_length(G) # 2.41
  nx.radius(G) # 3
  nx.diameter(G) # 5
  
  nx.center(G) # [1,2,3,4,9,14,20,32]
  nx.periphery(G) # [15,16,17,19,21,23,24,27,30]
  ```

  

| concept                                      |                                                    |                                        |
| -------------------------------------------- | -------------------------------------------------- | -------------------------------------- |
| **distance** btw two nodes                   | length of the shortest path btw them               | `nx.shortest_path_length(G, "A", "H")` |
| **eccentricity** of a node n                 | the largest distance between n and all other nodes | `nx.eccentricity(G)`                   |
| distances in a network                       |                                                    |                                        |
| **average distance** btw every pair of nodes |                                                    | `nx.average_shortest_path_length(G)`   |
| **diameter**                                 | maximum distance between any pair of nodes         | `nx.diameter(G)`                       |
| **radius**                                   | the minimum eccentricity in the graph              | `nx.radius(G)`                         |
| identifying central & peripheral nodes       |                                                    |                                        |
| **periphery**                                | set of nodes with eccentricity = diameter          | `nx.periphery(G)`                      |
| **center**                                   | set of nodes with eccentricity = radius            | `nx.center(G)`                         |

