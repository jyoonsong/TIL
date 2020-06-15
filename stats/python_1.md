**2.1. 일변량 자료의 요약 - 그래프**

```python
import matplotlib.pyplot as plt
plt.ylabel('frequency')
plt.title('Histogram')
plt.show()
# 히스토그램
fig = plt.figure( figsize=(15,5)) # create figure (width, height)
plt.subplot(1,2,1) # (nrows, ncols, index) 
plt.hist([98,90,96,54,43,87,88,90,94,92,81,79,85,91,79,88,89,83])
plt.subplot(1,2,2)
plt.hist(score, density=True) # desity는 상대도수로 만들어줌 (sum = 1)
# 상자그림
plt.boxplot(score)
```

```python
# 줄기-잎 그림
import stemgraphic
stemgraphic.stem_graphic(score, scale = 10)
```

**2.2. 일변량 자료의 요약 - 수치적 요약**

```python
# 범주형 자료는 어떠한 요약 방법을 사용할 수 있는가?
from collections import Counter
cg = Counter(gender)
print(cg) # 1) 분할표
plt.bar(list(cg.keys()), list(cg.values())) # 2) bar chart
```

```python
# 수치형 자료의 수치적 요약값을 구해보자.
import numpy as np
print(np.mean(score))
print(np.median(score))
print(np.percentile(score, 25)) # n분위수
print(np.std(score))
print(np.var(score))
print(np.min(score))
print(np.max(score))
print(np.sum(score))
```

**2.3. 이변량 자료의 요약 - 그래프**

```python
# 산점도
fig = plt.figure()
fig.suptitle("Relationship btw A and B", fontsize = 24)
plt.xlabel('A', fontsize = 16)
plt.ylabel('B', fontsize = 16)
plt.scatter([66,64,38], [70,68,36], c = 'red', marker = 'x')
# 모자이크 그림
import pandas as pd
from statsmodels.graphics.mosaicplot import mosaic
mosaic(pd.read_csv("gender_spouse.csv"), ['gender', 'spouse'])
plt.show()
```

**2.4. 이변량 자료의 요약 - 수치적 요약**

```python
# 상관계수
np.corrcoef([66,64,38], [70,68,36])
# 이차원 분할표
counttbl = pd.crosstab(index = data["gender"], columns = data["spouse"])
```

**assignment1: pandas로 txt 파일 읽어오기**

```python
import pandas as pd
df = pd.read_csv("cdc.txt", sep = " ")
df.info()
df.describe()
df.shape

df.genhlth.head() # 특정 변수에 대해서도 실행 가능
df.iloc[0,0] # row, col
df.iloc[0:3, 3:5]
df.loc[df.exerany == 0] 
```

**두 변수의 차를 계산하여 새로운 변수 diff를 만들어보자. diff의 분포는 어떠한가? 수치적 요약과 그래프 요약을 통해 살펴보자. 이것이 의미하는 바는?**

```python
diff = [x1 - x2 for (x1, x2) in zip(df.wtdesire, df.weight)]
np.mean(diff) # 수치적요약 (위처럼 똑같이)
plt.boxplot(diff) # 그래프 1) 상자그림
plt.hist(diff, bins = 25) # 그래프 2) 히스토그램
# 왼쪽으로 긴 꼬리를 가진 그래프의 모양과 흡사. 즉 증량을 원하는 응답자보다는 감량을 원하는 응답자가 많음. 왼쪽으로 긴 꼬리를 가졌지만 대체로 중앙에 응답이 몰려 있는 편이고, 양끝으로 갈 수록 응답자가 현저히 적어지는 양상을 띤다. 최소/최대값은 극단적 outlier
```



