# Ch.6 Recursion - Backtracking

> Ch.3보다 심화적으로 Recursion 다룰 것. 아래 두개를 중점으로
>
> 1. **BackTracking**
> 2. Formal Grammars

### 정의

여러 방식으로 정의가 가능하다.

- A search strategy by a sequence of guesses

  guesses => retraces in reverse order => tries a new sequence of steps

  **가는 데까지 가보고 안되면 되돌아와 다른 걸로 가는 방식**

- **DFS (Depth First Search) 방식으로 Search**하는 모든 방식

- Recursion 외에 **Stack과도 밀접**한 관련


---


### 예: Eight-Queens Problem 

- 조건
  - 8x8격자에 여왕을 놓아야함
  - 하면 안되는 것: within its row / withinits column / alongits diagonal


- 풀이
  - 1차 시도
    - `placeQueens(1)` while문 진입. underAttack아니므로 (1,1)에 놓고 본다

      - `placeQueens(2)` 호출됨. 1,2는 underAttack (2,3)에 놓고 본다.

        - `placeQueens(3)` 호출됨. 1,2,3,4 underAttack (3,5)에 놓고 본다.

          - `placeQueens(4)` 1은 underAttack (4,2)에 놓고 본다.

            - `placeQueens(5)` 1,2,3은 underAttack. (5,4)에 놓고본다.
              - `placeQueens(6)` while문 다 돌아도 모두 underAttack. 
            - `placeQueens(5)`로 다시 return. `placeQueens(6)`이 return한 queenPlaced가 false이므로 removeQueen하고 row++한 후 새로운 루프를 돈다. 이번에는 (5,8)이 또 가능하다
              - `placeQueens(6)` while문 다 돌아도 모두 underAttack. 
            - 그러나 다 돌아도 모두 underAttack.

          - `placeQueens(4)`로 다시 return. `placeQueens(5)`가 return한 queenPlaced가 false => removeQueen, 새로운 루프를 돈다. 이번에는 (4,7)이 또 가능하다.

            - `placeQueens(5)` 호출됨. 1은 underAttack (5,2)에 놓고 본다.

              - `placeQueens(6)` 1,2,3은 underAttack (6,4)에 놓고 본다.

                - `placeQueens(7)`1…5 underAttack (7,6)에 놓고 본다.

                  - `placeQueens(8)` 모두 underAttack

                - `placeQueens(7)`로 다시 return. 새로운 루프 돌지만 다 돌아도 모두 underAttack

                  ...

  > 하다보면 답은 12가지

=> 재귀적 구조

재귀로 가보고, **안되면 포기한다**

> 앞에서 배운 재귀에서는 포기는 없었음. 그래서 이게 advanced recursion

```java
public boolean placeQueens(int col) {
    // queens are placed correctly in columns 1 through (col-1)
    // return true if solution is found
    // return false if no solution
    if (col > BOARD_SIZE) return true; // 성공
    else {
        boolean queenPlaced = false;
        int row = 1;	// square id in column
        while (!queenPlaced && row <= BOARD_SIZE) {
            if (isUnderAttack(row, col))
                ++row;
            else {
                setQueen(row, col);
                queenPlaced = placeQueens(col+1);
                if (!queenPlaced) {
                    removeQueen(row, col);
                    ++row;
                }
            }
        }
        return queenPlaced;
    }
}
```



---

[from 쉽알]

### 미로 찾기 문제

```java
maze(v) {
    v.visited = YES;
    if (v == T) return "성공";
    for ( each x in L(v) )		// L(v)는 정점 v와 인접한 정점 집합
        if (x.visited == NO) {
            x.prev = v;		// 경로는 T에서부터 prev를 따라가면 S에 이르게 됨
            maze(x);			// 막다른 골목, 즉 T 아닌데 더 이상 L(v) 없으면 알아서 종료 후 새로운 루프 시작
        }
}
```



### 색칠 문제

k개의 색상으로 인접한 정점은 같은 색상이 칠해지지 않도록 그래프(총 n개 정점)를 칠할 수 있는가?

```java
// 정점 i-1까지는 제대로 칠이 된 상태에서 정점 i를 c로 칠하려면 k개의 색으로 충분한가?
kColoring(i, c) { // i:정점, c:color
    if ( valid(i,c) ) {
        i.color = c;
        if (i == n) return true; // 다 칠했을 때
        else {
            result = false;
            d = 1;	// d: color
            while (result == false && d <= k) {
                result = kColoring(i+1, d);
                d++;
            }
        }
        return result;
    } 
    else {return false;}
}

// 정점 i-1까지는 제대로 칠이 된 상태에서 정점 i를 c로 칠하면 이들과 색이 겹치지 않는가?
valid(i, c) {
    for (int j = 0; j < i; j++)
        if ( (i, j) is in E && j.color = c) return false;
    	// 정점 i와 다른 정점 j 사이에 간선이 있다(접했다) && 그 j의 색상이 c로 같다
    return true;
}
```

- 최초에는 kColoring(1,1) 호출 => valid => kColoring(2,1) 호출 

  - kColoring(2,1) => invalid(정점 2와 1 인접 && 같은 색상) => 종료

- kColoring(2,2) 호출

  - kColoring(2,2) => valid => kColoring(3,1) 호출

    - kColoring(3,1) => invalid(정점 3과 1 인접 && 같은 색상) => 종료

  - kColoring(3,2) 호출

    - kColoring(3,2) => valid (정점 3과 2 인접하지 않음 같은 색상 가능) => kColoring(4,1) 호출

      ...