# [Uber] Optimizing a dispatch system using an AI simulation framework

### 0. Goal

- **Optimization** of two goals
  - Rider - **getting you a ride** when you need it
  - Driver - **maximize trips** taken on the system = maximizes earnings


- Specification - Optimization of **Dispatch Radius**

  정의: the farthest distance btw a passenger and driver
  where we'll allow a request to go through

  - different for each city
  - changes as a function of time
    - **slow hours - willing** to pick up passengers who are far away 
    - **busy hours - less likely** to accept passengers with longer pickup times

---

### 1. How? 

by **Agent-based modeling**

- developing agents - simulated drivers and passengers - that behave according to a set of rules
- allows us to see what combinations of parameters *the simulations thought were best* according to a predefined criteria

![ABM](http://www.kucomputationalthink.org/wp-content/uploads/2016/06/2-12.bmp)

> http://www.kucomputationalthink.org/index.php/chapter-2/

ABM의 주요 개체(Entity)는 환경(Environment) 안에서 작동하는 **행위자(Agent)**

- 일반적으로 몇 개의 유형이 있다. (예: Uber는 2종류의 agent - Driver, Rider)
- 자신의 특징과 조건을 설명하는 속성(Property) 값을 가지고 있다.
  - 같은 유형의 Agent는 동일한 형태의 속성
  - 그렇다고 속성의 값까지 같다는 건 아님
- 에이전트의 행동(action)은 **규칙**의 집합에 의해 결정됨
  - 규칙은 **condition -> action(s)**의 형태

---

### 2. Simulation

Parameter Combination을 조정해가며 Output이 어떻게 달라지는지 관찰.

각 시뮬레이션은 수백 번 반복하고, error estimate도 50번 반복.

- Environment

  - artificial city of 100-by-100 "blocks"
  - 250 passengers & 500 drivers randomly(Gaussian) distributed
  - Each passenger has a random(uniform) destination

- Input Parameters

  - Dispatch Distance

    - dispatch radius - 1 vs 2 vs 3 … units

      > 1 unit은 결국 택시의 기본적 작동방식. 보이는 승객을 태우니깐.

  - Passenger Behavior

    - **patience value** - , how long they’re willing to wait for a car before
      giving up

    - new passengers can pop up into city

      > simplicity를 위해 설명에서 배제

  - Driver Behavior

    - i) **stationary** - they don’t move unless they have a passenger
    - ii) **random drive** - they go for a [random drive](http://en.wikipedia.org/wiki/Random_walk) around the city
    - iii) **gravity** - drivers navigate back toward the **demand gravity**
      where the demand density is the greatest (hot spot을 안다는 가정 하에)

- Output Variables

  - Total potential trips *lost*
  - Average # of trips completed
  - Average distance driven (on *and* off trips)
  - Average driver earnings

---

### 3. Result

- Dispatch Distance => Output

  - Total Potential trips lost

    ![](https://newsroomadmin.uberinternal.com/wp-content/uploads/2014/05/ubersmith_lost.jpg)

  - Average # of trips completed

    ![](https://newsroomadmin.uberinternal.com/wp-content/uploads/2014/05/ubersmith_trips.jpg)

  - Average distance driven (on *and* off trips)

    ![](https://newsroomadmin.uberinternal.com/wp-content/uploads/2014/08/distance.jpg)

  - Average driver earnings

    ![](https://newsroomadmin.uberinternal.com/wp-content/uploads/2014/08/earnings.jpg)



#### Dispatch Radius = 1 

> decentralized, taxi-like system

- Total potential trips *lost*

  `random drive` < `gravity` < `stationary`

- Average # of trips completed

  `random drive` > `gravity` > `stationary`

- Average distance driven (on *and* off trips)

  `random drive` >>> `gravity` > `stationary`

- Average driver earnings

  `random drive` <<< `stationary ` < `gravity` 

random drive가 1,2번째 output에 있어서는 긍정적 결과를 보이지만,
사실 **cost of gas used during and btw trips**를 고려한 3,4번째 output은 부정적이다.



#### Dispatch Radius >= 25

> error bars = standard deviation of the mean

- Total potential trips *lost*

  `random drive` = `gravity` = `stationary`

- Average # of trips completed

  `random drive` < `gravity` , `stationary`

- Average distance driven (on *and* off trips)

  `random drive` >>> `gravity` > `stationary`

- Average driver earnings

  `random drive` <<< `gravity` < `stationary ` 



#### 정리

- Optimal Dispatch Distance & Driver Behavior
  - When dispatch distances are very short drivers should navigate back toward demand **gravity**
  - When dispatch distances are relatively longer, drivers maximize their earnings by using less gas by remaining **stationary** between trips
- Eliminating Randomness
  - Drivers working with Uber have access to real-time demand information and
    are less subject to randomness when searching for a passenger

---

### 적용

- Dispatch

  Driver가 drive 사이에 어떤 상태로 있어야 optimal(earnings)한가?

- Simulation Variables



