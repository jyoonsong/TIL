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



### 2. Structure

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

<br>



### 3. Reducer와 Action

#### 3.1. Ducks 구조

하나의 파일에 reducer와 action을 함께 작성하는 것. (기존 방식으로는 새 액션을 추가할 때마다 두 개의 파일을 건드려야 하므로 불편하다.)

```jsx
// modules/counter.js
// 액션 타입 정의
const INCREMENT = 'counter/INCREMENT'; // 앞에 도메인을 붙임으로써 서로 다른 모듈에서도 같은 액션 이름을 사용 가능
const DECREMENT = 'counter/DECREMENT';

// 액션 생성 함수
export const increment = () => ({ type: INCREMENT });
export const decrement = () => ({ type: DECREMENT });

// 모듈의 state 초기값 정의
const initialState = {
	number: 0
};

// reducer function
export default function reducer(state = initialState, action) { // 디폴트 값 설정 문법
	// reducer는 action type에 따라 변화된 state를 반환
	switch(action.type) {
		case INCREMENT:
			return { number: state.number + 1 };
		case DECREMENT:
			return { number: state.number - 1 };
		default:
			return state; // 아무 일도 일어나지 않으면 현재 상태 그대로 반환 
	}
}
```

<br>

#### 3.2. 액션 생성함수 => createAction

```jsx
// 액션 생성 함수를 만듭니다.
export const increment = createAction(INCREMENT);
export const decrement = createAction(DECREMENT);
```

Redux-actions의 `createAction` 함수는 **세 가지 파라미터**를 받는다.

- `type` - action 이름 (action type의 변수명) 
- `payloadCreator ` - 생략된 경우 action 생성 함수 사용 시의 **파라미터 그대로 반환**
- `metaCreator` - 생략된 경우 meta 값을 따로 생성하지 않는다.

```jsx
const changeInput = createAction('CHANGE_INPUT');
changeInput('새로운 값'); // { type: 'todo/CHANGE_INPUT', payload: '새로운 값' }

const multi = createAction('MULTI');
multi({ foo: 1, bar: 2 }); // { type: 'MULTI', payload: { foo: 1, bar: 2 } }

const sample = createAction('SAMPLE', // type
	(value) => value + 1, // payloadCreator
	(value) => value - 1 // metaCreator
);
sample(1); // { type: 'SAMPLE', payload: 2, meta: 0 }
```



<br>

#### 3.3. switch문 => handleActions 

switch문은 block이 따로 나뉘어 있는 것이 아니므로 불편하다. const 혹은 let의 스코프가 `{}`으로 제한되어 있기 때문이다. 모든 case는 하나의 block 안에 있기 때문에 아래와 같은 귀찮은 일이 발생한다.

```js
switch(value) {
  case 0: 
    const a = 1;
    break;
  case 1:
    const a = 2; // ERROR!
    break;
  default:
}
```

이를 방지하기 위해 handleActions를 사용해서 reducer 함수를 작성하는 것.

```jsx
// 파라미터 handleActions({액션을 처리하는 함수들로 이루어진 object}, 초기 state)
export default handleActions({
  [INCREMENT]: (state, action) => { // 정통 문법
    return { number: state.number + 1 };
  },
  [DECREMENT]: ({ number }) => ({ number: number - 1 }) // 비구조화 할당 + action 참조하지 않으면 생략
}, initialState)
```

<br>

#### 3.4. combineReducers로 reducer 합치기

컴포넌트가 많아지면 한 프로젝트에 reducer 함수가 여러 개 존재하게 된다. 이를 redux의 함수 `combineReducers`로 하나의 reducer로 합쳐주도록 하자. 이렇게 합쳐진 reducers는 **Root Reducer**라고 부른다.

```jsx
// modules/index.js
import { combineReducers } from 'redux';
import counter from './counter';

export default combineReducers({
  counter
  // 여기 추가해주면 된다.
});
```

<br>



### 4. Store

#### 4.1. `configure` - store 생성 함수 정의

```jsx
import { createStore } from 'redux';
import modules from './modules'; // 자동으로 index.js '파일' 불러옴. 폴더로 착각마삼.

const configure = () => {
  const store = createStore(modules);
  return store;
}

export default configure;
```

개발의 편의를 위해 `redux-devtools`를 사용하려면 아래와 같이 코드를 추가해준다.

```diff
import { createStore } from 'redux';
import modules from './modules';

const configure = () => {
+ const devTools = window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__()
+ const store = createStore(modules, devTools);
  return store;
}

export default configure;
```

<br>

#### 4.2. `store/index` - store 생성 & export

```jsx
import configure from './configure'; // 생성함수 import
export default configure(); // store의 생성(생성함수 호출)과 동시에 export
```

<br>



### 5. Redux with React 

#### 5.1. `Root.js`에서 `Provider`로 연결하기

store과 components 사이의 연결을 위해 우리는 일단 `Root.js`로 `store`을 보내 각 컴포넌트가 `store`의 `state`와 `dispatch`를 상속받을 수 있도록 해야 한다.

이를 도와주는 녀석이 바로 `Provider`. 이 녀석에게 `store={store}`로 보내주면 된다.

```diff
import React from 'react';
+ import { Provider } from 'react-redux';
+ import store from './store';

import App from './components/App';

const Root = () => {
  return (
+   <Provider store={store}>
      <App />
+   </Provider>
  );
};

export default Root;
```

<br>

#### 5.2. Container Components

- `connect(mapStateToProps, mapDispatchToProps)`

  Component를 Redux와 연동. 컴포넌트에 props를 넣어줄 함수를 리턴한다.

- `connect(mapStateToProps, mapDispatchToProps)(CounterContainer)`

  컴포넌트에 props를 넣어줄 함수에 해당 컴포넌트를 파라미터로 넣어준다. 그러면 그 컴포넌트로 props가 보내짐.

```jsx
// containers/CounterContainer.js
import React, { Component } from 'react';
import Counter from 'components/Counter';
import { connect } from 'react-redux';
import * as counterActions from 'store/modules/counter';

class CounterContainer extends Component {
  handleIncrement = () => {
    this.props.increment();
  }

  handleDecrement = () => {
    this.props.decrement();
  }
  
  render() {
    const { handleIncrement, handleDecrement } = this;
    const { number } = this.props;

    return (
      <Counter 
        onIncrement={handleIncrement}
        onDecrement={handleDecrement}
        number={number}
      />
    );
  }
}

// input: store의 states
// output: component로 보낼 props
const mapStateToProps = (state) => ({
  number: state.counter.number
});

// input: dispatch
// output: component로 보낼 액션 함수들 (예: handleIncrement, handleDecrement)
const mapDispatchToProps = (dispatch) => ({
  increment: () => dispatch(counterActions.increment()),
  decrement: () => dispatch(counterActions.decrement()) 
  // dispatch 함수에는 action을 실어 보낸다.
})

// 컴포넌트를 리덕스와 연동 할 떄에는 connect 를 사용합니다.
// connect() 의 결과는, 컴포넌트에 props 를 넣어주는 함수.
// 반환된 함수에 다시 우리가 만든 컴포넌트를 넣어주면 됩니다.
export default connect(mapStateToProps, mapDispatchToProps)(CounterContainer);
```

`mapStateToProps`와 `mapDispatchToProps`를 아예 `connect()` 내부에서 정의하면 코드가 더 깔끔해진다.

```jsx
export default connect(
  (state) => ({
    number: state.counter.number
  }),
  (dispatch) => ({
    increment: () => dispatch(counterActions.increment()),
    decrement: () => dispatch(counterActions.decrement())
  })
)(CounterContainer);
```

나중에 여러 모듈에서 액션 생성 함수를 참조해야 할 때는 `bindActionCreators`를 사용하여 바인딩한 후, 이 결과물을 `CounterActions`라는 props로 넣어주게 된다. 일일이 `dispatch( someActionCreator() )` 해주는 것이 번거롭기 때문이다.

```Diff
import React, { Component } from 'react';
import Counter from 'components/Counter';
import { connect } from 'react-redux';
+ import { bindActionCreators } from 'redux';
import * as counterActions from 'store/modules/counter';

class CounterContainer extends Component {
  handleIncrement = () => {
+ 	const { ConterActions } = this.props;
+   CounterActions.increment();
  }

  handleDecrement = () => {
+   const { ConterActions } = this.props;
+   CounterActions.decrement();
  }
  
  render() {
    const { handleIncrement, handleDecrement } = this;
    const { number } = this.props;

    return (
      <Counter 
        onIncrement={handleIncrement}
        onDecrement={handleDecrement}
        number={number}
      />
    );
  }
}

export default connect(
  (state) => ({
    number: state.counter.number
  }),
  (dispatch) => ({
+   CounterActions: bindActionCreators(counterActions, dispatch)
  })
)(CounterContainer);
```

<br>



### 5. 실습

#### 5.1. `createAction`

```jsx
// store/modules/todo.js
import { createAction } from 'redux-actions';

const CHANGE_INPUT = 'todo/CHANGE_INPUT';
const INSERT = 'todo/INSERT';
const TOGGLE = 'todo/TOGGLE';
const REMOVE = 'todo/REMOVE';

export const changeInput = createAction(CHANGE_INPUT);
export const insert = createAction(INSERT);
export const toggle = createAction(TOGGLE);
export const remove = createAction(REMOVE);
```

이번에 만들 액션 생성 함수는 **참조해야 할 값**이 필요하다. 예컨대 `changeInput`은 다음에 어떤 값으로 바뀌어야 할지를 알려주는 값이 필요하고, `insert`는 추가할 내용, `toggle`과 `remove`는 어떤 것을 수정할지 `id`를 알려줘야 한다.

위에서 언급했듯이 `createAction`을 통해 만든 액션 생성함수에 파라미터를 넣어서 호출하면 **자동으로 payload라는 이름으로 통일되어 설정된다**. 따라서 이를 반영하여 아래와 같이 코드를 수정할 수 있다.

```jsx
export const changeInput = createAction(CHANGE_INPUT, value => value);
export const insert = createAction(INSERT, text => text);
export const toggle = createAction(TOGGLE, id => id);
export const remove = createAction(REMOVE, id => id);
```

<br>

#### 5.2. immutable.js

```jsx
let id = 0; // todo 아이템에 들어갈 고유 값 입니다

const initialState = Map({
  input: '',
  todos: List()
});

export default handleActions({
  // 한줄짜리 코드로 반환 할 수 있는 경우엔 다음과 같이 블록 { } 를 생략 할 수 있습니다.
  [CHANGE_INPUT]: (state, action) => state.set('input', action.payload),
  [INSERT]: (state, { payload: text }) => {
    // 위 코드는 action 객체를 비구조화 할당하고, payload 값을 text 라고 부르겠다는 의미입니다.
    const item = Map({ id: id++, checked: false, text }); // 하나 추가 할 때마다 id 값을 증가시킵니다.
    return state.update('todos', todos => todos.push(item));
  },
  [TOGGLE]: (state, { payload: id }) => {
    // id 값을 가진 index 를 찾아서 checked 값을 반전시킵니다
    const index = state.get('todos').findIndex(item => item.get('id') === id);
    return state.updateIn(['todos', index, 'checked'], checked => !checked);
  },
  [REMOVE]: (state, { payload: id }) => {
    // id 값을 가진 index 를 찾아서 지웁니다.
    const index = state.get('todos').findIndex(item => item.get('id') === id);
    return state.deleteIn(['todos', index]);
  }
}, initialState);
```

