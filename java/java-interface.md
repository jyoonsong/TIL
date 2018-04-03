# Java - Interface

> 2번과제를 위한 내용 위주

### Concrete vs Abstract 

- **외부 세계와의 계약 (Interface)**
  - 무엇이 구현되어 있는지 계약, 통신(프로토콜)
- **내부적 구현 (Implementation)**
  - 어떻게 동작하는지 코드가 다 나와 있다. 공개되어 있다. = **구현**되어 있다


- **Concrete Type**

  Interface와 Implementation을 모두 포함하고 있다.

- **Abstract Type**

  기능 선언은 되어 있지만, 내부 구현은 다른 클래스에 넘겨 전혀 공개하지 않는 타입

  즉 Interface와 Implementation을 완전히 분리

  ​

### Interface

- Type은 가능한 값의 집합과 연산의 집합을 정의

- Interface는 Abstract Type을 정의

  - 내부 구현에 대한 정보는 전혀 없다

    즉 기능이 있는데, 그 내부는 관심 없다. concrete type에게 맡기겠다.

  - `{}` 부분이 없고 곧바로 `;`로 선언을 마쳐버린다

    ```java
    interface Container {
        double elementAt(int i);
        void set(int i, double e);
        int size();
    }
    ```

- 특징

  - 상수, 메소드 시그너처 등만 가질 수 있다.

  - public abstract method만 가진다.

  - 인스턴스를 바로 만들 수 없다 `Container c = new Container();` (X)

    > abstract type은 모두 인스턴스 만들 수 없음



### `Container` Interface

- Container - abstract
- VectorContainer - `implements` 
  - Container와 생성자 빼고 같은 메소드 지님
  - 그 내용은 모름
  - 그 내용은 Container가 채워주는 것



### `Comparable` Interface

- `sort` 라는 메소드는 `Comparable`을 기본으로 가정하고 짜여 있음.
- 만약 `Comparable`이 아니면 에러남.



### `Iterable` Interface

- ​



### Class Hierarchy

- 계층적 구조를 가진 개념을 표현
- 약속 대로만 만들면 그대로 재사용 가능



### Overriding

```java
// Before
public class Starcraft {
    public static void main(String[] args) {
        Marine marine = new Marine();
        Zergling zergling = new Zergling();
        marine.move();
    }
}
// 작은 곳에서는 따로 만들어 써도 상관 없다.
class Marine {
    public void move() {}
    public void attackWithGun() {}
    public void draw() {}
    public void stimpack() {}
}
class Zergling {
    public void move() {}
    public void attackWithClaw() {}
    public void draw() {}
    public void burrow() {}
}
```

```java
// After
public class Starcraft2 {
    public static void main(String[] args) {
        Marine marine = new Marine();
        Zergling zergling = new Zergling();
        marine.move();
    }
}
// 같은 메소드는 오버라이드
class Unit {
    public void move() {}
    public void draw() {}
}
class Marine extends Unit {
    public void attackWithGun() {
    }
    @Override
    public void draw() {
    }
    public void stimpack() {
    }
}
class Zergling extends Unit {
    public void attackWithClaw() {
    }
    @Override
    public void draw() {
    }
}
```

- `Marine` 이나 `Zergling` 이나 움직이는 것은 `move` 똑같지만, 

  각자 다른 그림을 그리게 `draw` 될 것이다.

- 따라서 보다 상위 개념의 클래스로부터 기능을 빌려오거나 `move` 

  더 구체적인 기능을 제공하기 위해 `draw` 상속을 한다.

  - 이를 `extend` 키워드로 표시한다. 즉 자식 클래스는 부모 클래스를 확장하는 것이다.
  - 이중 더 구체적인 기능을 제공하는 것을 `overriding`이라고 한다.
    - `Overriding` - 부모가 제공하는 것을 재정의하는 것
    - `Overloading` - 이름은 같지만 시그너쳐(인자, 리턴타입)가 다른 메소드를 정의하는 것



### Polymorphism

동시에 여러 가지를 할 수 있는 것을 구현.

예컨대 부모 클래스를 만들어 상속시켜, 한 코드로 다양한 기능을 수행할 수 있도록 하는 것

`Overloading`도 Class Hierarchy와는 상관없지만 Polymorphism의 일례.





### Object

모든 type은 Object Class를 암묵적으로 상속받는다.

- `equals`
- `hashCode` - 어떤 두 타입의 값이 같으면, 같은 정수를 리턴해주는 메소드로 `equals`에 사용됨.
- `toString`
- 등은 기본적으로 모두가 다 가지고 있다.



### Exception

모든 Exception 종류들은 Exception Class를 상속받는다.

```java
public class CommandNotFoundException extends Exception {
    private String command;
    public CommandNotFoundException(String command) {
        super(String.format("input command: %s", command));
        this.command = command;
	}
    private static final long serialVersionUID = 1L;
    public String getCommand() {
        return command;
	} 
}
```

부모에게 있는 걸 그대로 쓰고 싶다 => 구현 안 하면 됨

따로 뭘 더 추가하고 싶다 => `super`로 호출





### Abstract Class

```java
public interface ConsoleCommand {
    void parse(String input) throws CommandParseException;
}
public abstract class AbstractConsoleCommand implements ConsoleCommand {
@Override
public void parse(String input) throws CommandParseException {
    String[] args = input.split(" *% *%? *");
    if (input.isEmpty())
        args = new String[0];
    parseArguments(args);
}
```

