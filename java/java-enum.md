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
      Color col2 = Color.red; // TrafficLight type이었으면 incomparableError
      if (col == col2) { // true
        System.out.println("Same"); 
      }
      TrafficLight light = TrafficLight.red;
      // Color y = TrafficLight.red; // compile error 
      // int i = Color.red; // compile error
    }
  }
  ```

- `enum` Class는 각종 멤버 변수/메서드를 가질 수 있다.

  ```java
  enum Planet {
    MERCURY (3.303e+23, 2.4397e6),
    VENUS  (4.869e+24, 6.0518e6),
    EARTH  (5.976e+24, 6.37814e6),
    MARS  (6.421e+23, 3.3972e6),
    JUPITER (1.9e+27, 7.1492e7),
    SATURN (5.688e+26, 6.0268e7),
    URANUS (8.686e+25, 2.5559e7),
    NEPTUNE (1.024e+26, 2.4746e7);
    private final double mass; // in kilograms 
    private final double radius; // in meters 
    Planet(double mass, double radius) {
        this.mass = mass;
        this.radius = radius;
  	}
    private double getMass() { return mass; }
    private double getRadius() { return radius; }
    // universal gravitational constant (m3 kg-1 s-2) 
    public static final double G = 6.67300E-11;
    double surfaceGravity() {
      return G * mass / (radius * radius);
    }
  }

  public class Enumeration2 {
      public static void main(String[] args) {
          double earthWeight = 50.0;
          double mass = earthWeight / Planet.EARTH.surfaceGravity();
          for (Planet p: Planet.values()) {
              System.out.printf("Weight on %s is %f%n", p, p.surfaceWeight(mass)); // method 사용
  		} 
  	}
  }

  ```

  위 코드의 Output

  ```shell
  Weight on MERCURY is 330300000000000000000000.000000
  Weight on VENUS is 4869000000000000000000000.000000
  Weight on EARTH is 5976000000000000000000000.000000
  Weight on MARS is 642100000000000000000000.000000
  Weight on JUPITER is 1900000000000000000000000000.000000
  Weight on SATURN is 568800000000000000000000000.000000
  Weight on URANUS is 86860000000000000000000000.000000
  Weight on NEPTUNE is 102400000000000000000000000.000000
  ```

  ​

