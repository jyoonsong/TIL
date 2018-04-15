# 06. Java 복습 - 접근 제어

### 1. 접근 제어

| keyword     | meaning                                  |
| ----------- | ---------------------------------------- |
| `public`    | Class 외부(다른 Class)에서 접근 가능하다             |
| `private`   | Class 외부(다른 Class)에서 접근 불가능하다            |
| default     | 동일 Package에 있는 다른 Class에서 접근 가능하다        |
| `protected` | 동일 Package에 있는 다른 Class에서 접근 가능하다<br />다른 Package에 있는 하위클래스에서도 접근 가능하다 |

```markdown
            | Class | Package | Subclass | Subclass | World
            |       |         |(same pkg)|(diff pkg)| 
————————————+———————+—————————+——————————+——————————+————————
public      |   +   |    +    |    +     |     +    |   +     
————————————+———————+—————————+——————————+——————————+————————
protected   |   +   |    +    |    +     |     +    |         
————————————+———————+—————————+——————————+——————————+————————
no modifier |   +   |    +    |    +     |          |    
————————————+———————+—————————+——————————+——————————+————————
private     |   +   |         |          |          |    

+ : accessible
blank : not accessible
```



<br>



### 2. 양극단 `public` 과 `private`

- 왜 `private`을 사용하는가?

  > 추가적으로 할 수 있는 건 없고, 금지하는 것 이외엔 효과 없는데 왜? 해서 얻는 게 뭐지?

  **Data Encapsulation** ~ **Information Hiding** ~ **Abstract Data Type**

  - 성이 없는 도시에서 내부의 모든 요소에 외부가 접근할 수 있는 것보다는,
    성을 쌓고 성문을 만들어 문을 통해서만 출입해야 한다고 하면 질서 유지에 더 편리.
  - 따라서 모든 데이터 멤버(ADT data)를 `private`으로 만들고 필요한 경우에 `public` 한 get/set 메서드(ADT operations)를 제공한다.

- ADT Operations

  - Getter / Accessor
  - Setter / Mutator

<br>



### 3. `protected`

나중