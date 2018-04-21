# Ch.07 Stack - Application

### Ex0. 키보드 ←키

`–abcd←←efgh←←←ij←km←` => `abeik`

---

### Ex1. Balance of Braces

> Stack 구조/원리를 설명하기 위한 Example

괄호 어디서 끝나지? 짝이 맞는지 알아봐주는 알고리즘

- `{` 나오면 Push 넣어라 
- `}` 나오면 Pop 제거해라 (match가 제일 위에 있을 것이기 때문)

![image](https://user-images.githubusercontent.com/17509651/39065659-80137dbc-450d-11e8-8085-ff252783fcfe.png)

---

### Ex2. Checking Symmetric Language

> Stack 구조/사용법 연습하기 위한 Example

- Language는 집합과 대응된다!

  - Java Language = Java의 Syntax를 만족하는 String의 집합

    `JAVA = {w| w는 JAVA문법을 만족}`

  - 자연어도 programming language와 마찬가지로 집합으로 볼 수 있다

    > language ~ 문제	/	원소 ~ 해

- `L = {w$w' : w is a possibly empty string w/o $, w' = reverse(w) }`

  ```java
  // $까지 stack에 집어넣는다
  do {
      ch = string.getNextCharacter(); // get하고 커서 옮김
      stack.push(ch);
  } while (ch != '$');
  // remove the top, which is $
  stack.pop();
  // stackTop 즉 w를 뒤에서부터 차례대로 남은 string 즉 w'와 비교한다.
  do {
      if (string.noMoreCharacter()) { // 커서가 끝에 다다름
          if (stack.isEmpty()) return true;
          else return false;
      }
      else {
          if (stack.isEmpty()) return false;
          stackTop = stack.pop();
          ch = string.getNextCharacter();
      }
  } while (ch == stackTop)
  ```

------

### Ex3. Evaluating Postfix Expressions

Operand 만나면

- push

Operator 만나면

- 맨 위 두 개를 pop
- 그 두개를 연산
- 연산 결과를 push

예: `2 3 4 + *`

![image](https://user-images.githubusercontent.com/17509651/39079198-e05717f4-4550-11e8-8f3b-b6b3c842e689.png)

```java
for (each char ch in the expression) {
    if (ch == operand) // operand 만나면
        stack.push(ch); // push
    else if (ch == operator) { // operator 만나면
        operand2 = stack.pop(); // 맨 위 두 개를 pop
        operand1 = stack.pop();
        result = operand1 ch operand2; // 그 두 개를 연산
        stack.push(result);
    }
}
```

> cf) postfix - 예전 미 국방부 미사일 forth로 짬. Stack base의 real time 빠른 성능이기 때문
>
> Cf) prefix - LISP - S expression & tree
>
> cf) 현재의 언어들은 섞여 있다. 연산은 infix, 함수는 prefix

------

### Ex4. Flight Map (중요)

- directed graph (방향성을 가진 그래프)에서 **A로부터 B로 가는 노선이 존재하는가?**
  - 예: R에서 P로 가는 노선은 없다. P에서 Z로 가는 노선은 있다.
  - 도시 수가 많아지면 매우 복잡한 문제
- Stack을 사용해 구현해보자
  - 목적 1. Stack에 익숙해지기 위해
  - 목적 2. 알고리즘 Flow(Recursion 등)에 익숙해지기 위해



**ver 1. non-recursive**

- BackTracking 구조

- A에 인접한 일부는 visited 나머진 unvisited일 때, unvisited에 가능성을 두고 얘를 push!

  혹은 unvisited이 아예 없으면, A를 아예 pop해버림 = A에겐 기대할 게 없다.

  그 밑에 있던 B가 이제 stackTop이 된다.

```java
searchS(originCity, destCity) {
    stack.push(originCity);
	originCity.visited = true;
    
    while (!stack.isEmpty() && destCity() != stack.peek()) {
        // until stack is not empty && destCity is not stackTop
        if (no flight exists from stackTop city to unvisited cities)
            tmp = stack.pop(); // backtracking
        else {
            C = unvisited city that is directly reachable from stackTop;
            stack.push(C);
            C.visited = true;
        }
    }
    if (stack.isEmpty()) return false; // empty : no path
    else return true; // destCity is stackTop : path found
}
```

- 목적도시를 만나면 밖에서 결정하지 말고, 즉시 끝내버리는 버전.

```Diff
searchS(originCity, destCity) {
    stack.push(originCity);
	originCity.visited = true;
    
+   while (!stack.isEmpty()) {
        if (no flight exists from stackTop city to unvisited cities)
            tmp = stack.pop(); // backtracking
        else {
            C = unvisited city that is directly reachable from stackTop;
+           if (C == destCity) return true; // 만난 즉시 끝냄
+           else {
    			stack.push(C);
	            C.visited = true;
			} 
        }
    }
+   return false; // no path
}
```

![image](https://user-images.githubusercontent.com/17509651/39079404-e8b95c1e-4554-11e8-8558-45dda81daa42.png)



**ver 2. Recursive**

- origin => origin' => origin''

  search 후 실패 시 화살표 하나씩 후진

```java
searchS(originCity, destCity) {
    if (originCity == destCity) return true;
    else {
        originCity.visited = true;
        arrived = false;
        for (each x in L(originCity)) { // L(c) = c 도시에 인접한 도시들
            if (x.visited == false) {
                arrived = searchS(x, destCity);
                if (arrived = true) return true;
            }
        }
        return false;
    }
}
```

- 같은 로직. 그냥 코드 짧은 버전

```Diff
searchS(originCity, destCity) {
    if (originCity == destCity) return true;
    else {
        originCity.visited = true;
        for (each x in L(originCity)) { // L(c) = c 도시에 인접한 도시들
+           if (!x.visited && searchS(x, destCity))
+               return true;
        }
        return false;
    }
}
```



> **[참고] DFS Algorithm** - 어떤 노드로부터 시작해서 방문할 수 있는 모든 것

```java
DFS(v) {
  mark[v] <= VISITED;
  for all x in L(v)
     if (mark[v] == NO) DFS(x);
}
```

> **cf) Dijkstra algorithm => 변형한 것이 A***
>
> 이 노드로부터 갈 수 있는 최단경로를 다 계산. DFS와 같지만 거리를 계산한다는 것만 차이점.

------

### Ex5. 메모리 분할과 Stack

> java 뿐만 아니라 프로그램이 run할 때 memory를 어떻게 사용하는가
>
> - 프로그래머들은 OS라는 벽을 통해 **관념적인 메모리**로 생각한다.
> - 따라서 OS 또한 프로그래머한테는 메모리라는 물리적 공간을 직접 접근하지 않고 알아서 관념적으로 매핑해주는 하나의 **abstraction**

![image](https://user-images.githubusercontent.com/17509651/39079439-9356b784-4555-11e8-889b-7691f1c38555.png)

- **Code** : 말 그대로 **소스코드**가 저장되는 공간

- **Data** : 변하지 않는 공간 - **global(=static) 변수** (scope가 넓다보니 에러 유발 가능성 높다)

  - C 

    ```c
    fc {
      ...
    }
    variable; // 함수 등에 속하지 않는 변수가 global 변수
    fc {
      ...
    }
    ```

  - Java

    ```java
    class A {
      public static variable; // static을 붙여놓으면 그 공간이 없어지지 않는다는 특성을 가짐. gloabl 변수인 셈.
      ...
    }
    variable; // 불가능
    class B {
      A.variable; // 이런 식으로 어디서든 접근 가능.
      ...
    }
    ```

- **Heap** : "되는 대로 쌓는다" 의미. 수행 중에 변하는 공간 - **Object**

  > 나중에 나오는 Heapsort 의 heap과는 다른 의미

- **Stack** : 현재 **active한 함수**를 stack으로 처리한다!

  - f 실행 => push
  - f 종료 => pop

=> `Static` : 컴파일러의 입장에서 Code, Data는 프로그램이 끝날 때까지 유지되어 항상 알 수 있는 공간. 실행 직전에 알 수 있는 것들.

(예: 프로그램의 에러를 돌려보지 않고 컴파일 단계에서 알 수 있는 확률이 존재. 이걸 Static Analyze라고 부름)

=> `Dynamic` : 그렇지 않으면 들어온 입력값에 따라 깊이가 결정됨 - Heap, Stack

(예컨대 팩토리알 실행 시 어디까지 될지 입력값을 받아야 앎)



> [잡담] 무한정 큰 virtual memory를 잡을 순 없음. 결국 어떤 크기 제한은 있을 것. Dynamic의 경우 미리 할당해놓으면 그 공간이 불충분할 수도 잇는데, 불충분해지면 알아서 확장하는 기능? 있나요 ㅋㅋㅋ?