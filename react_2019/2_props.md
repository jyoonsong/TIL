### Component

- **What is a component?**

  - **a function that returns HTML** 

    creating component

    ```jsx
    function App() {
      return (
        <div>
        	<h1>Hello</h1>
        </div>
      )
    }
    ```

    using component (여기서 `<App/>`이 component)

    ```jsx
    ReactDOM.render(<App/>, document.getElementById("root"))
    ```

- **JSX**

  - HTML inside JavaScript
  - 이게 React를 위해 만들어진 유일한 것. 그외는 모두 javascript. javascript 위에 얹어야 할 유일한 개념.

- **How do we make our component?**

  - `src`

    ```jsx
    // src/Potato.js
    
    import React from "react";
    // 항상 해줘야함
    
    function Potato() { // uppercase
      return(
        <h3>I love potato</h3>
      )
    }
    export default Potato;
    ```

    ```jsx
    // src/index.js (안좋은 예)
    
    import Potato from "./Potato";
    
    ReactDOM.render(<App /><Potato />, document.getElementById("root")) 
    // X only renders one component
    ```

    ```jsx
    // src/App.js (좋은 예)
    import Potato from "./Potato";
    
    function App() {
      return(
        <div>
        	<h1>Hello</h1>
          <Potato />
        </div>
      )
    }
    ```

  - **everything needs to be inside application.js**

    - why? React renders **only one component**

  

### Reusable Components with JSX + Props

- How to send information to children component?

  - we gave the `Food` component a property (prop) named `fav` with the value `kimchi`

    `<Food fav="kimchi"/>`

```jsx
// it works in just one file too
import React from "react";

function Food(props) { // args로 props를 받아옴
  console.log(props); // fav, doI, papapapa를 담은 Object
  return <h1>I like {props.fav}</h1>
}

function App() {
  return(
    <div>
    	<h1>Hello</h1>
      <Food 
        fav="kimchi" 
        doI={true}
        papapapa={["hello", 1, 2, 3, true]}
        /> // jsx syntax
    </div>
  ) 
}
```

- How to use that information in the children component?
  - reusing a component with the power of jsx and props

```jsx
// it works in just one file too
import React from "react";

function Food({ fav }) { // open up props as default
  return <h1>I like {fav}</h1>
}

function App() {
  return(
    <div>
    	<h1>Hello</h1>
      <Food fav="kimchi"/>
      <Food fav="ramen"/>
      <Food fav="chukumi"/>
    </div>
  ) 
}
```

### Dynamic Component Generation

- `map`
  - js function that 
    - takes an array
    - execute a function on each item of the array
    - gives you array with the result of each operation

```js
friends = ["dal", "m", "l", "j"]
friends.map(function(current) {
  console.log(current);
  return 0;
})
// result 하나씩 print하고 나서 [0, 0, 0, 0] return
```

```js
friends.map(function(friend) {
  return friend + "<3";
})
// ["dal<3", "m<3", "l<3", "j<3"]
```

- javascript는 항상 {} 안에

```jsx
// it works in just one file too
import React from "react";

function Food({ name, pic }) { // open up props as default
  return <div>
    <h1>I like {name}</h1>
    <img src={pic} alt={name}/>
  </div>
}

const foodILike = [
  {
    name: "Kimchi",
    image: "https://"
  },
  {
    name: "Ramen",
    image: "https://"
  },
  {
    name: "Chukumi",
    image: "https://"
  }
] // 실제로는 API에서 받아오는 데이터가 될 것

function App() {
  return(
    <div>
      {foodILike.map(dish => // dish will be an object
         <Food name={dish.name} pic={dish.image}/>
      )}
    </div>
  ) 
}
```

- 새로운 function을 만들어 같은 일을 할 수도 있다.

```jsx
function renderFood(dish) {
  return <Food name={dish.name} pic={dish.image}/>
}

function App() {
  return <div>
    {foodILike.map(renderFood)}
  </div>
}
```

- **Each child in a list should have a unique "key" prop**
  - React needs all the elements to look different
  - `key={dish.id}` 추가하면 에러 사라짐
  - Food component에서 사용되지는 않고 pass되지도 않지만 **React internal use를 위한 것**

```jsx

const foodILike = [
  {
    id: 1,
    name: "Kimchi",
    image: "https://"
  },
  {
    id: 2,
    name: "Ramen",
    image: "https://"
  },
  {
    id: 3,
    name: "Chukumi",
    image: "https://"
  }
] 

function App() {
  return(
    <div>
      {foodILike.map(dish => // dish will be an object
         <Food key={dish.id} name={dish.name} pic={dish.image}/>
      )}
    </div>
  ) 
}
```

### Protection with PropTypes

- Are the props the ones that we were expecting?
  - 예를 들어 pic={dish.image} 대신에 pic={true} 줬으면 이미지 깨질 것. 깨지지 않도록 미리 확인하는 절차 필요.
  - `npm i prop-types`
    - allow us to check props

```jsx
import PropTypes from "prop-types"; // 추가


function Food({ name, pic, rating }) {
  return <div>
    <h1>I like {name}</h1>
    <h4>{rating}/5.0</h4>
    <img src={pic} alt={name}/>
  </div>
}

Food.propTypes = { // propTypes는 이름 바뀔 수 없음
  name: PropTypes.string.isRequired, // should be string and is required
  pic: PropTypes.string, // required 아니므로 undefined여도 (없어도) 에러 안 뜰 것
  rating: PropTypes.number.isRequired // 여기 number 대신 string이라고 쓰면 PropTypes가 콘솔에 에러를 띄워줌
}

const foodILike = [
  {
    id: 1,
    name: "Kimchi",
    image: "https://",
    rating: 4.9
  },
  {
    id: 2,
    name: "Ramen",
    image: "https://",
    rating: 5
  },
  {
    id: 3,
    name: "Chukumi",
    image: "https://",
    rating: 3.5
  }
] 

function App() {
  return(
    <div>
      {foodILike.map(dish => // dish will be an object
         <Food key={dish.id} name={dish.name} pic={dish.image} rating={dish.rating}/>
      )}
    </div>
  ) 
}
```

