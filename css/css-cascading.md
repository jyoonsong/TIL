# Cascading

CSS 엔진은 선택자 종류에 따라 다른 점수를 매기는 특정도 공식을 가지고 있다. 이 특정도 공식을 올림픽에 비유해서 이해해보도록 하자.

---

### Cascading 이란?

CSS는 기본적으로 부모요소의 속성이 자식 요소에게 **상속**된다. (단, border, position, background, margin, padding 등은 제외이다.) 이때 상속 특성상 하나의 요소는 자신을 둘러싼 모든 요소로부터 잠재적으로 영향을 받기 때문에, 결과적으로는 스타일 간 충돌이 생길 수 있다. CSS는 이러한 충돌이 발생할 경우에 어느 스타일이 우선권을 줄지 정하는 체계를 만들었고, 이를 캐스케이드(Cascade)라고 부른다. 

캐스케이드의 원리에 따라 CSS에서는 

- 가장 **인접**한 피상속자가 우선하고, 
- **직접 적용**된 스타일이 우선하며, 
- **최후**의 스타일이 우선한다.
- 또한 **선택자 종류에 따라 다른 점수를 매기는 특정도 공식**을 가지고 있는데, 주요한 원칙은 다음과 같다.

`!important` >>넘사벽>> **inline style**(1000점) > **id**(100점) > **class**(10점) > **tag**(1점) > `*` (0점)

```scss
ul li {} // 2점
nav ul > li {} // 3점
ul.list > li {} // 12점
#nav li {} // 101점
```

---

### 지양할 것

important는 이제부터 배울 특정도 공식을 무시한다. 따라서 적합한 상황이 아니면 최대한 지양하는 것이 바람직하다.

---

### 특정도 공식 재밌게 설명하기 - CSS 올림픽

> 1등만 기억하는 CSS 세상

[메달 테이블](https://en.wikipedia.org/wiki/2016_Summer_Olympics_medal_table)을 확인해보면 종종 토탈 메달 수는 더 많더라도 금메달 수가 적어 순위가 뒤집히는 경우가 있다. 마찬가지로 CSS의 특정도 공식도 **금메달 수 비교 > 은메달 수 비교 > 동메달 수 비교**로 진행된다.



> 선택자 메달 수 = (금메달, 은메달, 동메달) 로 표시
>
> 누가 금메달, 은메달, 동메달인지 알아봅시다!



- **참여상** - 전체선택자 `*` : (0,0,0)

  보통 전체 요소를 초기화할 때 사용되는 전체선택자는 참여하는 데 의의를 - 점수가 없습니다

- **동메달** - 요소선택자 : 실제 1점

  - `li` (0,0,1)
  - `ul > li` (0,0,2)
  - `nav ul > li` (0,0,3)

- **은메달** - class 선택자 `.` : 실제 10점

  - `.header` (0,1,0)
  - `ul.gnb > li` (0,1,2)
  - `.item .item_title span` (0,2,1)

  ```html
  <header class="header">
    <p>CSS Olympic</p>
  </header>
  ```

  ```scss
  .header p {} // (0,1,1) 가장 강력
  .header // (0,1,0)
  header p {} // (0,0,2)
  ```

- **금메달** - id선택자 `#` : 실제 100점

  한 문서에 딱 하나밖에 존재 못함. 매우 고유한 존재이기에 그만큼 높은 점수를!

  - `#cover` (1,0,0) 
  - `#blog > .items a` (1,1,1)
  - `#main .main_footer ul.footer-list li a` (1,2,2) = 실제 특정도 122

---

### 그외 유용한 선택자

```scss
a:nth-child(2):after {}
a:nth-last-child(2):before {}
a:nth-of-type(2n+1):after {}
div a:only-child {}
ul > li:only-of-type {}
a:not(.disabled) {}
a:visited, a:link {}
a[title] {} // title 속성이 있을 때
a[href*="co"] // co를 어딘가에 포함할 때
a[href^="http"] // http를 처음에 포함할 때
a[href$=".png"] // png를 끝에 포함할 때
a[data-filetype="image"] // 일치할 때
a[data-info~="external"] // 포함할 때 (띄어쓰기로 구분)
input[type="radio"] + label {}
input[type="checkbox"]:checked ~ label {}
p::first-line, p::first-letter {}

```



---

Ref 클래스라이온 보조강의

For 멋사 세미나 준비