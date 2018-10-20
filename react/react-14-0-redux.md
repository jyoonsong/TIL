# Redux -효율적인 데이터 교류

### 1. 배경

#### 1.1. 들어가기 전에

작은 규모의 프로젝트에서는 App.js만으로도 모든 상태를 관리하기에 충분하지만, 규모가 좀 커지면 모든 상태를 App에서 관리하긴 조금 버거워진다. 또 코드의 양이 App.js 쪽에 너무 쏠리기도 하고 말이다. 예컨대 우리가 만들 웹 어플리케이션이 여러 페이지로 구성되어있다면, 각 페이지에서 공유하는 상태가 존재할 수도 있다. 이럴 때 필요한 것이 바로 Redux이다!

**Redux란 JavaScript Application에서 data-state와 UI-state를 관리해주는 도구**이다. 이는 상태적 데이터 관리가 시간이 흐름에 따라 복잡해질 수도 있는 SPA(Single Page Application)에서 매우 유용하다. 그리고 React 뿐만 아니라 jQuery, Angular 등을 사용하는 어플리케이션에서도 사용 가능하다.

<br>

#### 1.2. 왜 필요한가? 

> React는 단방향 바인딩!

React에서는 parent-child 관계를 통해 데이터가 단일 방향으로만 흐른다. 이는 컴포넌트의 개수가 많아지고, 데이터를 교류할 컴포넌트 간의 관계가 parent-child 관계가 아닌 경우 매우 불편하다.

예컨대 빨간색 컴포넌트가 파란색, 초록색 컴포넌트와 데이터를 교류해야 하는 상황을 가정해보자.

- 첫째로 **`ref`를 사용해 컴포넌트끼리 직접 데이터를 교류**하는 방법이 있다. 하지만 이는 React에서 **절대 권장하지 않는 방법**이다. 코드와 컴포넌트 구조가 매우 복잡해지고 스파게티 코드를 만들어버리기 떄문이다.

  ![직접적 데이터 교류](https://velopert.com/wp-content/uploads/2016/04/01.png)

- 그래서 **parent-child 구조를 사용**하여 데이터를 교류해야 하는데, 이도 썩 편한 방법은 아니다.

  ![parent-child 구조를 이용한 데이터 교류](https://velopert.com/wp-content/uploads/2016/04/02.png)

  예컨대 우리는 TodoList 실습을 할 때 부모를 통해 대화했다.

  ![](https://i.imgur.com/nnYKPBo.png)



- 이에 대해 [React Document](https://reactjs.org/docs/components-and-props.html)가 준 해결방안이 바로 **FLUX**라는 디자인 패턴이다.

  > For **communication between two components that don’t have a parent-child relationship**, you can set up your own global event system. … **Flux pattern** is one of the possible ways to arrange this.

<br>



### 2. Flux와 Redux

#### 2.1. FLUX란?

- 우선 기존에 널리 사용되던 대표적인 디자인 패턴인 **MVC 디자인 패턴**부터 알아보자

  action이 입력되면, controller는 model이 지니고 있는 데이터를 조회하거나 업데이트하며, 이 변화는 view에 반영되는 구조이다. 또한 view에서 model의 데이터에 접근할 수도 있다.

  ![MVC의 개념](https://velopert.com/wp-content/uploads/2016/04/MVC.png)

  하지만 model과 view가 늘어나면?

  무한루프가 있을 때 발견하기도 힘든 복잡한 구조가 되어버린다.

  ![MVC의 문제점](https://velopert.com/wp-content/uploads/2016/04/MVC2.png)

  <br>

- 위 문제를 해결해주는 것이 바로 **FLUX 디자인패턴**이다.

  action이 입력되면, dispatcher가 받은 action들을 통제하여 store에 있는 데이터를 업데이트한다. 그리고 변동된 데이터가 있으면 view에 리렌더링한다.

  또한 view에서 dispatcher로 action을 보낼 수도 있다.

  dispatcher은 작업이 중첩되지 않도록 해준다. 즉 어떤 action이 들어와 dispatcher를 통해 store에 있는 데이터를 처리하면, 이 과정이 끝날 때까지 다른 action들은 대기 상태이다.

  ![](https://velopert.com/wp-content/uploads/2016/04/flux-simple-f8-diagram-with-client-action-1300w.png)

<br>

#### 2.2. Redux란?

결론적으로 **Redux**는 위에서 설명한 **Flux 아키텍쳐를 좀더 편하게 사용할 수 있도록 해주는 라이브러리**이다.

![Redux](https://velopert.com/wp-content/uploads/2016/04/03.png)

> Redux를 쓰면, state 관리를 컴포넌트 바깥(redux store)에서 한다!

store에 모든 데이터가 담겨 있다. 컴포넌트끼리는 직접 교류하지 않고 store 중간자를 통해 교류한다. store에서는 `dispatch` 와 `subscribe` 두 메소드가 사용된다.

- **subscribe(listener)**

  ![](https://i.imgur.com/uROrrOc.png)

  > component: 스토어야, 뭐 값 변경되면 알려줘~

  컴포넌트가 store를 subscribe하면 특정 함수(listener)가 스토어에게 전달이 된다. (Component => Store) 

  그리고 나중에 스토어의 state에 변동이 생기면 전달 받았던 listener 함수를 호출하여 변동을 바로 반영한다. (Store => Component)

- **dispatch(action)** 

  ![](https://i.imgur.com/1e4ltmz.png)

  > component: 상태 업데이트 해줘. 업데이트할 땐 내가 준 데이터(action) 참고하구~

  특정 컴포넌트에서 어떤 event가 생겨서 state를 변화할 일이 생겼다. 이때 **dispatch**라는 함수를 통해 컴포넌트는 action을 dispatch에게 던져준다. 즉 store에 상태 변경하라고 알려주는 것이다. (Component => Store)

  **action**이란 state에 변화를 일으킬 때 참조할 수 있는 객체로, `type` 값을 필수적으로 가지고 있어야 한다. 예컨대 `{ type: 'INCREMENT' }` 와 같은 객체를 전달받으면, redux store는 *아~ state에 값을 더해야 하는구나* 하고 action을 참조하게 된다. 그외 optional한 값들은 나중에 알아보자.

- **Reducer**

  ![](https://i.imgur.com/vasxqlQ.png)

  > Store: 흠 state를 바꿔볼까?

  이렇게  전달받은 action을 참조하여 어떻게 state를 업데이트해야 할지 **업데이트 로직을 정의하는 함수**를 Reducer라고 부른다. 이 함수는 두 가지의 파라미터를 받는다.

  - `state` - prevState
  - `action`

  그리고 이 두 가지 파라미터를 참조하여 새로운 state 객체를 return한다.

- **listener 호출**

  ![](https://i.imgur.com/FkqTNhu.png)

  > store (to subscribed component): state 바뀌었으니 참고해!
  >
  > subscribe 하고 있던 component: 오우, 새로운 state? 그럼 rerendering할게

  state에 변화가 생기면, 이전에 subscribe 단계에서 언급했던 listener가 호출된다. 이를 통해 component는 새로운 state를 받게 되고, 이에 따라 리렌더링을 한다.

<br>



### 3. 예제

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <title>그냥 평범한 리덕스</title>
</head>
<body>
  <h1 id="number">0</h1>
  <button id="increment">+</button>
  <button id="decrement">-</button>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/redux/3.6.0/redux.js"></script>
</body>
</html>
```

```js
// 편의를 위한 레퍼런스
const elNumber = document.getElementById('number');
const btnIncrement = document.getElementById('increment');
const btnDecrement = document.getElementById('decrement');

// action type
const INC = 'INCREMENT';
const DEC = 'DECREMENT';

// action 객체 생성 함수
const increment = (diff) => ({ type: INC, diff: diff });
const decrement = () => ({ type: DEC });

const initialState = {
  number: 0
};

/*
 * Reducer Function
 *
 */

const counter = (state = initialState, action) => {
  // state = initialState는 parameter의 디폴트값을 지정해줌
  console.log(action);
  switch(action.type) {
    case INC:
      return {
        number: state.number + action.diff
      };
    case DEC:
      return {
        number: state.number - 1
      };
    default:
      return state;
  }
}

// store를 만들 땐 createStore 안에 reducer function을 넣어 호출한다
const { createStore } = Redux;
const store = createStore(counter);

// state가 변경될 때마다 호출시킬 listener 함수
const render = () => {
  elNumber.innerText = store.getState().number;
  console.log('Rendered');
}

// store에 subscribe하고, 뭔가 변화가 있으면 render 함수를 실행하도록 parameter로 보내줌.
store.subscribe(render);

// 초기 렌더링
render();

// 버튼에 event를 달아준다.
// click 시 action 객체를 넣어 store에게 dispatch한다.
btnIncrement.addEventListener('click', () => {
  store.dispatch(increment(25));
})

btnDecrement.addEventListener('click', () => {
  store.dispatch(decrement());
})
```

1. action type 정의

2. action 생성 함수 정의

   액션에 다양한 파라미터가 필요할 수록 그때그때 직접 `{ 객체 }`를 일일이 작성하는 것이 번거롭기 때문에 함수화.

3. reducer 정의

   각 액션타입마다 액션이 들어오면 어떠한 변화를 일으킬지 정의. 이때 불변성을 유지할 것.

4. store 생성

   Redux의 `createStore`를 사용하여 생성. 안에는 `createStore(reducer)`처럼 reducer를 넣어준다. (혹은 store의 초기 상태, 나중에 배울 middleware를 넣을 수도 있다.)

5. listener 함수 정의

   store에 변화가 생길 때마다 실행시킬 함수. 보통 render함수

6. `store.subscribe(listener)`

7. `store.dispatch( action생성함수() )`

   ​



### Ref

https://redux.js.org/introduction/three-principles

https://medium.com/@jamesjefferyuk/javascript-what-are-pure-functions-4d4d5392d49c
