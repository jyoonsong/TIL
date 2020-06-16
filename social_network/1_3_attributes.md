## 1. Why Study Networks and Basics on NetworkX

### 1.3. Node and Edge Attributes

- **Edge attributes in NetworkX**

  - **construction**

    ```python
    G = nx.MultiGraph()
    G.add_edge("A", "B", weight = 6, relation = "family")
    G.add_edge("B", "C", weight = 13, relation = "friend")
    ```

  - **accessing the full list of edges**

    ```python
    # list of all edges
    G.edges() 
    # output: [("A", "B"), ("C", "B")]
    ```

    ```python
    # list of all edges with attributes
    G.edges(data = True) 
    # output: [("A", "B", {"relation": "family", "weight": 6}), ("C", "B", {"relation": "friend", "weight": 13})]
    ```

    ```python
    # list of all edges with attribute "relation"
    G.edges(data = "relation") 
    # output: [("A", "B", "family"), ("C", "B", "friend")]
    ```

  - **accessing attributes of a specific edge**

    ```python
    # dictionary of attributes of edge (A, B)
    G.edge["A"]["B"] 
    # output: {"relation": "family", "weight": 6}
    ```

    - undirected weighted graph

    ```python
    # undirected graph, order doesn't matter
    G.edge["B"]["C"]["weight"]
    G.edge["C"]["B"]["weight"]
    # output: 13
    ```

    - directed weighted network

    ```python
    # directed weighted network, order matters
    G = nx.DiGraph()
    G.add_edge("A", "B", weight = 6, relation = "family")
    G.add_edge("B", "C", weight = 13, relation = "friend")
    
    G.edge["B"]["C"]["weight"]
    # output: 13
    G.edge["C"]["B"]["weight"]
    # output: KeyError: 'C'
    ```

    - undirected weighted multigraph

    ```python
    G = nx.MultiGraph()
    G.add_edge("A", "B", weight = 6, relation = "family")
    G.add_edge("A", "B", weight = 18, relation = "friend")
    G.add_edge("B", "C", weight = 13, relation = "friend")
    
    G.edge["A"]["B"] # one dictionary of attributes per (A, B) edge
    # output: {0: {"relation": "family", "weight": 6}, 1: {"relation": "friend", "weight": 18}}
    
    G.edge["A"]["B"][0]["weight"] # undirected, order doesn't matter
    # output: 6
    ```

    - directed weighted multigraph

    ```python
    G = nx.MultiDiGraph()
    G.add_edge("A", "B", weight = 6, relation = "family")
    G.add_edge("A", "B", weight = 18, relation = "friend")
    G.add_edge("B", "C", weight = 13, relation = "friend")
    
    G.edge["A"]["B"][0]["weight"]
    # output: 6
    G.edge["B"]["A"][0]["weight"]
    # output: KeyError: 'A'
    ```

- **Node attributes in NetworkX**

  ex) number of times coworkers had lunch together in one year => nodes colored by their role in the company

  - **adding node attributes**

    ```python
    G = nx.Graph()
    G.add_edge("A", "B", weight = 6, relation = "family")
    G.add_edge("B", "C", weight = 13, relation = "friend")
    
    G.add_node("A", role = "trader")
    G.add_node("B", role = "trader")
    G.add_node("C", role = "manager")
    ```

  - **accessing the full list of nodes**

    ```python
    # list of all nodes
    G.nodes()
    # output: ["A", "C", "B"]
    ```

    ```python
    # list of all nodes with attributes
    G.nodes(data = True)
    # output: [("A", {"role": "trader"}), ("C", {"role": "manager"}), ("B", {"role": "trader"})]
    ```

  - **accessing node attributes**

    ```python
    # specify which node and which attribute
    G.node["A"]["role"]
    # output: "manager"
    ```

### 정리

| what                            | code                                                    |
| ------------------------------- | ------------------------------------------------------- |
| adding node and edge attributes | `G = nx.Graph()`                                        |
|                                 | `G.add_edge("A", "B", weight = 6, relation = "family")` |
|                                 | `G.add_node("A", role = "trader")`                      |
| accessing node and attributes   | `G.nodes(data = True)`                                  |
|                                 | `G.node["A"]["role"]`                                   |
| accessing edge attributes       | `G.edges(data = True)`                                  |
|                                 | `G.edges(data = "relation")`                            |
|                                 | `G.edge["A"]["B"]["weight"]`                            |

 

