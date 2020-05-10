### Class Components and State

- state is for dynamic data

  - data that mutates

- **function component**

  ```jsx
  function App() {
    return(
      <div>
        {foodILike.map(dish =>
           <Food key={dish.id} name={dish.name}/>
        )}
      </div>
    ) 
  }
  ```

- **class component**

  ```jsx
  class App extends React.Component{
    // function 아니므로 return 없음. 대신 render method를 react-component으로부터 extend받음
    render (<h1>I'm a class component</h1>);
  }
  ```

  - class App is a react component

    - one of things that react component has is **state**

      (baby extends everything from human)

  - React automatically is going to execute the render method/function of your class component

    - why use this?

      - **because class component has state**

      - **state is an object**

        **where you can put data that will change**

  ```jsx
  class App extends React.Component{
    state = {
      count: 0
    }
    render (<h1>The number is {this.state.count}</h1>);
  }
  ```

  - How do we change the data in state?

    - do not **directly** mutate state ! Use `setState`

      - why? directly 바꾸면 **React doesn't refresh render function**

        data가 바뀔 때마다 render function를 다시 execute해야 함.

      - setState를 부르면 React가 refresh해야 한다는 것도 알고 refresh하게 됨.

        **Everytime you call `setState`, React is going to rerender with the new state!**

  ```jsx
  class App extends React.Component{
    state = {
      count: 0
    }
  	add = () => {
      // this.state.count = 1 (X)
      this.setState({
        count: this.state.count + 1 // performance issue가 있음
      })
    };
    minus = () => {
      this.setState({
        count: this.state.count - 1
      })
    };
  
    render (<div>
        <h1>The number is {this.state.count}</h1>
        <button onClick={this.add}>Add</button>
        <button onClick={this.minus}>Minus</button>
      </div>
    );
  }
  // onClick이라는 prop이 있는 건 React Magic! 디폴트 JS아님
  // this.add() 대신 this.add 해야 함. 전자는 즉시 실행시키고 싶을 때 사용.
  ```

  - performance를 위한 best practice

  ```jsx
  add = () => {
    this.setState(current => ({
      count: current.count + 1
    }))
  }
  // this.state 대신 current 사용할 것!
  ```