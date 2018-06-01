# Ch.12 Balanced K-ary Search Trees

> special case of B-trees

## 1. 2-3 Tree

#### 1.1. 정의

- Intuitive
  - each internal node는 **2 or 3** children
  - all **leaves** are at the **same level** (강력한 성질)
- `T` is a 2-3 tree of height `h` if
  - `T` is empty (h = 0) or
  - `T` is of the form (root node `r`이 `Tl` `Tm` `Tr`로 분개) where `Tl` `Tm` `Tr` are
    - 2-3 tree, 
    - each of **height `h-1`**
    - only `Tr` can be empty - 1개 key in the node `r`
  - 2-3 tree of height 3



## 2. 2-3-4 Tree

#### 2.1. 정의

- Intuitive
  - each internal node는 **2 or 3 or 4** children
  - all **leaves** are at the **same level** (강력한 성질)
- `T` is a 2-3-4 tree of height `h` if
  - `T` is empty (h = 0) or
  - `T` is of the form (root node `r`이 `T1` `T2` `T3` `T4`로 분개) where `T1~4` are
    - 2-3-4 tree,
    - each of **height `h-1`**
    - only `T3` `T4` can be empty - 1 or 2개의 keys in the node `r`