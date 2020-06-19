## 1. Why Study Networks and Basics on NetworkX

### 1.5. Loading Graphs in NetworkX

**Basic syntax**

```python
import networkx as nx
import numpy as np
import pandas as pd
%matplotlib notebook

# instantiate the graph
G1 = nx.Graph()
# add edges
G1.add_edges_from([(0, 1),
                   (0, 2),
                   (0, 3),
                   (0, 5),
                   (1, 3),
                   (1, 6),
                   (3, 4),
                   (4, 5),
                   (4, 7),
                   (5, 8),
                   (8, 9)])
# draw the network G1
nx.draw_networkx(G1)
```

**Loading graphs from various formats**

- **Adjacency List**

  - format

    ```
    0 1 2 3 5  →→  node 0 is adjacent to nodes 1, 2, 3, 5
    1 3 6  →→  node 1 is (also) adjacent to nodes 3, 6
    2  →→  node 2 is (also) adjacent to no new nodes
    3 4  →→  node 3 is (also) adjacent to node 
    4 5 7
    5 8
    6
    7
    8 9
    9
    ```

  - read adjacency list 

    ```python
    G2 = nx.read_adjlist('G_adjlist.txt', nodetype=int)
    G2.edges() # matches G1
    ```

  - useful for

    - graphs **without** nodes or edge attributes

- **Adjacency Matrix**

  - format

    The elements in an adjacency matrix indicate whether pairs of vertices are adjacent or not in the graph. Each node has a corresponding row and column. 

    ex) Reading across row `0`, there is a '`1`' in columns `1`, `2`, `3`, and `5`, which indicates that node `0` is adjacent to nodes 1, 2, 3, and 5

    ```python
    G_mat = np.array([[0, 1, 1, 1, 0, 1, 0, 0, 0, 0],
                      [1, 0, 0, 1, 0, 0, 1, 0, 0, 0],
                      [1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                      [1, 1, 0, 0, 1, 0, 0, 0, 0, 0],
                      [0, 0, 0, 1, 0, 1, 0, 1, 0, 0],
                      [1, 0, 0, 0, 1, 0, 0, 0, 1, 0],
                      [0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
                      [0, 0, 0, 0, 0, 1, 0, 0, 0, 1],
                      [0, 0, 0, 0, 0, 0, 0, 0, 1, 0]])
    G_mat
    ```

  - convert adjacency matrix to a networkx graph

    ```python
    G3 = nx.Graph(G_mat)
    G3.edges() # matches G1
    ```

- **Edgelist**

  - format

    The edge list format represents edge pairings in the first two columns. Additional edge attributes can be added in subsequent columns

    ex) from the first row, we can see the edge between nodes `0` and `1` has a weight of 4.

    ```python
    0 1 4
    0 2 3
    0 3 2
    0 5 6
    1 3 2
    1 6 5
    3 4 3
    4 5 1
    4 7 2
    5 8 6
    8 9 1
    ```

  - way 1) `read_edgelist `

    ```python
    G4 = nx.read_edgelist('G_edgelist.txt', data=[('Weight', int)])
    G4.edges(data=True)
    ```

  - way 2) Pandas DataFrame

    ```python
    G_df = pd.read_csv('G_edgelist.txt', delim_whitespace=True, 
                       header=None, names=['n1', 'n2', 'weight'])
    G5 = nx.from_pandas_dataframe(G_df, 'n1', 'n2', edge_attr='weight')
    G5.edges(data=True)
    ```

  - useful for

    - graphs with **simple edge attributes** and without node attributes

  - not useful for

    - networks with isolated nodes

**Example**

- Chess example

  ```python
  # import
  chess = nx.read_edgelist("chess_graph.txt", 
                           data = [("outcome", int), ("timestamp", float)]
  												 create_using=nx.MultiDiGraph()) # otherwise the direction and additional edges will be lost
  
  # 확인
  chess.edges(data = True)
  ```

  - which player played the most games in our network?

  ```python
  # A dictionary is returned where each key is the player, and each value is the number of games played.
  games_played = chess.degree()
  games_played # dictionary: the sum of both in degree and out degree
  
  # find max
  max_value = max(games_played.values())
  max_key, = [i for i in games_played.keys() if games_played[i] == max_value]
  
  print('player {}: {} games'.format(max_key, max_value))
  ```

  - which player won the most games?

  ```python
  # convert graph to a DataFrame
  df = pd.DataFrame(chess.edges(data = True), columns = ["white", "black", "outcome"])
  
  # pull out the outcome from the attributes dictionary
  df["outcome"] = df["outcome"].map(lambda x: x["outcome"])
  
  # count the number of times a player won
  won_as_white = df[df["outcome"] == 1].groupby('white').sum()
  won_as_black = -df[df["outcome"] == -1].groupby('black').sum()
  win_count = won_as_white.add(won_as_black, fill_value=0) # fill_value fills in the missing value as 0
  
  # find the top five largest
  win_count.nlargest(5, "outcome")
  ```

  

### 정리

| Format           | Code                                                         |
| ---------------- | ------------------------------------------------------------ |
| adjacency list   | `G2 = nx.read_adjlist("G_adjlist.txt", nodetype=int)`        |
| adjacency matrix | `G3 = nx.Graph(G_mat)`                                       |
| edgelist         | `G4 = nx.read_edgelist('G_edgelist.txt', data=[('Weight', int)])` |
|                  | `pd.read_csv('G_edgelist.txt', delim_whitespace=True,                    header=None, names=['n1', 'n2', 'weight'])` |
|                  | `G5 = nx.from_pandas_dataframe(G_df, 'n1', 'n2', edge_attr='weight')` |

