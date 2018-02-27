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

