## 6. 분포에 관한 추론

### 6.1. 모평균에 관한 추론

**일표본 t-검정**

예) 어느 대학의 신입생 가운데 랜덤하게 15명을 뽑아 심리검사를 실시한 결과 책임감에 대한 점수가 다음 표와 같았다. 이 대학 신입생의 평균 점수가 40점 이상이라고 할 수 있는지 유의수준 a = 0.05에서 검정해보자.

```python
import numpy as np
from scipy import stats

scores = np.array([22, 25, 34, 35, 41, 41, 46, 46, 46, 47, 49, 54, 54, 59, 60])
stat.sttest_1samp(scores, popmean = 40);
```

결과: Ttest_1sampResult(statistic = 1.354469, pvalue = 0.197044)

- statistic은 검정통계량
- pvalue는 양측 유의확률
  - 단측 유의확률은 2로 나눈 값

**신뢰구간**

```python
from scipy.stats import t
mean = np.mean(scores) 
T = t.ppf(0.975, df=14) * np.std(scores, ddof = 1) / np.sqrt(15);

print (mean - T, mean + T)
```

**정규분포 가정 확인**

```python
import matplotlib.pyplot as plt
from statsmodels.graphics.gofplots import ProbPlot
from scipy.stats import shapiro

# 정규분포분위수 대조도
QQ = ProbPlot(scores)
plot = QQ.qqplot(line = 's', color = 'C0', lw = 1)
plt.title("Normal Q-Q Plot")
plt.show()

# Shapiro-Wilk's Normality test
stat, p = shapiro(scores);
print(stat, p)
```



### 6.2. 대응비교에 의한 모평균의 비교

예) 색감의 차이가 감정변화에 미치는 영향을 연구하기 위하여 14명을 랜덤으로 선택하여 이들을 60초 간격으로 보라색과 초록색에 반복적으로 노출시키는 실험을 6분간 지속하였다. 각 색이 변할 때마다 최초 12초간 피부에 나타나는 전기반응을 측정하여, 각 색 별로 평균을 취한 후, 이것을 최종 자료로 선택하였다. 다음 자료를 이용하여 보라색과 초록 색 사이에 감정변화에 미치는 영향이 존재하는지를 유의수준 5%에서 검정하시 오. 단, 자료는 모두 정규분포 가정을 만족한다고 하자.

```python
import pandas
paired = pandas.read_csv("paired.txt", sep = " ")

stat.ttest_rel(paired['purple'], paired['green'])
```

결과: Ttest_relResult(statistic=6.3380731434065325, pvalue=2.5838913496640584e-05)

**신뢰구간**

```python
diff = paired['purple'] - paired['green']

mean = np.mean(diff)
T = t.ppf(0.975, df = 13) * np.std(diff, ddof = 1) / np.sqrt(14)

print(mean - T, mean + T)
```

**정규분포 가정에 대한 확인**

위와 동일



### 6.3. 이표본에 의한 모평균의 비교

예) 한 페인트 제조회사에서는 새 상품의 유성페인트를 개발하여 기존의 페인 트와의 건조속도를 비 교하고자 한다. 이를 확인하기 위해 시중에서 가장 인기 있는 상품과 새 상품을 각각 5종류의 벽에 칠한 후 건조 시간을 측정하였다. 새 상품은 기존의 상품보다 건조 시간이 더 빠르다고 할 수 있는가? 유의 수준 5%에서 검정 해보자. 

**6.4. 두 모분산에 관한 추론**

```python
from scipy.stats import f
def var_test (sample1, sample2): 
  n1 = len(sample1)
  n2 = len(sample 2)
  
  s1 = sum((sample1 - sample1.mean()**2)) / (n1 - 1)
  s2 = sum((sample2 - sample2.mean()**2)) / (n2 - 1)
  
  dfn = n1 - 1
  dfd = n2 - 1
  
  F = s1/s2
  
  pval = 2 * min(f.cdf(F, dfn = dfn, dfd = dfd), 1 - f.cdf(F, dfn = dfn, dfd = dfd))
  
  print("F test to compare two variances: F = %s, num df = %s, denom df = %s, p-value = %s" % (round(F, 5), dfn, dfd, round(pval, 5)))
```

결과 

- 검정통계량 F = 1.83333 
- 유의확률 p-value = 0.37999

**등분산을 가정한 독립 이표본 평균 검정**

```python
stats.ttest_ind(group1, group2, equal_var = True)
```

**정규분포 가정에 대한 확인**

위와 동일

### 

### 정리

| 종류                                  | 코드                                      |
| ------------------------------------- | ----------------------------------------- |
| 일표본 t-검정                         | `stats.ttest_1samp(a, popmean)`           |
|                                       | `t.ppf(0.975, df)`                        |
| 대응비교                              | `stats.ttest_rel(a, b)`                   |
| 등분산을 가정한 독립 이표본 평균 검정 | `stats.ttest_ind(a, b, equal_var = True)` |
|                                       |                                           |

