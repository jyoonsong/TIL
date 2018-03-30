# Java 복습 - Enumeration

- `enum`은 **값의 나열**을 나타내는 **타입**

  > Class와 함께 사용자 정의 타입을 구성할 수 있는 방법

  ```java
  enum Color {
    red, blue, green
  }
  ```

- enum Scope가 다르면 같은 이름 사용할 수 있음.

  ```java
  enum Color {
    red, blue, green
  }
  enum TrafficLight {
    green, yellow, red
  }

  public class Enumeration {
    public static void main(String[] args) {
      Color col = Color.red;
      Color col2 = Color.red;
      if (col == col2) { // true
        System.out.println("Same"); 
      }
      TrafficLight light = TrafficLight.red;
    }
  }
  ```

  ​

