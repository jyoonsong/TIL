# React 컴포넌트 스타일링

### 1. 기본

React 프로젝트에서는 `className`이 중복되지 않도록 컴포넌트이름을 접두사로 붙이거나 아래처럼 부모 선택자로 사용하곤 한다.

```scss
.App { ... }
.App .header { ... }
.App .logo { ... }
.App .intro { ... }
```

React는 CSS를 **webpack의 세 가지 loader**를 통해 불러온다.

- `style-loader` - 스타일시트를 불러와 페이지에서 활성화하는 역할
- `css-loader` - css파일에서 `import`와 `url()` 문들을 webpack의 `require` 기능을 통해 처리해주는 역할
- `postcss-loader` - 입력된 css 구문이 모든 브라우저에서 제대로 작동할 수 있도록 -webkit, -mos, -ms 등의 접두사를 붙여주는 역할

<br>



### 2. CSS Module - 클래스명 적용

#### 2.1. 사용방법

CSS를 모듈화하여 사용하는 방식. 

- 다음과 같이 `webpack.config.dev.js`에서 **CSS Module을 활성화**한다.

  ```Diff
  {
    test: /\.css$/,
      use: [
        require.resolve('style-loader'),
        {
          loader: require.resolve('css-loader'),
          options: {
            importLoaders: 1,
  +         modules: true,
  +		  localIdentName: '[path][name]__[local]--[hash:base64:5]'
          },
        },
        {
          loader: require.resolve('postcss-loader'),
          options: {
            (...)
          },
        },
      ],
  },
  ```

- CSS class를 만들면, 자동으로 고유적인 className이 생성되어 scope를 지역적으로 제한하게 된다. 모듈화된 CSS를 webpack을 통해 불러오면, 다음과 같이 **사용자가 정의했던 class명과 고유화된 className이 담긴 object**가 반환된다.

  ```jsx
  {
    box: 'src-App__box--mjrNr'
  }
  ```

- **컴포넌트에서 클래스를 적용**하게 될 때에는 `className={styles.box}` 형식으로 사용한다. 이는 다음과 같이 렌더링된다.

  ```html
  <div data-reactroot="" class="src-App__box--mjrNr"></div>
  ```

<br>

####2.2. ClassNames 

**클래스명이 여러 개일 경우** 사이에 공백을 두고 합쳐주면 된다.

  ```jsx
<div className={[styles.box, styles.blue].join(' ')}></div>
  ```

혹은 `classnames`라는 라이브러리를 사용하면 훨씬 더 간편해진다. `yarn add classnames`를 통해 설치하면 된다.

  ```jsx
import classNames from 'classnames';
<div className={classNames(styles.box, styles.blue)}></div>
  ```

또한 `classNames`의 **bind기능을 사용하여 `styles.`를 생략할 수 있다**

  ```jsx
import classNames from 'classnames/bind';
const cx = classNames.bind(styles);
<div className={cx('box', 'blue')}></div>
  ```

뿐만 아니라 `classNames`는 **여러 가지 포맷**으로 사용할 수 있다. 위에서는 파라미터를 단순 나열했지만, 이를 객체 형식 혹은 배열 형식으로 전달해줘도 된다.

  ```jsx
  classNames('foo', 'bar'); // foo bar
  // Objects
  classNames('foo', {bar: false}); // foo
  classNames({ foo: true }, { bar: true }); // foo bar
  classNames({ foo: false, bar: true }); // bar
  // Arrays
  classNames(['foo', 'bar']); // foo bar
  // Multiple Types
  classNames('foo', {bar: true, duck: false}, 'baz', {quux: true}); // foo bar baz quux
  classNames(null, false, 'bar', undefined, 0, 1, {baz:null}, ''); // bar 1
  ```

이는 **조건부 스타일링**에 아주 편리한 기능이다.

  ```jsx
import React, { Component } from 'react';
import classNames from 'classnames/bind';
import styles from './App.css';
const cx = classNames.bind(styles);


class App extends Component {
  render() {
    const isBlue = true;

    return (
      <div className={cx('box', {
          blue: isBlue
        })}>
      </div>
    );
  }
}

export default App;
  ```

<br>

#### 2.3. 기타 컴포넌트 정리

- **비구조화 할당을 이용한 동적 className**

  ```jsx
  import React from 'react';
  import styles from './Button.scss';
  import classNames from 'classnames/bind';

  const cx = classNames.bind(styles);
  const Button = ({children, ...rest}) => {
    return (
      <div className={cx('button')} {...rest}>
        {children}
      </div>
    );
  };
  export default Button;
  ```

  rest 는 나중에 이 컴포넌트가 받을 모든 props 를 칭한다

  ```js
  const object = {a:1, b:2, c:3};
  const { a, ...foo } = object;
  console.log(a); // 1
  console.log(foo); // {b:2, c:3} 
  ```

  ​

- **index.js를 이용해 깔끔하게 불러오기**

  ```jsx
  // index.js 없을 때
  import Button from './components/Button/Button';
  // index.js 있을 때
  import Button from './components/Button'
  ```

  ```jsx
  // index.js
  import Button from './Button';
  export default Button;
  // 한 줄로
  export { default } from './Button';
  ```

<br>



### 3. Sass

#### 3.1. 사용방법

- **설치** - `yarn add node-sass sass-loader`

  - `node-sass` - sass를 CSS로 컴파일
  - `sass-loader` - webpack에서 sass파일들을 읽어오는 역할.

- **환경설정** - css-loader 설정을 그대로 복사하여 test 부분을 바꿔주고, 세 가지 로더 뒤에 `sass-loader` 설정을 추가해준다.

  ```diff
        {
          test: /\.css$/,
          (...)
        },
  +     {
  +       test: /\.scss$/,
  +       use: [
  +         require.resolve('style-loader'),
            (...)
  +         {
  +           loader: require.resolve('sass-loader'),
  +           options: {
  +             // 나중에 입력
  +           }
  +         }
          ],
        },
  ```

- import 할 때도 .scss 확장자 파일 불러오면 됨

<br>

#### 3.2. import

- **전역적 스타일 적용**

  전역적 스타일은 한 파일에 몰아준 다음, import하는 형태로 사용한다. 이때, 컴포넌트 저장 디렉토리가 조금 깊어진다면 import가 복잡해질 수 있다: `@import '../../../styles/utils';`

  이런 복잡한 상대경로 작성을 피하기 위해 webpack에서 sass-loader를 설정할 때 `includePaths`라는 옵션으로 경로를 간소화할 수 있다: `@import 'utils';`

  ```js
  // config/paths.js
  module.exports = {
    (...),
    styles: resolveApp('src/styles')
  };
  ```

  ```js
  // config/webpack.config.*.js
  {
    loader: require.resolve('sass-loader'),
      options: {
        includePaths: [paths.styles]
      }
  }
  ```

- **외부 패키지 적용**

  `~`는 node_modules 내부의 디렉토리를 가리켜준다.

  ```scss
  @import '~include-media/dist/include-media';
  ```

<br>



### 4. Styled-Components

#### 4.1. 사용 방법

styled-components는 자바스크립트 파일 안에 스타일 자체를 선언하는 방식으로 스타일링 관리. JS 내부에서 스타일시트를 정의하다보니 벽이 허물어져 **동적 스타일링이 더욱 간편**해진다. 

- **설치** - `yarn add styled-components`

- **문법** - ES6 Tagged Template Literals

  ```jsx
  import React from 'react';
  import styled from 'styled-components';

  const Wrapper = styled.div`
    border: 1px solid black;
    display: inline-block;
    padding: 1rem;
    border-radius: 3px;
    font-size: ${(props) => props.fontSize}; // 동적 스타일링
    ${props => props.big &&`
      font-size: 2rem;
  	padding: 2rem;
    `};
    &:hover {
      background: black;
      color: white;
    }
  `; // 끊어진 값들을 참조해 styled-components 라이브러리가 스타일을 정의해주는 원리.
  ```

  ```jsx
  function myFunction(...args){
    console.log(args); // [["1+1= ", " and 2+2= ", "!"], 2, 4]
  }
  myFunction`1+1= ${1+1} and 2+2= ${2+2}!` // 끊어서 저장
  ```

  ​
