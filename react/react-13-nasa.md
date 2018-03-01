# Styling + API 연동 실습

###0. 작업환경설정

SASS + CSS Module 조합으로 컴포넌트를 스타일링하고, 프로미스 기반의 HTTP CLient인 axios를 사용하여 간단한 웹 요청을 처리하는 방법을 알아보자.

- **모듈 설치**

  `yarn add axios classnames sass-loader node-sass include-media better-react-spinkit react-icons moment`

  - **axios** - Promise 기반의 웹 요청 클라이언트
  - classnames - CSS Module 및 className 설정을 돕는 라이브러리
  - sass-loader, node-sass - SASS 환경설정
  - include-media, better-react-spinkit, react-icons - 디자인 유틸 라이브러리
  - moment - 날짜 관련 라이브러리

- **SASS + CSS Module 설정** 

  - webpack.config.*.js 에서 scss loader (기본 3개 loaders + sass-loader)
  - paths.js에서 styles 값 설정

- **디렉토리 구조**

  ```js
  // src
  +-- index.js
  +-- App.js
  +-- styles
  |	+-- utils.scss // base.scss에서 import
  |	+-- base.scss // index.js에서 import
  +-- components
  |	+-- ComponentName
  |	|	+-- ComponentName.js
  |	|	+-- ComponentName.scss
  |	|	+-- index.js // App에서 import
  +-- registerServiceWorker.js
  ```

  각 컴포넌트마다 디렉토리를 만들고, 각 디레토리에는 위와 같이 3종류의 파일을 넣는다.

- **컴포넌트의 틀**

  ```jsx
  // index.js
  export { default } from './ComponentName'; // 띄어쓰기 필수
  // ComponentName.js
  import React from 'react';
  import styles from './ComponentName.scss';
  import classNames from 'classnames/bind';

  const cx = classNames.bind(styles);

  const ComponentName = () => {
    return (
    	<div className={cx('component-name')}>
      </div>
    );
  };

  export default ComponentName;
  ```

  > 컴포넌트 이름 중 브라우저에 이미 정의되어 있는 값은 기피한다. 예컨대 Navigator는 이미 브라우저 상에 존재하는 값이므로 SpaceNavigator 등으로 붙여준다.

<br>



### 1. API 사용하기 - axios

#### 1.1. Promise란?

우리가 사용할 웹 요청 라이브러리 axios는 Promise 기반이다. `Promise`란 **ES6에서 비동기 처리를 다루기 위해 사용되는 객체**이다. 예컨대 아래는 숫자를 1초 뒤에 콘솔에 기록하는 코드이다.

```js
// callback hell
function printLater(num, fn) {
  setTimeout(
    function() { console.log(num); fn(); }, 1000
  );
}

printLater(1, function() {
  printLater(2, function() {
    printLater(3, function() {
      printLater(4);
    })
  })
})
```

비동기적으로 해야할 작업이 많아질 수록 코드의 구조는 자연스레 깊어질 것이고 코드는 읽기 힘들어질 것이다. 이를 [callback hell](https://callbackhell.com)이라고 부르는데, 이러한 문제에서 구제해주는 것이 바로 **Promise**이다.

```js
// Usage of Promise
function printLater(num) {
  return new Promise( // 새 Promise를 만들어 리턴
    resolve => {
      setTimeout(
        () => {
          if (num > 3) {
            return reject('number is greater than 3'); // reject로 에러 발생시킴
          }
          resolve(num+1); // promise가 끝났음을 알림. 1 더한 값을 반환.
          console.log(num); // 일단은 1 안 더해진 num 출력
        }, 1000
      );
    }
  )
}
printLater(1) // 1
.then(num => printLater(num)) // 2
.then(num => printLater(num)) // 3
.then(num => printLater(num)) // number is greater than 3
.then(num => printLater(num)) // 실행 안됨
.catch(e => console.log(e));
```

몇 번을 하던 간에 **코드의 깊이는 일정**하므로 콜백지옥에 빠질 일이 없다. Promise에서는 값을 리턴하거나, 에러를 발생시킬 수도 있다.

<br>

#### 1.2. API 요청 함수 만들기

다루는 API의 개수가 많아지면 따로 파일을 분리하여 관리하면 편하므로, src 디렉토리 내부에 lib라는 디렉토리를 만들고, 그 안에 api.js를 만들어준다.

```jsx
// src/lib/api.js
import axios from 'axios';

export function getAPOD(date='') {
  return axios.get(`https://api.nasa.gov/planetary/apod?api_key=QfhuH8V4pducM9egumUUG90I9LbHwDLKovPgODFt&date=${date}`);
}
```

```jsx
// src/App.js
import * as api from './lib/api';

class App extends Component {
	getAPOD = (date) => { // App에서 정의된 getAPOD.
		api.getAPOD(date).then(response => { // api.js에서 정의된 getAPOD
			console.log(response);
		});
	}
	
	componentDidMount() {
		this.getAPOD(); // App에서 정의된 getAPOD. 비워두면 default date = today 적용됨
	}
```

<br>

#### 1.3. async/await

> 마치 `Promises`가 structured callback과 유사한 것처럼, `async`/`await`는 combining generators & promises 와 유사하다.

- `async function name(i) {o}` or `async (i) => {o}`

  async function **선언**은 AsyncFunction 객체, 즉 `Promise`를 리턴한다.

  async function이 어떤 값을 **return**하면, `Promise`는 해당 값과 함께 `resolve`된다.

  async function이 **예외 혹은 에러 값**을 던지면, `Promise`는 해당 값과 함께 `reject`를 리턴한다.

- `await` - `await functionToWaitFor(i);`

  async function의 execution을 잠시 멈추고, pass된 `Promise`의 resolution을 기다린 후에, 다시 async function을 이어서 실행하고 마침내 resolve된 값을 리턴한다.

  ```js
  // async/await 예시
  function resolveAfter2Seconds(x) {
    return new Promise(resolve => {
      setTimeout(() => {
        resolve(x);
      }, 2000);
    });
  }
  async function add1(x) {
    const a = await resolveAfter2Seconds(20);
    const b = await resolveAfter2Seconds(30);
    return x+a+b; // 혹은 여기서 x + await a + await b 해도 됨
  }

  add1(10).then(v => {
    console.log(v);  // prints 60 after 4 seconds
  })
  ```

  ```jsx
  // src/App.js
  import React, { Component } from 'react';
  import ViewerTemplate from './components/ViewerTemplate';
  import SpaceNavigator from './components/SpaceNavigator';
  import Viewer from './components/Viewer';

  import * as api from './lib/api';

  class App extends Component {
    getAPOD = async (date) => { // async function 선언으로 Promise 생성
      try {
        const response = await api.getAPOD(date); // api.getAPOD 실행을 기다린다
        console.log(response); // api.getAPOD이 끝나면 실행된다
      } catch (e) { // e for error event
        console.log(e); // 오류가 났을 경우 reject
      }
    }
  }
  ```

  <br>

  ​

### 2. 실습 코드

#### 2.1. 상태관리 

```jsx
// App.js
import React, { Component } from 'react';
import ViewerTemplate from './components/ViewerTemplate';
import SpaceNavigator from './components/SpaceNavigator';
import Viewer from './components/Viewer';

import * as api from './lib/api';

class App extends Component {

	state = {
		loading: false,
		maxDate: null,
		date: null,
		url: null,
		mediaType: null
	} 

	getAPOD = async (date) => {
		if (this.state.loading) return; // 이미 요청 중이라면 무시

		this.setState({
			loading: true // 로딩 상태 시작
		})

		try {
			const response = await api.getAPOD(date);

			// api에서 보내주는 json을 기준으로 비구조화 할당 (보내준 이름: 우리가 정의할 이름)
			const { date: retrievedDate, url, media_type: mediaType } = response.data;

			if (!this.state.maxDate) { // maxDate가 없으면
				this.setState({
					maxDate: retrievedDate // 다음 이미지를 보여주게 될 때, 오늘 이후의 데이터는 존재하지 않기 때문에 maxDate 를 설정
				})
			}

			// 전달 받은 데이터 넣어주기
			this.setState({
				date: retrievedDate,
				mediaType,
				url
			})

		} catch (e) {
			console.log(e);
		}

		this.setState({
			loading: false // 로딩 상태 종료
		})
	}

	componentDidMount() {
		this.getAPOD(); // 비워두면 default date = today 적용됨
	}

  render() {
		const {url, mediaType, loading} = this.state;

    return (
      <ViewerTemplate
				spaceNavigator={<SpaceNavigator/>}
				viewer={
					<Viewer
						url={url} 
						mediaType={mediaType}
						loading={loading}
					/>
				}
      />
    );
  }
}

export default App;

```

#### 2.2. Navigate

```jsx
// App.js
import moment from 'moment';
(...)
 handlePrev = () => {
  const { date } = this.state;
  const prevDate = moment(date).subtract(1, 'days').format('YYYY-MM-DD');
  this.getAPOD(prevDate);
}

handleNext = () => {
  const { date, maxDate } = this.state;
  if (date === maxDate) return;
  const nextDate = moment(date).add(1, 'days').format('YYYY-MM-DD');
  this.getAPOD(nextDate);
}
    
(...)
     
  render() {
    const {url, mediaType, loading} = this.state;
    const {handlePrev, handleNext} = this;

    return (
      <ViewerTemplate
				spaceNavigator={<SpaceNavigator onPrev={handlePrev} onNext={handleNext}/>}    
(...)
```

#### 2.3. 로딩

```jsx
// components/Viewer.js
import {ChasingDots} from 'better-react-spinkit';
const Viewer = ({mediaType, url, loading}) => {
  if (loading) {
    return <div className={cx('viewer')}>
      <ChasingDots color="white" size={60}/>
    </div>
  }
  return (...)
}
```

