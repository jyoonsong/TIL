## JSX

### 1. 개념

- **소개**

  - XML/HTML-like syntax that extends ECMAScript so that XML/HTML-like text can co-exist with JavaScript/React code.
  - 확장자 - .jsx => .js 사용하는 추세 (fb에서는 .react.js)

- **필요성**

  - JSX는 컴파일링되면서 최적화되므로 빠르다

  - **Type-safe** 하다

    어떠한 연산도 정의되지 않은 결과를 내놓지 않는다. 즉 예측 불가능한 결과를 나타내지 않는다. 예컨대 1+"1"의 연산이 가능하다거나, 문자열 변수에 숫자를 할당하는 것이 가능하다거나 하는 것은 일면 비논리적이라고 볼 수 있다. 이러한 비논리를 엄격히 체크하여 runtime 시 이로 인한 오류를 발생하지 않도록 하겠다는 개념이 type-safe.

    type-safe한 언어(ex. C#, Java)는 보통 이를 *컴파일 과정에서 에러를 감지* 해준다.
    type-safe하지 않은 언어(ex. JavaScript)는 이를 그냥저냥 처리한다.

### 2. 문법

- XML/HTML-like Syntax

  - 따옴표 `""` 로 감싸지 않는다.

  - **Container Element**가 필수적.

    ```jsx
    // Syntax Error
    return(
      <h1>Hello Jaeyoon</h1>
      <h2>Welcome</h2>
    );
    ```

    ```jsx
    // No Error
    return(
      <div>
        <h1>Hello Jaeyoon</h1>
      	<h2>Welcome</h2>
      </div>
    );
    ```


- JavaScript Expression

  - `{}` 로 wrapping 하면 된다

  - 임의 **method** 생성/사용 - 뒤에 `()` 붙이면 페이지가 로드될 때도 실행되고 클릭할 때도 실행됨

  - if-else 문 사용 불가 - 대신 **ternary** (conditional operator) 를 사용한다.

    ```jsx
    sayHey(){
      alert("hey");
    }
    render(){
      let text = "Dev-Server"
      return (
      	<div>
          <h1>Hello Jaeyoon</h1>
          <h2>Welcome to {text}</h2> {/* wrapping */}
          <button onClick={this.sayHey}>Click Me</button> {/* method */}
          <p> {1==1? 'True' : 'False'} </p> {/* ternary */}
        </div>
      );
    }
    ```

- Inline Style StyleSheet

  - React의 Inline CSS에서는 string 형식이 사용되지 않고 **key가 camelCase인 Object**를 사용

    ```jsx
    render(){
      let pStyle = {
        color: 'aqua',
        backgroundColor: 'black'
      };
      return (
        <div>
          <p style = {pStyle}>I am inline styled</p>
        </div>
      );
    }
    ```

- 주석 다는 법

  - `{/* comments */}` 형식으로 작성.



### Ref

React Official Documentation https://reactjs.org/docs/hello-world.html

Velopert React 강좌 3편 https://velopert.com/867
