# Ch.2 Algorithm Efficiency

### Asymptotic Analysis

- 입력의 크기가 충분히 큰 경우에 대한 분석 (로그 < n < nlogn < nlog^2n < n^2 < n^3 < 지수)

![image](https://user-images.githubusercontent.com/17509651/39086018-96c6df9a-45c6-11e8-9201-00f39a4bc705.png)

### Asymptotic Notation

- `O(f(n))`  **tight or loose**
  - 기껏해야 f(n)의 비율로 증가하는 함수들의 집함

    an algorithm's running time is upper-bounded by cf(n)

  - 엄밀한 정의 : O(f(n)) = { g(n) | ∃c > 0, n0 ≥ 0 such that ∀n ≥ n0, cf(n) ≥ g(n) }

-  `Ω(f(n))`  **tight or loose**

- `Θ(f(n))`  **tight** 

  - 하한과 상한의 개념 모두 포함

  - 정보손실 없는 표현. 가장 정확. 

    > quickSort average case `Θ(nlogn)` (O) `O(nlogn)` (맞지만 정보손실많은 표현)

### Types of Running-time Analysis

- **Worst-case analysis** - worst case inputs
- **Average-case analysis** - all inputs (most difficult to analyze)
- **Best-case analysis** - best case inputs (not meaningful)

