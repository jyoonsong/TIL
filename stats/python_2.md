**3.1.1. 벡터 생성**

```python 
np.full(size, value) # value가 size개 들어있는 integer 벡터
np.zeros(size, dtype = float) # 0이 size개 들어있는 float 벡터
np.ones(size, dtype = int) # 1이 size개 들어있는 int 벡터
# 순서대로 정수 벡터
np.arange(6) # [0 1 2 3 4 5]
np.arange(2, 7) # [2 3 4 5 6] m부터 n-1까지 정수
np.arange(3, 17, 3) # [3 6 9 12 15] m부터 n-1까지 d간격 정수
# 랜덤 정수 벡터
np.random.rand(5) # 0~1 사이 난수 5개 생성
np.random.randn(5) # 표준정규분포에서 난수 생성
np.random.choice(np.arange(10), size=5, replace=True) # a에서 k개를 복원추출
np.random.randint(0, 10, 5) # 0~9 사이 정수 중 5개 난수 생성 (중복O)
```

**3.1.2. 행렬**

```python
b = np.array( [[1,2,3],[4,5,6]] ) # 1차원: np.array([1,2,3])
type(b) # numpy.ndarray
b.shape # (행, 열) 1차원이면 (3,)으로 나옴
print( b[0,0], b[0,1], b[1,0] )
# size 자리에 (행, 열) 넣으면 2차원으로 생성됨
np.full((2,2), 7)
np.random.rand(2,2) # 0~1 사이 난수 4개 2x2행렬
np.arange(1, 7).reshape(3, 2) # 1 2 / 3 4 / 5 6
np.eye(3) # 1 0 0 / 0 1 0 / 0 0 1
# 배열 연산
x + y # np.add(x, y)
x - y # np.subtract(x, y)
x * y # np.multiply(x, y) 각 원소 곱셈 # x.dot(y)
x / y # np.divide(x, y) 각 원소 나눗셈
# sum, mean, var
np.sum(x) # 모든 원소
np.mean(x, axis = 0) # (각 열에 대한 평균) 위아래로 [1,2][3,4] => [4 6]
np.var(x, axis = 1) # (각 행에 대한 분산) 좌우로 [1,2][3,4] => [3 7]
```

**부분배열 형성 3가지**

```python
# 1) 슬라이싱: 원본 배열이 수정됨
c = b[:2, 1:3] # 0,1행 1,2열 [2 3 / 6 7]
c[0,0] = 77 # [77 3 / 6 7]
print( b[0,1] ) # 77 
# 2) 정수 인덱싱: 원본과 다른 배열 만들 수 있음
d = b[[0,0,1,1], [1,2,1,2]] # a[0,1] a[0,2] a[1,1] a[1,2] - [2 3 6 7]
d = d.reshape(2, 2) # [2 3 / 6 7]
d[0, 0] = 77
print( b[0, 1] ) # 2
# 3) 불리언 배열 인덱싱
bool_idx = (b > 5) # [f f f f / f t t t / t t t t]
a[bool_idx] # [6 7 8 9 10 11 12]
# 응용 (1,4,7,8)열을 추출하여 저장하시오
b[:, [0, 3, 6, 7]] # 원본과 다른 배열
```

**기본 계산**

```python
import math
np.abs(-3), np.round(2.6), np.floor(2.6), np.ceil(2.6) # 반올림, 내림, 올림
np.exp(1) # == math.e
np.log(math.e) # == math.log(math.e) : e base
math.log(math.e, 10) # 10 base
np.sin(np.pi/2) # == math.sin(math.pi/2) = 1
```

```python
from scipy.special import comb
from scipy.special import factorial

print(factorial(5, exact=True)) # 5!
print(comb(10, 3, exact=True)) # 10 C 3
print(comb(10, 3, exact=True, repetition=True)) # 10 H 3 = 12 C 3
```

**조건문/반복문/함수**

```python
if [False]: # null 아니므로 True
if "zero": # null 아니므로 True
# pass
for i in range(1, 10):
  if i%2==0:
    pass
  else:
    a.append(i) # 결과 [1,3,5,7,9]
# break
for i in range(1, 100): # 1 ~ 99
    a.append(i) # 결과: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
    if sum(a) >= 100:
        print(sum(a)) # 105
        break
# continue
while len(a) < 5:
  i += 1
  if i%2 == 0: continue
  a.append(i) # [1, 3, 5, 7, 9]
```

```python
def sum(a, b): # multiple return value 가능
    return a, b, a+b
v1, v2, v3 = sum(10, 11) # print('%i + %i = %i' %(v1, v2, v3))
value = sum(10, 11) # (10, 11, 21)
def sum(*args): # 입력변수가 몇 개가 될지 모르는 경우 *args 사용
    value = 0
    for i in args: value += i
    return value
a = sum(10, 11, 12, 13, 14) # 60
```





