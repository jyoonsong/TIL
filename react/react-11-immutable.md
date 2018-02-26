# Immutable.js - 리액트의 불변함, 그리고 컴포넌트에서 Immutable.js 사용하기

###1. 단방향 바인딩

리액트 컴포넌트의 State를 업데이트하는 과정에서는 기존 객체의 값을 직접적으로 수정해서는 안된다.

> Velopert 오류 - `class Hello extends React.Component` 부분에서 `React.Component`를 써줬으므로 `import React, { Component } from 'react';`에서 별도로 `{Component}`를 import 해주지 않아도 된다.

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
// good
this.setState({
  id: 2
  username: 'mjkim'
});
```

<br>



#### 1.2. 함수형 컴포넌트

**LifeCycle API도 state도 사용하지 않고, 그저 props만 전달받아 뷰를 렌더링하기만 하는 역할**의 컴포넌트는 함수형 컴포넌트 형식으로 컴포넌트를 정의할 수 있다.

```jsx
import React from 'react';

function Hello(props) {
    return (
      <div>Hello {props.name}</div>
    );
}

export default Hello;
```

Arrow Function을 사용하면 다음과 같이 간결히 작성할 수도 있다.

```jsx
import React from 'react';

const Hello = (props) => (
  <div>Hello {props.name}</div>
);

export default Hello;
```

이를 [Destructuring Assignment of Object](https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment)을 사용해 다음과 같이 나타낼 수도 있다.

> Destructuring Assignment는 Object/Array로부터 다른 변수로 각 원소의 값을 destructure(unpack)하여 assign 할 수 있는 JavaScript Expression입니다.
>
> `[a, b] = [10,20]`  a=10, b=20
>
> `var o = {p: 42, q: true}; var {p, q} = o;` p=42, q=true
>
> `({a, b, …rest}) = {a: 10, b: 20, c: 30, d: 40};` a=10 b=20 rest={c: 30, d: 40}
>
> `var o = {p: 42, q: true}; var {p: foo, q: bar} = o;` foo=42, bar=true

```jsx
import React from 'react';

const Hello = ({name}) => {
  return (
  	<div>Hello {name}</div>
  );
}

export default Hello;
```

<br>



### 2. 언제 사용해야 하는가?

- **LifeCycle API 혹은 state를 전혀 사용하지 않을 때**
- 자체 기능은 따로 없고 **props가 들어가면 뷰가 나온다는 것을 명시**할 때
- Redux 사용하여 컴포넌트를 구성할 때, **Container(Smart) 컴포넌트**는 **Class형** 컴포넌트를 사용하고, **Presentational(Dumb) 컴포넌트**는 **함수형** 컴포넌트를 사용
- 아직 함수형 컴포넌트의 성능이 최적화되진 않았다고 함. 하지만 [React 16+에서는 이전 버전에서보다 속도가 더 빨라졌으며](https://twitter.com/trueadm/status/916706152976707584), [첫 마운팅 속도에 있어서도 7%~11% 빠르다](https://github.com/missive/functional-components-benchmark)고 한다.

