# Ch5. Linked List 

### Call by Reference

- call 시, formal variable은 actual variable을 가리키는 **reference variable**
  - method에서 actual variable 값 바꿀 수 있음
  - 예: FORTRAN

### Call by Value

- call 시, formal variable은 actual variable의 **값(주소, 숫자, char 등)을 복사**
  - method에서 actual variable 값 바꿀 수 없음

  - 단, actual variable이 주소(포인터)인 경우 바꿀 수 있음

  - 예: Java

    > Primitive type의 경우 바로 value가 있기 때문에 해당 value가 복사됨
    >
    > Object의 경우 reference variable을 거치기 때문에 해당 주소가 복사됨



### 예

```java
Integer x = new Integer(9);
int y = 9;

changeNumber(x, new Integer(5)); // 안 바뀜 call by value
public void changeNumber(Integer n, Integer k) {
	n = k;
}

changeNumber2(x, 5); // 바뀜 call by value
public void changeNumber2(Integer n, int k) {
	n.setValue(k);
}

changeNumber3(y, 5); // 안 바뀜 call by value
public void changeNumber3(int m, int k) {
  	m = k;
}
```

- 왜 첫번째는 안 바뀔까?

  ![image](https://user-images.githubusercontent.com/17509651/38651635-4b864d9e-3e3d-11e8-8e41-ed8243b83d7f.png)





### 참고

> 함수 call은 stack을 사용해서 이루어짐. (대조적 개념: queue)

```java
main() {
  b();
  c();
}

b() {
  d();
  e();
}
// main 쌓임 => b 쌓임 => d 쌓임 => d 빼고 e 쌓임 => e뺌 => b 빼고 c 쌓임 => c빼고 main 종료
```

>global variable 최대한 피하자
>
>필요없는 scope에까지 닿는 variable은 에러 유발.

