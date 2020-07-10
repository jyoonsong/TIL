* plot graph

```python
import networkx as nx
import pandas as pd
import numpy as np
from networkx.algorithms import bipartite

def plot_graph(G, weight_name=None):
    '''
    G: a networkx G
    weight_name: name of the attribute for plotting edge weights (if G is weighted)
    '''
    %matplotlib notebook
    import matplotlib.pyplot as plt
    
    plt.figure()
    pos = nx.spring_layout(G)
    edges = G.edges()
    weights = None
    
    if weight_name:
        weights = [int(G[u][v][weight_name]) for u,v in edges]
        labels = nx.get_edge_attributes(G,weight_name)
        nx.draw_networkx_edge_labels(G,pos,edge_labels=labels)
        nx.draw_networkx(G, pos, edges=edges, width=weights);
    else:
        nx.draw_networkx(G, pos, edges=edges);
```

* assignments

```python
def answer_one():
        
    # Your Code Here
    G = nx.read_edgelist("Employee_Movie_Choices.txt", delimiter="\t")
    
    return G # Your Answer Here
```

```python
def answer_two():
    
    # Your Code Here
    G = answer_one()
    for node in G.nodes():
        if (node in employees):
            G.add_node(node, type = "employee")
        elif (node in movies):
            G.add_node(node, type = "movie")
    
    return G # Your Answer Here
```

```python
def answer_three():
        
    # Your Code Here
    G = answer_two()
    P = bipartite.weighted_projected_graph(G, employees)
    
    return P # Your Answer Here
```

- combine two graphs `nx.compose(G1, G2)`

```python
def answer_four():
        
    # Your Code Here
    P = answer_three()
    P.edges(data=True)  
    G = nx.read_edgelist("Employee_Relationships.txt", delimiter="\t", data=[('Weight', int)])

    combined = nx.compose(P, G)
    for edge in combined.edges(data=True):
        if (len(edge[2]) < 2):
            edge[2]["weight"] = 0

    data={}
    data['relationship'] = [x[2]["Weight"] for x in combined.edges(data=True)]
    data['movie'] = [x[2]['weight'] for x in combined.edges(data=True)]
    df1 = pd.DataFrame(data)
        
    return df1.corr()["movie"]["relationship"] # Your Answer Here
```

