# Ch.14 B-tree

### 0. 정의

- B-tree는 디스크 환경에서 사용하기에 적합한 Balanced 외부 다진 검색트리.

  - 외부검색트리: 검색트리가 디스크에 있는 상태로 사용됨. 메모리에 모두 올려놓지 못하기 때문.
  - 다진검색트리(K-ary): 검색 트리의 분기 수를 늘리면 검색트리의 기대 깊이를 낮출 수 있다.

- 성질

  - search tree:  `Ti` < keyi < `Ti+1`
  - balanced search tree: 모든 leaf node는 같은 깊이를 가진다. => guarantees `O(log n)` 
  - k-ary tree: **root를 제외한** 모든 노드는 `[k/2] ~ k`개의 key를 가진다. floor 5/2 = 2

  > 분기의 수를 가능하면 늘리되 균형을 맞추기 위해 각 노드가 채울 수 있는 최대 허용량의 반 이상을 채워야 한다

- Node의 구조

  - key
  - 자식 노드 pointer (자식 노드로의 분기를 위한 block number)
  - 부모 노드 pointer (부모 노드로의 block number)
  - record index (record를 가져올 수 있는 block number) = pi(사진) = bi(코드)

  > 메인 메모리에서 해당 레코드를 찾기 위해 간단한 프로그램이 필요하겠지만 디스크 접근 시간에 비하면 무시할 수 있을 정도로 작은 시간.

  ```markdown
  key = n byte, 페이지 번호 = m byte, 디스크 1블록 = B byte일 때 
  최대 `B+n/2m+n`분기, 최대 `B+n/2m+n - 1`개의 key 가질 수 있다.
  m + m * k + n * (k-1) + m * (k-1) = (2m+n)k - n = B이므로 k = `B+n/2m+n`
  ```

  ![](/Users/mac/Pictures/node.png)

---

### 1. Implementation

- **Search**
  - binary에서 key와의 비교를 통해 왼쪽 오른쪽 분기를 정하듯이
  - B-tree에선 keyi-1 < x < keyi인 두 키를 찾아 분기해야할 자식을 찾는다.
    자식으로 내려가면 깊이만 하나 내려간 똑같은 검색 문제: recursion으로 푼다.

```java
BRetrieve(fIndex, fData, rootNum, key) {
    // fIndex: B-tree file; fData: data file; key: search key
    // rootNum: block # that contains the root of the tree(subtree)
    if (rootNum == -1) return null;
    buf.readBlock(fIndex, rootNum);
    if (key is one of the 'ki's in the root) { // get data item
        bi = data-file block # that index record specifies;
        buf.readBlock(fData, bi);
        return the item corresponding to key from buf;
    } else { // branch
        bi = block # to branch;
        BRetrieve(fIndex, fData, bi, key);
    }
}
```

- **Insertion**

```java
BTreeInsert(t, x) { // t: root node
    x를 삽입할 leaf node r을 찾는다;
    x를 r에 삽입한다;
    if (r에 overflow 발생) clearOverflow(r);
}
clearOverflow(r) {
    if (r의 "양옆 형제 노드" 중 여유가 있는 노드 s가 있음) 
        r의 남는 key를 s로 넘긴다; // 부모로 보내고, 부모에 있던 걸 s로
    else {
        r을 2로 분할하고 가운데 key를 "부모 노드" p로 넘긴다; // 가운데는 floor/ceil
        if (p에 overflow 발생) clearOverflow(p);
    }
}
```

- **Deletion**
  - 부모에 key1개 가능 - If a removal ever propagates all the way up to the **root**, leaving it with **only one record and only two children**, you are finished because the definition of a B-tree allows this situation. 
  - 부모에 key 0개 불가 - If a future removal causes the root to have **a single child and no records**, you **remove the root** so that the tree’s height decreases by 1.

```java
BTreeDelete(t, x, v) { // v: x를 가지고 있는 node
    if (v != leaf node) then { 
        // balanced면 leaf node가 아닌 값의 직후원소는 무조건 leaf node이다.
        x의 직후원소 y를 가진 leaf node를 찾는다; 
        x와 y를 맞바꾼다;
    }
    leaf node에서 x를 제거하고 이 leaf node를 r이라 한다; 
    if (r에서 underflow 발생) then clearUnderflow(r); 
}
clearUnderflow(r) {
    if (r의 "양옆 형제 노드" 중 key를 하나 내놓을 수 있는 여분을 가진 노드가 있음) 
        r이 key를 넘겨받는다; // 부모로 보내고, 부모에 있던 걸 r로
    else { 
        r의 형제 노드와 r을 합병한다; // 부모에서 형제 노드와 r 사이의 key 가져옴
        if (부모 노드  p에 underflow 발생) clearUnderflow(p);
    }
}
```

---

### 2. Efficiency

- d진 검색트리가 

- B-tree에서 임의의 internal node는 (root는 예외)

  - 최대 d개의 자식을 가질 수 있고 (최대 k개의 key)
  - 최소 ceil[d/2] 개의 자식은 가져야 한다. (최소 floor[k/2]개의 key)

- 따라서 B-tree의 높이는

  - 최선의 경우 균형을 아주 잘 맞추면 높이가 `logd의 n`에 근접. (BST가 log2의 n이듯이)
  - 최악의 경우에도 "대략" `log d/2의 n`보다 깊을 수 없다.

- B-tree에서 작업의 수행시간은 **디스크 접근 횟수**를 기준으로 한다.

  > 노드를 메인 메모리에서 가져온 다음 수행하는 작업의 소요 시간은 디스크 접근 시간에 비하면 작기 때문에 여기서는 고려하지 않는다.

1. **insertion**

   - **search** = `O(log n)` 실패하는 검색을 한 번 수행
   - **overflow 처리** 
     - best case: overflow가 발생하지 않으면 - `상수 시간`
     - worst case: 반복적으로 발생해서 root까지 파급되면 트리 높이에 비례 = `O(log n)`

   => 합하여 `O(log n)`

2. **deletion**

   - **직후 원소 검색** = `O(log n)`
   - **underflow 처리** = best `O(1)`  worst `O(log n)`

   => 합하여 `O(log n)`

점근적으로 `log n`으로 통칭되지만 log의 밑이 더 크기 때문에 BST에 비해 상수 인자가 상당히 작음.