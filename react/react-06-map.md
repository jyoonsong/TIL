# 컴포넌트 Iteration - Map

###1. `Array.prototype.map`

- **정의**

  JavaScript의 Array 객체 내장함수 `map()`은 파라미터로 전달된 함수를 통해 배열 내 각 요소를 프로세싱하여 그 결과로 새로운 배열을 생성한다.

- **문법**

  `arr.map(callback, [thisArg])`

  - `callback` - 새로운 배열의 요소를 생성하는 함수로 다음 세 가지 인수를 가진다.
    - `currentValue` - 현재 처리되고 있는 요소
    - `index` - 현재 처리되고 있는 요소의 index 값
    - `array` - 메소드가 불려진 배열
  - `thisArg` - callback 함수 내부에서 사용할 this 값을 설정 (optional)


- **예시**

  ```js
  // ES5
  var numbers = [1,2,3,4,5];
  var result = numbers.map(function(num){ // [1,4,9,16,25]
    return num*num;
  })
  // ES6
  let numbers = [1,2,3,4,5];
  let result = numbers.map((num) => {
    return num*num
  });
  ```

  ```js
  // [참고] Arrow Function
  let result = numbers.map((num) => num*num); // 결국 위와 동일한 코드
  let square = x => x*x // 인풋 하나일 땐 () 생략 가능
  let add = (a, b) => a + b; // 사용은 add(3,4) 로 하면 됨
  let pi = () => 3.1415;
  ```



<br>



### 2. 컴포넌트 Mapping

#### 2.1. 문제제기 - Contact 컴포넌트

```jsx
import React from 'react';

class App extends React.Component {
  render() {
    return(
    	<Contacts/>
    );
  }
}

class Contacts extends React.Component {
  render() {
    return(
      <div>
        <h1>Contacts</h1>
        <ul>
          <li>Abet 000-0000-0001</li>
          <li>Betty 000-0000-0002</li>
          <li>Charlie 000-0000-0003</li>
          <li>David 000-0000-0004</li>
        </ul>
      </div>
    );
  }
}

export default App;
```

데이터 배열을 mapping 하여 컴포넌트 배열로 변환하는 과정을 알아보자. 예컨대 위 코드 ul 안의 반복되는 코드가 유동적 데이터가 될 경우를 대비하여 React 스럽게 해결해보도록 하자는 것이다.

#### 2.2. 모듈하 - ContactInfo 컴포넌트로 모듈화 

```jsx
class Contacts extends React.Component {
  render() {
    return(
      <div>
        <h1>Contacts</h1>
        <ul>
          <ContactInfo name="Abet" phone="010-0000-0001"/>
          <ContactInfo name="Betty" phone="010-0000-0002"/>
          <ContactInfo name="Charlie" phone="010-0000-0003"/>
          <ContactInfo name="David" phone="010-0000-0004"/>
        </ul>
      </div>
    );
  }
}
class ContactInfo extends React.Component {
  render() {
    return(
      <li>{this.props.name} {this.props.phone}</li>
    );
  }
}
```

#### 2.3. 해결 2단계 - Mapping

```jsx
class Contacts extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      contactData: [
        {name: "Abet", phone: "010-0000-0001"},
        {name: "Betty", phone: "010-0000-0002"},
        {name: "Charlie", phone: "010-0000-0003"},
        {name: "David", phone: "010-0000-0004"}
      ]
    }
  }
  render() {
    return(
      <div>
        <h1>Contacts</h1>
        <ul>
          { this.state.contactData.map((contact, i) => {
            return (<ContactInfo name={contact.name} phone={contact.phone} key={i}/>);
          })}
        </ul>
      </div>
    );
  }
}
```





#### Ref

React Official Documentation https://reactjs.org/docs/hello-world.html

Velopert React 강좌 https://velopert.com/