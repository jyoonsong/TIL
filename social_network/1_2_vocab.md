## 1. Why Study Networks and Basics on NetworkX

### 1.2. Network Definition and Vocabulary

- **Definition of Network/Graph**

  - a representation of connections among a set of items
    - items = nodes = vertices
    - connections = edges = links = ties

  - how to create a network in NetworkX

    ```python
    import networkx as nx
    G = nx.Graph()
    G.add_edge("A", "B")
    G.add_edge("B", "C") # A - B - C
    ```

- **Vocabulary**

  - **Undirected Network**: edges have no direction (or not important)

    ex) network of friendship, marital tie, and family tie among 2200 people

    - nodes: people

    - edges: friendship, marital, or family ties

      => mostly **symmetric relationships**

    ```python
    G = nx.Graph()
    G.add_edge("A", "B")
    G.add_edge("B", "C") # A - B - C
    ```

  - **Directed Network**: edges have direction

    ex) food web

    - nodes: birds

    - edges: what eats what

      => **asymmetric relationships** (direction has a very important meaning)

    ```python
    G = nx.DiGraph()
    G.add_edge("B", "A") # order matters
    G.add_edge("B", "C") # A <- B -> C
    ```

  - **Weighted Networks**: a network where edges are assigned a (typically numerical) weight.

    ex) Number of times coworkers had lunch together in one year

    ```python
    G = nx.Graph()
    G.add_edge("A", "B", weight = 6)
    G.add_edge("B", "C", weight = 13) # A -6- B -13- C
    ```

  - **Signed Networks**: a network where edges are assigned positive or negative sign (carry information about not only friendship but also antagonism based on conflict or disagreement)

    ex) In Epinions and Slashdot people can declare friends and foes

    ```python
    G = nx.Graph()
    G.add_edge("A", "B", sign = "+")
    G.add_edge("B", "C", sign = "-")
    ```

  - **Other Edge Attributes**: edges can carry many other labels or attributes

    ex) colored - particular type of relationship (family, friend, coworker,...)

    ```python
    G = nx.Graph()
    G.add_edge("A", "B", relation = "friend")
    G.add_edge("B", "C", relation = "coworker")
    G.add_edge("C", "D", relation = "family")
    ```

  - **Multigraphs**: a network where multiple edges can connect the same nodes. (**parallel edges**) a pair of nodes have different types of relationships simultaneously 

    ex) relationship between nodes A and B are not only friends but also neighbors

    ```python
    G = nx.MultiGraph()
    G.add_edge("A", "B", relation = "friend")
    G.add_edge("A", "B", relation = "neighbor")
    ```

