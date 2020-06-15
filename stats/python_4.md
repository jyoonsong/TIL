**5.1. 점추정**

```python
x = np.array([14.0, 14.2, 15.1]) # 표본
x.mean() # 표본평균
x.std(ddof = 1) # 표본분산 np.sqrt( ((x-x.mean())**2).sum()/9)
```

**5.2. 구간추정** 

```python
np.random.seed(1)
alpha = 0.05 # 95% 신뢰구간
size = 50 # 각 표본의 크기
count = 0
n = norm(loc = mu, scale = sigma) # mu = 0, sigma = 1
for i in range(1000): # 표본생성 1000번 반복
    x = n.rvs(size = size)
    upper = x.mean() + n.ppf(1 - alpha/2) * (sigma/np.sqrt(size))
    lower = x.mean() - n.ppf(1 - alpha/2) * (sigma/np.sqrt(size))    
    if (lower < mu) & (mu < upper): count = count + 1
(lower, upper) # 각 신뢰구간
count / 1000 # 신뢰수준 = 뮤 포함 / 전체 (0.95 정도 나올 것)
```

```python
m = livarea.mean() o = livarea.std() # 모평균 모표준편차
np.random.seed(1) upper = [] lower = [] count = 0 n = 60 alpha = 0.05
standard = norm(loc = 0, scale = 1)
for i in range(50):
  sample = np.random.choice( livarea, n )
  upper.append(sample.mean() + standard.ppf(1-alpha/2)*(o/np.sqrt(n))) 
  lower.append(sample.mean() - standard.ppf(1-alpha/2)*(o/np.sqrt(n))) 
lo = np.array(lower) hi = np.array(upper) # [l1, l2,...] [h1, h2,...]

# 50개의 신뢰구간들을 그래프로 그려서 신뢰수준의 의미 확인하기
def plot_ci(lo, hi, m):
    k = len(lo) # k개의 신뢰구간
    plt.figure(figsize = (10, 6), dpi = 80)
    # 수직선: 시작점이 (m, -2)
    plt.vlines(m, -2, 41 * k / 40, color = "C0", linestyle = "--") 
    plt.axis("off") # 축 제거
    # 글씨 쓰기: xpos, ypos, 텍스트 내용
    plt.text(m*0.99, -3, '$\mu$ = %.3f' % m)
    # 50 * 2 행렬 생성 [[l1, h1], [l2, h2],...]
    y = np.array([lo, hi]).T # transpose: 같은 index끼리 짝짓기 

    for i in range(k):
      ci = y[i] # [lower bound, upper bound]
      mean = y[i].mean() # 표본평균과 동일
      if (lo[i] > m) or (m > hi[i]): # red dashed line (뮤를 포함X)
        plt.plot(mean, i, "C3o")
        plt.hlines(y = i, xmin = ci[0], xmax = ci[1], colors = 'r', linestyles = "dashed")
      else: # black line (뮤를 포함O)
        plt.plot(mean, i, "C1o")
        plt.hlines(y = i, xmin = ci[0], xmax = ci[1])
    plt.show()
```

**5.3. 가설검정**

```python
sd = 100 n = 25 xbar = 1550 mu = 1500
z0 = (xbar - mu) / (sd / np.sqrt(n)) # 검정통계량 = z0
CR = norm.ppf(0.95, loc = 0, scale = 1) # 기각역: Z >= CR (z0 속하는가?)
p_val = 1 - norm.cdf(z0, loc = 0, scale = 1) # 유의확률 (알파보다 작은가?)
```

