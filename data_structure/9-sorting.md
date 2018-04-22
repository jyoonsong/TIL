# Ch.09 Sorting

### 1. Selection Sort

- **Iteration**

  boundary case: 1개 남았을 때까지

  - find the largest item
  - swap it to the rightmost place
  - exclude the rightmost item

```java
// non-recursive
selectionSort(Arr[], n) {
    for (last = n-1; last >= 1; last--) {
        largest = indexOfLargest(Arr, last+1);
        swap Arr[largest] & Arr[last];
    }
}
indexOfLargest(Arr[], size) {
    largest = 0;
    for (i=1; i < size; ++i)
        if (Arr[i] > Arr[largest]) largest = i;
    return largest;
}
```

```java
// recursive (기출)
selectionSort(Arr[], n) {
    if (n > 1) {
        largest = indexOfLargest(Arr, n);
    	swap Arr[largest] & Arr[last];
        selectionSort(Arr[], n-1);
    }
}
indexOfLargest(Arr[], size) {} // 위와 동일
```

---

### 2. Bubble Sort

- 바깥 for loop = 가장 큰 원소를 끝자리로 옮기고 정렬대상 줄이는 작업 반복 (=선택정렬)

- 안쪽 for loop = 가장 큰 원소를 끝자리로 옮김. (왼쪽부터 이웃한 수를 비교하면서 하나씩 바꿔나감)

  > asymptotic 하게는 selectionSort와 시간 일치 (비교하는 것이 시간을 지배하므로)
  >
  > **But 사실 하나하나 swap하는 시간이 더 들긴 함**

```java
bubbleSort(A[], n) {
    sorted = true;
    for (last = n; last >= 2; last--) {
        for (i=1; i < last; i++) {
            if (A[i] > A[i+1]) swap A[i] & A[i+1];
            sorted = false;
        }
        if (sorted) return; // 끝나고 나서도 sorted true면 이미 정렬된 array
    } // sorted 변수는 이미 정렬된 배열이 들어왔을 때 무의미한 순환을 방지해준다.
}
```

---

### 3. Insertion Sort

- 반대로 정렬안된 array를 하나씩 줄여나감. = 정렬된 array를 늘여나감 (수학적귀납법과 유사)

```java
insertionSort(A[], n) {
    for (i = 2; i < n; i++) {
        newItem = A[i];
        for (loc = i-1; loc >= 1 && newItem < A[loc]; loc--)
            A[loc+1] = A[loc]; // newItem보다 큰 애들은 한 칸씩 뒤로
        A[loc+1] = newItem; // newItem보다 같거나 작은 첫번째의 index가 리턴됨
	}
```

---

### 4. Merge Sort

```java
mergeSort(A[], p, r) {
    if (p < r) {
        q = [(p+r)/2]; 			// 아래꺾쇠
        mergeSort(A, p, q); 	// sort S1
        mergeSort(A, q+1, r); 	// sort S2
        merge(A, p, q, r);		// 후처리
    }
}
merge(A[], p, q, r) { // A[p..q]와 A[q+1..r]을 병합
    i = p; j = q+1; t = 1;
    while (i <= q && j <= r) {
        if (A[i] <= A[j]) // 등호 없으면 unstable
            tmp[t++] = A[i++]; // tmp[t] = A[i]; t++; i++;
        else tmp[t++] = A[j++];
    }
    while (i <= q) // S1이 남은 경우
        tmp[t++] = A[i++];
    while (j <= r) // S2가 남은 경우
        tmp[t++] = A[j++];
    i = p; t = 1;
    while (i <= r) // 결과를 A에 저장
        A[i++] = tmp[t++];
}
```

---

### 5. Quick Sort

- 임의의 pivot을 고른다

- 이를 중심으로 더 **작거나 같은** 원소는 왼쪽으로, 더 **큰** 원소는 오른쪽으로 재배치한다

  > Partition 방법은 다양하다 - 아래는 Logically right, but practically unnecessary
  >
  > - **등호* 양쪽에 들어가도 될까?** 된다 어차피 pivot과 같은 값은 그 양옆에 붙게 되니깐. 굳이 그렇게 할 필요가 없을 뿐.
  > - **partition을 다른 array에서 하면 안될까?** 된다. 하지만 in place sorting이 안됨.

```java
quickSort(A[], p, r) {
    if (p < r) {
        q = partition(A, p, r); // pivotIndex (분할 = 선행작업)
        quickSort(A, p, q-1);	// Left
        quickSort(A, q+1, r);	// Right
    }
}
partition(A[], p, r) {
    x = A[r]; 					// pivot 마지막 원소로 잡음
    i = p-1; 					// i: 1구역의 끝 (작거나 같을 때만 1 증가)
    for (j=p; j <= r-1; j++) 	// j: 3구역의 시작 (자동으로 1씩 증가)
        if (A[j] <= x) 			// 등호*
            swap A[++i] & A[j];	// i++; 이후 swap A[i] & A[j];
    	// else 그냥 두면 저절로 j 1 증가하여 2구역이 한 칸 넓어짐
    swap A[i+1] & A[r];
    return i+1;
}
// 1구역: pivot보다 작거나 같은 원소 / 2구역: pivot보다 큰 원소
// 3구역: 아직 정해지지 않은 원소 / 4구역: pivot 자신
// for루프 한 바퀴 돌 때마다 3구역 한 칸씩 줄고, 1 또는 2구역 한 칸 늘어남
// 1구역이 늘어날 땐 i, j 모두 1 증가, 2구역이 늘어날 땐 j만 1 증가
```

---

### 6. Radix Sort

- 입력이 모두 **최대 n의 자리수를 가진 자연수**인 특수한 경우 사용 가능

- LSD로 정렬 => MSD까지 차례대로 진행

  > **MSD부터 하면 안된다**

- stable sort가 지켜지지 않으면 제대로 정렬 안된다. k번째 자리 수가 같으면, 앞에서 k-1번째 자리까지 제대로 정렬되어 있던 것이 순서가 바뀔 수 있다.

```java
radixSort(A[], d) {
    for (j = d; j >= 1; j--)
        j번째 자리수에 대해 A[]를 stable sort 한다.
        // 이 부분이 비교정렬이어서는 절대 안된다! 그것만으로도 O(n) 초과해버림
        // 예: 0~9 10개 공간 준비해놓고 각각의 수를 가진 입력은 해당 공간에 차례로 넣어줌
}
```

---

radix를 제외한 알고리즘은 모두 **원소끼리 비교하는 것으로 정렬하는 비교정렬**

비교정렬은 **worst case 수행시간이 절대 Ω(nlogn)**을 밑돌 수 없다. (선형시간 불가)

### In-place Sorting

공간이 주어지면 해당 공간 안에서 sorting을 끝내는 것.

- `mergesort` 이론은 매력적이지만 **in-place sorting**이 불가하여 field에선 잘 안쓰인다.

  auxillary temporary array를 만들어서 2배의 공간을 사용.

- selectionSort, bubbleSort, insertionSort, quickSort, heapSort 모두 해당됨.

  QuickSort가 가장, HeapSort도 field에서 선호된다

### Stable Sort

값이 같은 원소끼리는 정렬 후에 원래의 순서가 바뀌지 않는 성질

- quick (X)

  selection (X) **최대값 중 가장 뒤에 있는 것을 최대값으로 삼으면 안정성을 유지할 수 있다**

- bubble, insertion, radix (O)

  merge (O) **단, 왼쪽과 오른쪽 원소가 같을 때에는 왼쪽부터 꺼내야 한다.**