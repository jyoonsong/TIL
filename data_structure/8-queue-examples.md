# Ch.08 Queue - Application

### Ex1. Recognizing Palindromes

Palindromes = {w | w reads the same left to right as right to left}

```java
boolean isPal(w) {
    for (i = 1 to w.length()) {
        queue.enqueue( w[i] );
        stack.push( w[i] );
    }
    // start to compare
    while (!queue.isEmpty()) { // !stack.isEmpty() 해도 똑같음
        if (queue.dequeue() != stack.pop()) return false;
    }
    // finished with empty queue & empty stack
    return true;
}
```

---

### Ex2. Search Problem in Flight Map 

Is there a path from P to Z? 이번엔 queue로 해보자

> P => (f=P) RW => (f=R) WX => (f=W) XSY => (f=X) SY => (f=S) YT => (f=Y) T => Z는 enqueue되지 않고 바로 return true

```java
searchS(originCity, destCity) {
    queue.enqueue(originCity);
    originCity.visited = true;
    
    while (!queue.isEmpty()) {
        firstCity = queue.dequeue();
        for (each x in L(firstCity)) { // L(c) = firstCity와 인접한 unvisited 도시
            if (x != destCity) {
                queue.enqueue(x);
                x.visited = true;
            }
            else return true;
        }
    }
    return false;
}
```



**[참고] DFS와 BFS Algorithm** - 어떤 노드로부터 시작해서 방문할 수 있는 모든 것 Search

- Depth-First Search(DFS) - stack 방식의 search

  ```java
  DFS(v) {
    mark[v] <= VISITED;
    for all x in L(v)
       if (mark[v] == NO) DFS(x);
  }
  ```

- Breadth-First Search(BFS) - queue 방식의 search

> **cf) Dijkstra algorithm => 변형한 것이 A***
>
> 이 노드로부터 갈 수 있는 최단경로를 다 계산. DFS와 같지만 거리를 계산한다는 것만 차이점.