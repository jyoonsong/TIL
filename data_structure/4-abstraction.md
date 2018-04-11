# Ch04. Abstraction

> 내가 정리

### Data Abstraction

어떤 큰 일을 작은 의미단위(module)로 분할

중첩되어 큰 작업이 된다.



### ADT

**특정 데이터(data)** 위에서 => **어떤 작업(operations)**이 이루어지는가를 명시해놓은 것

> sorted array => binary search
>
> 서울대생 => student-affairs operations 학점관리, 상벌관리 등..

- good

  ADT operations **isolates** data structure **from** program

  `firstItem = aList.get(1);`

- bad

  Direct access to the data structure

  `firstItem = aList.items[0];`

왜? 전자는 나중에 한 군데만 바꿔도 되지만, 후자는 일일이 바꿔야 함.



---

### ADT with JAVA

ADT 구현을 돕는 Java의 기능을 살펴보자

- Classes
  - Constructors
  - Inheritance
  - Class Object



1. Constructor

```java
public class Sphere {
	private double theRadius;
  
    // constructors
	public Sphere( ) {
		setRadius(1.0);
	} 
	public Sphere(double initialRadius) {
		setRadius(initialRadius);
	}
  
	public void setRadius(double newRadius) {
		if (newRadius >= 0.0) {
			theRadius = newRadius;
		}
	}
	public double radius( ) {
		return theRadius;
	}
	public double volume( ) {
		return (4.0 * Math.PI * Math.pow(theRadius, 3.0)) / 3.0;
	}
	public void displayStatistics( ) {
		System.out.println(“\nRadius = ” + radius( ) + “\nDiameter = ” 
		       + diameter( ) + “\nCircumference = ” + circumference( ) 
		       + “\nArea” + area( ) + “\nVolume” + volume( ));
	}
} 
```

2. Inheritance

```java
public class Ball extends Sphere {
	private String theName;
  
  // Constructors
	public Ball( ) { // at first create a sphere w/ radius 1.0
		setName(“unknown”);
	} 
	public Ball(double initialRadius, String initialName) {
		super(initialRadius);
		setName(initialName);
	}
  
  // New Methods
	public String name( ) {
		return theName;
	}
	public void setName(String newName) {
		theName = newName;
	}
  
  // Overwriting = Overriding
	public void displayStatistics( ) {
		System.out.print(“\nStatistics for a ”+ name( ));
		super.displayStatistics( );
	}
} 
```

3. Class Object

   - Every class is a subclass of the class **Object** => `extends Object`

     ```java
     // 사실 모든
     public class Sphere {...}

     // implicitly means
     public class Sphere extends Object {...}
     ```






### Overriding vs Overloading

> **Object Equality** 를 통해 알아보자

모든 class가 상속하는 class **Object**는 아래 메소드를 가짐

- method `equals()` - check if two **references** are the same 

  ```java
  Sphere sphere1 = new Sphere( );
  Sphere sphere2 = sphere1;
  System.out.println( sphere1.equals(sphere2) ); // true
  // 같은 곳을 가리킴

  Sphere sphere3 = new Sphere(2.0);
  Sphere sphere4 = new Sphere(2.0);
  System.out.println( sphere1.equals(sphere2) ); // false
  // 같은 게 들어있는 서로 다른 곳을 가리킴
  ```



1. 이제 이 `equals` 메소드를 **Overriding (=Overwriting)**해보자

   ```java
   public class Sphere {
   		…
   		public boolean equals(Object sp) {
   			return ((sp instanceof Sphere) 
   				 && theRadius == ((Sphere)sp).radius( ));
   		}
   		…
   }
   ```

   - the same name
   - **the same number & types of parameters**

   => **같은** 메소드로 취급됨. 말 그대로 **덮어씌운 것**



2. 이제 이 `equals` 메소드를 **Overloading**해보자

   ```java
   public class Sphere {
   		…
   		public boolean equals(Sphere sp) {
   			return (theRadius == sp.radius( ));
   		}
   		…
   }
   ```

   - the same name
   - **different number || types of parameters**

   => **다른** 메소드로 취급됨. 하나 더 **load**된다

   ​	즉 parameter 없이 부르면 원래의 `equals`를 사용하는 셈이고, 

   ​	parameter을 넣어 부르면 overloading한 `equals`를 사용하는 셈.

