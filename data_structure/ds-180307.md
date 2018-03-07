# Ch02. Problem Solving and Software Engineering

> 문병로 교수님 Data Structure 180307



### Type of Problems

- **Unsolvable Problems**

  우리의 체계 하에서는 풀 수 없는 문제들. Undecidable Problems의 CS판

  - [Kurt Godel's incompleteness theorem](https://en.wikipedia.org/wiki/G%C3%B6del%27s_incompleteness_theorems)
  - [halting problem](https://en.wikipedia.org/wiki/Halting_problem)

- **Solvable Problems**

  - **Intractable Problems**

    현실적 제약조건 하에서 풀 수 없는 문제들.

    - [NP-hard](https://en.wikipedia.org/wiki/NP-hardness) & [NP-complete](https://en.wikipedia.org/wiki/NP-completeness)

  - **Tractable Problems**

    현실적 제약조건 하에서 풀 수 있는 문제들

    - 자료구조에서 다룰 것들!



### Problem Solving

- 어떻게? algorithms + data structures 를 통해.

- 이때 for efficient **algorithm** design, we need carefully design good **data structure**

  비효율적이면 간단한 문제도 평생 걸릴수도



### Software Lifecycle

- **specification** - 무엇을. 만들 SW의 **규격**을 정하는 단계
- **design** - 어떻게. 규격에 맞춰 만들지 **설계**하는 단계
- **coding (+debugging)** - 코딩으로 실제 구현하는 단계
- **testing** - 필드 나가기 이전. 사실 테스팅이 완벽할 수는 없음. 모든 테스트 할 순 없음. 
- **maintenance** - 필드 나간 후. 그래서 **유지보수**가 필요.

=> 고급 엔지니어일수록 앞부분(specification, design)에 더 많은 시간을 쏟는다. 

	> 우리나라는 국제적 이동통신 규격 CDMA를 최초로 상용화하였다. 왜일까? IT강국이라서? NO
	>
	> 일본은 아주 사소한 에러까지도 잡아내는 꼼꼼함이 특징이라면, 한국은 '필드에서 일단 저질러보자!' 주의가 아주 강하다. 즉 CDMA의 아주 복잡한 specification들 중 기본적 통화에 필요하지 않은 것은 제쳐두고 개통해버린 것이다. 그래서 최초 상용화가 가능했던 것. 당연히 초기에는 통화품질이 매우 엉망이었다. design단계 및 testing 단계를 소홀히 했기에, 결국 maintenance 단계에서 거의 모든 것을 고치게 된다. 우리나라 소비자가 관대하기에 가능했던 일화.

=> 우리가 할 과제에서는 specification은 주어지니, design, coding, testing 단계를 열심히 해보라. 특히 design과 testing! (test case 많이 확보하자..)



### Good Solution?

**= Efficient** (Good Algorithm)

- Low **Resource**, Minimal **Cost**
  - running time
  - development time
    - coding, testing etc
  - maintenance time
    - OOP(C++, Java)의 장점. 프로젝트가 아주 크지 않은 경우 development time은 커질 수 있으나, 유지보수 시간은 줄어든다. 



### Abstraction

Separates the purpose of a module from its implementation details. (~Information Hiding)

> Wall(procedural abstraction) and Mirrors(recursive relation)

- **Procedural Abstraction** - Algorithms

  - Separates the purpose of a method (function) from its implementation details.
    - 예: n개 평균을 구하라는 problem <= n개 평균 구하는 함수 <= 그 안에서 부를 함수 <= 그 안 코드 ...

- **Data Abstraction** - Data Structures

  - Separates the operations of data from how you will implement them
    - 예: stack 자료 구조를 사용하기로 했을 때, stack에 집어 넣고 빼는 구체적 방식은 black box.

- **ADT(Abstract Data Type)**

  A collection of data and a set of operations on the data.

  데이터 어떤 operations를 이용할 건지 정해놓은 것.



### Programming Issues

- **Modularity**
  - interaction을 가능하면 줄일 수 있는 모듈화 구조를 design
  - 예: A structure chart showing the hierarchy of modules (figure 2.4)
- **Modifiability**
  - OOP 수정성 good (우리 사고 관점이기 때문)
  - 절차적 언어는 수정성 bad (프로그래밍 언어의 관점이기 때문)
- **Ease of Use**
  - Comment
  - Documentation
- **Fail-safe Programming**
  - 예: C의 switch문에서 case들이 모든 것을 커버한다고 생각해서 default를 생략하면? 나중에 알 수 없는 에러 발생할 수도. 미리 대비하는 것이 좋다
- **Style**
  - Use of methods; use of private data files; error handling; readability; documentation
- **Debugging**



