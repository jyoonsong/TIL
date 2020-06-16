## 1. Why Study Networks and Basics on NetworkX

> Different types of networks in the real world and why we study them

### 1.1. Networks: Definition and Why we study them

- **Definition**

  - a set of objects (nodes) with interconnections (edges)

- **Why study networks?**

  **1) networks are everywhere**

  : many complex structures can be modeled by networks

  - type 1. Social Networks

    : people (node) relationship (edge)

    - ex) friendship network in a 34-people karate club

    - ex) network of friendship, marital tie, and family tie among 2200 people

      edges are colored to represent the particular type of relationship 

      between the nodes

    - ex) E-mail communication network among 436 HP employees

      edges = communication through email

  - type 2. Transportation and Mobility Networks

    - ex) network of direct flights around the world

    - ex) human mobility network based on location of dollar bills

      Where's George 웹사이트: tracking bill's movement

    - ex) Ann Arbor bus transportation network

      edge = direct bus routes from one stop to the next stop

  - type 3. Information Networks

    - ex) communication between left-wing and right-wing political blogs

      clustering between the two types of blogs

    - ex) internet connectivity

    - ex) network of wikipedia articles about climate change

      edge = URL connections or direct connections between one article and the next

      clustering by the different sub-topping within climate change (colors)

  - type 4. Biological Networks

    - ex) protein-protein interactions
    - ex) Chesapeake Bay waterbird food web

  - financial networks, co-authorship networks, trade networks, citation networks...

  => useful in all different types of context (our focus is on social networks)

  **2) what can we do with them?**

  : studying the structure of a network can allow us to answer questions about complex phenomena.

  - ex) email communication network among 436 HP employees
    - Is a rumor likely to spread in this network?
    - who are the most influential people in this organization?

  - ex) friendship network in a 34-people karate club
    - Is this club, likely to split into two groups? yes
    - If so, which nodes will go to which group?

  - ex) network of direct flights around the world
    - which airports are at highest risk for virus spreading
    - are some parts of the world more difficult to reach by air transportation?

