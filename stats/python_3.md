**4.1.1. 정규분포 - 확률밀도함수 그리기**

```python
from scipy.stats import norm
x = np.linspace(-3, 3, 100, endpoint = True) # 수열 생성
fx = norm.pdf(x, loc = 0, scale = 1) # 밀도함수
plt.plot(x, fx, color="C0", linewidth = 1.0, linestyle = "-") # 그려라
plt.title("Standard Normal Distribution")
```

**4.1.2. 정규분포 누적분포확률** (ex: 이 회사 제품인 전구의 수명이 2500시간 이하일 확률을 구하라)

```python
n = norm(loc = 2000, scale = 200)
n.cdf(2500) # equivalent: norm.cdf(2500, 2000, 200)
```

**4.1.3. 정규분포 - 분위수**

```python
n = norm(loc = 100, scale = 15)
n.ppf(0.98) # equivalent: norm.ppf(0.98, 100, 15)
```

**4.2.1. 이항분포 - 밀도함수 그리기**

```python
from scipy.stats import binom
x = np.arange(0, 7)
px = binom.pdf(x, n = 6, p = 0.5)
plt.plot(k, px, 'C0o', linewidth = 1.0) # 점만
plt.vlines(k, 0, px, color = "C0", linewidth = 2.0) # 수직선
plt.title("Binomial Distribution")
```

**4.2.2. 이항분포 - 확률  & 누적분포확률** (ex: 어떤 생산공정의 불량률은 10%)

```python
# 임의로 5개의 표본을 추출할 때, 불량품이 3개일 확률 P(X=3)?
b = binom(n = 5, p = 0.1)
b.pmf(3) # equivalent: binom.pmf(3, 5, 0.1)
# 임의로 추출한 20개의 표본 중에서 불량품이 5개 이하일 확률 P(X<=5)?
b = binom(n = 20, p = 0.1)
b.cdf(5) # equivalent: binom.cdf(5, 20, 0.1)
```

**4.2.3. 이항분포 - 정규 근사**

```python
p = 0.1 # 0.5이면 더욱 근사
n = [10, 30, 50] # 클수록 근사
for i in range(3):
  plt.figure(figsize = (6, 4)) # 이거 없으면 겹쳐짐
  plt.title("normal approximation, p = 0.1, n = %i" % n[i])
  plt.ylabel("probability")
  # 이항분포 그래프 그리기
  k = np.arange(0, n[i] + 1)
  px = binom.pmf(k, n = n[i], p = p)
  plt.plot(k, px, 'C1o') # 점만 (o가 점 C1은 color)
  plt.plot(k, px, color = 'C1', linewidth = 2.0) # 이음선
  # 근사된 정규분포 그래프 그리기
  x = np.linspace(-5, 15, 100, endpoint = True)
  fx = norm.pdf(x, loc = n[i] * p, scale = np.sqrt(n[i] * p * (1-p)))
  plt.plot(x, fx, color = "C0", linewidth = 1.0, linestyle = "-")
```

**4.3. 표본평균의 분포** 

```python
from scipy.stats import uniform
np.random.seed(1) # 반복 가능한 난수 생성 (같은 시드값으로 동일한 결과)
n = [10, 30, 50, 100] # 1회 시행에서 추출할 표본의 개수
for i in range(4):
  mean = [] # 각 시행에서 추출된 표본평균들
  for j in range(200): # 각 표본 크기별로 표본평균 200개 반복 구함
	  # U(loc, scale) 분포에서 size개의 랜덤 표본을 추출
  	x = uniform.rvs(loc = 0, scale = 1, size = n[i])
  	mean.append(x.mean())
  plt.figure(figsize = (6,4))
  # 표본분산 분포 그리기
  plt.hist(mean, bins=9, color="C0", density=True, histtype='bar')
  # 정규분포 N(모평균 0.5, 모분산/n) 그리기
  x = np.linspace(0, 1, 100, endpoint = True)
  fx = norm.pdf(x, loc = 0.5, scale = np.sqrt((1/12) / n[i]))
	plt.plot(x, fx, color="C1", linewidth = 1.0, linestyle="-")
```

**4.4. 정규분포 분위수 대조도** (자료는 정규분포를 따른다고 말할 수 있는가?)

```python
# filtering
bodydims_m = bodydims[bodydims['sex'] == 1]
bodydims_f = bodydims[bodydims['sex'] == 0]
```

```python
from statsmodels.graphics.gofplots import ProbPlot
plt.figure(figsize = (6, 4))
plt.hist(bodydims_f['bii.di'], bins = 8, color = "C0", histtype = 'bar')
# 정규분포 분위수 대조도 (여기가 핵심)
QQ = ProbPlot(bodydims_f['bii.di'])
plot = QQ.qqplot(line = 's', color = 'C0', lw = 1)
plt.title("Normal Q-Q Plot")
# 분석 결과 예: 양쪽, 특히 왼쪽 tail이 정규분포를 따르지 않고 있다.
```

