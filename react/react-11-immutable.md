# Immutable.js - 리액트의 불변함, 그리고 컴포넌트에서 Immutable.js 사용하기

###1. Immutability

#### 1.1. Immutability를 유지하라

리액트 컴포넌트의 State를 업데이트하는 과정에서는 기존 객체의 값을 직접적으로 수정해서는 안된다.

> 리액트는 단방향 바인딩이기 때문. jQuery나 Angular의 양방향 바인딩에서는 상황이 다르다.

```jsx
// bad!
this.state.users.push({ 
  id: 2, 
  username: 'mjkim' 
});
// bad!!
this.state.users[0].username = 'new_velopert';
// bad!!!
this.state.users.push({ 
  id: 2, 
  username: 'mjkim' 
});

this.setState({
  users: this.state.users
});
// bad!!!!
this.setState(({users}) => {
  users.push({ 
    id: 2, 
    username: 'mjkim' 
  });
  return { 
    users
  };
});
```

<br>

#### 1.2. 왜?

리액트는 기본적으로 **부모 컴포넌트가 리렌더링 되면, 자식 컴포넌트 또한 리렌더링된다**. 물론 이 과정은 가상 DOM에서만 이루어지는 렌더링이며, 렌더링을 마치고 리액트의 diffing 알고리즘을 통해 변화가 일어나는 부분만 실제로 업데이트해준다.

그러나 여전히 아무리 실제 DOM에는 반영되지 않는다고 하더라도 CPU 쪽에서는 미세한 낭비가 발생한다. 예컨대 인풋 내용을 수정하는 매 순간 TodoList가 새로 렌더링되고 그 안의 TodoListItem 또한 리렌더링된다. 따라서 이를 최적화하기 위해 우리는 한줄짜리 `shouldComponentUpdate`를 사용해왔다.

```jsx
shouldComponentUpdate(prevProps, prevState) {
  return prevProps.users !== this.props.users;
}
```

이 최적화 과정을 염두에 두고 우리는 state를 업데이트할 때, **불변함을 유지**해주어야 하는 것이다.

<br>

#### 1.3. 불편사항

하지만 불변함을 유지하다보면 코드가 복잡해질 때가 많다.

```jsx
state = {
  users: [
    {
      id: 1,
      username: 'jy',
      email: 'jy@jaeyoon.io'
    },
    {
      id: 2,
      username: 'sj',
      email: 'sj@jaeyoon.io'
    }
  ]
}

// good
const {users} = this.state;
const nextUsers = [...users]; // users 배열을 복사
nextUsers[index] = {
  ...users[index] // 기존 객체 내용 복사하고
  email: 'new_jy@jaeyoon.io' // 바꿀 부분 덮어 씌우고
}
this.setState({
  users: nextUsers // 기존 users는 건드리지 않고 새로운 객체 배열를 만들어 setState
});
```

혹은 state가 어쩌다보니 깊은 구조라면?

```jsx
state = {
  where: {
    are: {
      you: {
        now: 'faded',
        away: true // 요놈을 바꾸고 싶다
      },
      so: 'lost'
    },
    under: {
      the: true,
      sea: false
    }
  }
}

// good...? 불변함은 유지했으나 완전 귀찮다.
const {where} = this.state;
this.setState {
  where: {
    ...where,
    are: {
      ...where.are,
      you: {
        ...where.are.you,
        away: false
      }
    }
  }
}
```

이런 작업을 쉽게 만들어주는 라이브러리가 바로 Immutable.js이다

<br>



### 2. Immutable.js

#### 2.1. 설치

`yarn add immutable` 

<br>

#### 2.2. 규칙

1. 객체는 `Map`
2. 배열은 `List`

---

3. 설정할 땐 `set`
4. 읽을 땐 `get`
5. 읽은 다음 설정할 땐 `update`
6. 내부에 있는 걸 ~할 땐 뒤에 In을 붙인다 `setIn`, `getIn`, `updateIn`

---

7. 일반 JavaScript 객체로 변환할 땐 `toJS`
8. `List`엔 배열 내장함수와 유사한 함수들이 있다 - push, slice, filter, sort, concat 등 전부 불변함 유지
9. `Map`에서 특정 key를 지울 때 혹은 `List`에서 원소를 지울 때 `delete`

<br>

#### 2.3. 예제

```jsx
import { Map, List } from "immutable";

// 1. 객체는 Map
const obj = Map({
  foo: 1,
  inner: Map({
    bar: 10
  })
});
console.log(obj.toJS());

// 2. 배열은 List
const arr = List([Map({ foo: 1 }), Map({ bar: 2 })]);
console.log(arr.toJS());

// 3. 설정할 땐 set(key/index, value)
let nextObj = obj.set('foo', 5);
console.log(nextObj.toJS());
console.log(nextObj !== obj); //true

// 4. 값을 읽을 땐 get(key/index)
console.log(obj.get('foo'));
console.log(arr.get(0)); // List는 index로 읽음

// 5. 읽은 다음에 설정할 땐 update(key/index, updater function)
nextObj = nextObj.update('foo', value => value + 1); // 두번째 parameter는 updater 함수
console.log(nextObj.toJS());

// 6. 2 이상의 층위에 있는 걸 ~할 땐 In을 붙인다
nextObj = obj.setIn(['inner', 'bar'], 20);
console.log(nextObj.toJS());
let nextArr = arr.setIn([0, 'foo'], 10);
console.log(nextArr.getIn([0, 'foo']));

// 8. List 내장함수는 배열 내장함수와 유사
nextArr = arr.push(Map({ qaz: 3 }));
console.log(nextArr.toJS());
nextArr = arr.filter(item => item.get('foo') === 1); // item => item%2==0 하면 짝수 요소만
console.log(nextArr.toJS());

// 9. delete로 key나 원소를 지울 수 있음
nextObj = nextObj.delete('foo');
console.log(nextObj.toJS());
nextArr = nextArr.delete(0);
console.log(nextObj.toJS());
```

<br>

#### 2.4. Record

Immutable은 페이스북이 만들었기 때문에 JSX로 이루어진 List를 렌더링할 수 있는 등 React와 호환이 어느정도 된다. 그러나 **state 자체를 Immutable 데이터로 사용하는 것까지는 지원되지 않는다.** 따라서 state 내부에 하나의 Immutable 객체를 만들어두고, 상태 관리를 모두 이 객체를 통해 진행한다.

```jsx
state = {
  data: Map({
    input: '',
    users: List([
      Map({
        id: 1,
        username: 'velopert'
      }),
      Map({
        id: 2,
        username: 'mjkim'
      })
    ])
  })
}
```

자연히 컴포넌트들에서는 `get` 과 `getIn`을 사용해주어야 한다.

```jsx
// App.js
onButtonClick = (e) => {
  const {data} = this.state;

  this.setState({
    data: data.set('input', '') // input: ''
    .update('users', users => users.push( // users.concat 새 Map을 추가
      Map({
        id: this.id++,
        username: data.get('input')
      })
    ))
  })
}
render() {
  const { onChange, onButtonClick } = this;
  const { data } = this.state;
  const input = data.get('input');
  const users = data.get('users');
}
// UserList.js
renderUsers = () => {
  const { users } = this.props;
  return users.map((user) => (
    <User key={user.get('id')} user={user} />
  ))
}
// User.js
const username = this.props.user.get('username'); // const {username} = this.props.user.toJS(); 비구조화할당
```

계속 `get`, `getIn`하는 게 싫다면 `Record`를 사용하자! Immutable의 set, update, delete 등을 계속 사용할 수 있으면서도 값을 조회할 때 get, getIn을 사용할 필요없이 `data.input` 같은 방식으로 조회할 수 있다.

> Record는 Typescript 혹은 Flow 같은 타입시스템을 도입할 때 굉장히 유용하다 (이해못함)

```jsx
import React from 'react';
import { render } from 'react-dom';
import App from './App';
import { Record } from 'immutable';

const Person = Record({
  name: '홍길동',
  age: 1
});
let person = Person();
console.log(person); // Obejct {name: "홍길동", age: 1}
console.log(person.name, person.age); // 홍길동 1

person.set('name', '송재윤'); // person.name = '송재윤'은 오류! person = person.set('job', 5)도 오류!
console.log(person.name); // 송재윤

// set 대신 이렇게 할 수도 있다
person = Person({
  name: "영희",
  age: 10
})

// 비구조화 할당도 가능
const {name, age} = person;
console.log(name, age);

// 재생성할 일 없을 때
const dog = Record({
  name: '멍멍이',
  age: 1
})();
console.log(dog.name); // 멍멍이

// Nesting
const nested = Record({
  foo: Record({
    bar: true
  })()
})();
console.log(nested.foo.bar); // true

// Map 다루듯이 똑같이 사용
const nextNested = nested.setIn(['foo', 'bar'], false);
console.log(nextNested.foo.bar); // false
```

위에서의 컴포넌트 예시도 아래처럼 간편히 바꿀 수 있다

```jsx
// App.js
onButtonClick = (e) => {
  const {data} = this.state;

  this.setState({
    data: data.set('input', '')
    .update('users', users => users.push( 
      new User({ // Map을 new User로
        id: this.id++,
        username: data.input // get도 사실 작동하지만 굳이 쓸까
      })
    ))
  })
}
render() {
  const { onChange, onButtonClick } = this;
  const { data: {input, users} } = this.state; // 일일이 get할 필요 없이 비구조화할당
}
// UserList.js
renderUsers = () => {
  const { users } = this.props;
  return users.map((user) => (
    <User key={user.id} user={user} /> // 바로 user.id
  ))
}
// User.js
const { username } = this.props.user; // const {user: {username}} = this.props;
```

