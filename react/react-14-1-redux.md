# Redux를 편하게 쓰기 위한 발악

### 1. Redux의 3원칙

#### 1.1. Single Source of Truth

Redux를 사용하면 모든 state가 단 한 개의 store에 있다. 

사실 Flux는 여러 개의 store를 사용한다. 특정 업데이트가 너무 빈번하게 일어나거나, 애플리케이션의 특정 부분을 완전히 분리시키게 될 때 여러 개의 스토어를 만들 수도 있다. 하지만 그렇게 하면 개발 도구를 활용하지 못하게 된다.

> store의 데이터 구조는 보통 매우 **nested**되어 있다. 즉 JavaScript 객체로서 `{{{},{},{}},{} }` 이런 식으로 잘 정리되어 있다는 의미이다.

<br>

#### 1.2. State is read-only

> The only way to mutate the state is to **emit an action**, an object describing what happened

Redux에서는 직접 state를 변경할 수 없다. state를 변경하기 위해서는 **오로지 action이 dispatch되는 길 뿐이다**. 생각해보라. 아주 쉽게 변하는 것보다는 불변하는 것이 디버깅하기 더 심플하고 앞뒤로 되돌려 놓기도 편하지 않겠는가.

이는 React에서 state를 업데이트할 때 반드시 `setState`를 사용하고, 배열을 업데이트할 때는 `push` 대신 `concat`을 사용하여 기존 배열 대신 새로운 배열을 만들어 교체하는 것과 같은 이유이다. 엄청 깊은 구조로 된 객체도 마찬가지로 기존 객체를 건드리지 않은 채 `Object.assign`을 사용하거나 spread 연산자 `…`를 사용한다. 

이와 같이 불변성을 유지하는 이유는 내부적으로 데이터 변경을 감지할 때 **shallow equality checking**을 하기 때문이다. 객체의 깊숙한 안쪽까지 비교를 하는 것이 아니라 겉핥기 식으로 비교를 하여 데이터 변경 여부를 판단할 수 있으므로 좋은 성능을 유지할 수 있는 것이다.

<br>

#### 1.3. Changes are made with Pure Functions

> To specify how the state tree is transformed by actions, you write **pure reducers**

action을 dispatch 하여 state값을 변경하는 과정에서 **받아온 action 객체를 처리하는 함수를 Reducer**라고 부른다. 즉 action이 어떤 변화가 일어나야 할지 알려주는 객체라면, Reducer는 그 action 객체와 previous state를 받고, next state를 return하는 함수인 것이다.

이때 **Reducer는 Pure Function**이어야 한다. Pure Function이란, 

1. The function always returns the same result if the same arguments are passed in. It does not depend on any state, or data, change during a program’s execution. It must **only depend on its input arguments**.
2. The function does not produce any observable **side effects** such as: Network requests (HTTP requests), Input and output devices (printing to screen or console), data mutation, DOM Query/Manipulation etc.

Pure function의 예시는 다음과 같다:

```js
// IS pure function
function priceAfterTax(price) {
  return price + (price * 0.2);
}
// NOT pure function
var taxRate = 20;
function calculateTax(price) {
 return (price * (taxRate/100)) + price; 
}
```

결국 다음과 같은 것들을 지키면 되는 것이다:

- 외부 네트워크/데이터베이스에 접근하지 않아야 한다
- return 값은 오직 parameter값에만 의존해야 한다.
- parameter는 직접 변경되지 않아야 한다.
- 같은 parameter로 실행된 함수는 언제나 같은 결과를 return한다
- 순수하지 않은(= 동일한 인풋에도 실행될 때마다 다른 결과값이 나타나는) API 호출을 하지 말아야 한다. 예: `new Date()` `Math.Random()` 등

순수하지 않은 작업은 Reducer 밖에서 **Redux Middleware**를 사용하여 처리해준다.

<br>



### 2. Redux with React

#### 2.0. 개발 환경 세팅

- **절대경로 설정** - `NODE_PATH=src` 
- **패키지 설치** - `yarn add redux react-redux redux-actions immutable`

#### 2.1. 디렉토리 구조

```js
// 주요 컴포넌트
+-- components/
|	+-- App.js
|	+-- AppTemplate.js
|	+-- Counter.js
|	+-- Todos.js
+-- containers/
|	+-- CounterContainer.js
|	+-- TodosContainer.js
+-- Root.js
+-- index.js
```

- **Presentational/Dumb Components** - 단순 뷰만을 보여주기 위해 만들어진 컴포넌트.
  - `AppTemplate` - 두 가지 섹션을 화면에 레이아웃해주는 역할
  - `Counter` - Counter의 뷰만을 보여주는 역할
  - `Todos` - Todos의 뷰만을 보여주는 역할
- **Container/Smart Components** - 리덕스와 연동된 컴포넌트. 
  - `Root` - 최상위 컴포넌트
  - `CounterContainer` - 
  - `TodosContainer` - 

```js
// Redux 관련
+-- store/
|	+-- actionCreators.js
|	+-- configure.js
|	+-- index.js
|	+-- modules/
|	|	+-- index.js
|	|	+-- counter.js
|	|	+-- todo.js
```

- **module** - action & reducer 를 기능별로 분류

  - `counter` - Counter 컴포넌트와 관련된 action & reducer
  - `todos` - Todos 컴포넌트와 관련된 action & reducer

- **store**

  - `configure` - **store 생성 함수 정의**. 

    > configure에서는 **store생성함수를 모듈화하여 export**한다.
    > 하나의 application에는 하나의 store밖에 없긴하지만 exception이 되는 케이스가 있기 때문! 나중에 서버사이드 렌더링을 하게 되면, 서버 쪽에서도 각 요청이 처리될 때마다 store를 생성해주어야 하는데, 그런 작업을 하게될 때 이렇게 store 생성하는 함수를 모듈화하곤 한다(질문)

  - `index` - configure에서 import한 생성 함수를 사용하여 **store를 생성하고, export**

  - `actionCreators` - 