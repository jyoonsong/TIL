# Ch.14 External Methods

## 0. External Storage

- External Storage가 필요 (Disk, CD-ROM, tape등)

  - External storage exists after program execution
  - far more of it: 사이즈가 큰 data는 모두 internal memory에 load될 수 없다. 전체의 일부만 main memory에 있을 수 있다.

- 한 번의 disk access는 수십만 번의 instruction 수행과 맞먹는다.

  - 따라서 대부분 external storage access가 시간을 지배한다.
  - 물론 SSD의 시대가 열려 부담이 많이 줄었다. 하지만 여전히 RAM과의 차이는 크다.

- **Block** = External storage access의 단위 (쪼개서 가져올 수 없다)

  - Block sizes = 4K, 8K, 16K, 32K bytes 등 시스템에 따라 결정됨

  - Each Block = consists of multiple data *records* 

    > record가 아닌 block 단위로 읽음! readRecord해도 내부적으론 block에 접근

  - Block access `buf.readBlock(dataFile, i)` `buf.writeBlock(dataFile, i)`

    - `buf` = object for memory buffer = buffer stores data temporarily
    - `i` = index of block

    => 목표: reduce the number of required block accesses

---

## 1. External Sorting

#### 1.1. External MergeSort

과거: all data to be sorted is available at one time in internal memory 라고 가정
현실: too large to fit into internal memory all at once

- F:Original Data => F1, F2:Work Files

- phase1: sorting

  - F의 block을 가져와 internal sort 후 F1에 저장 => 16 sorted runs(1 block/run)
  - main memory에서 1block씩 다루게 되므로 문제 없음

- phase2: merging

  - F1에 저장된 runs를 F2로 옮기며 merge => 8 sorted runs(2 blocks/run)

  ​	다시 F2에 저장된 runs를 F1으로 옮기며 merge => 4 sorted runs(4 blocks/run)...

  ![image](https://user-images.githubusercontent.com/17509651/40878943-9798565a-66d3-11e8-9220-188d698822a0.png)

  - In the later steps of phase 2, runs contain more than max records each(300), so you must **merge the runs a piece at a time.**

    => internal memory into three arrays, in1, in2, out, each capable of 100 records

    > assumes that the number of blocks in the file is a power of 2 

  - (a) 16runs(1block/run) merge: 딱 들어맞아 비교적 쉬움. 

    - in1에 run1, in2에 run2, 이 둘을 out으로 merge. 
    - 도중에 out이 full된다. 그럼 work file로 옮기고 resume merge.

  - (c) 4 runs (4blocks/run) merge:

    - in1에 run1의 firstblock B1, in2에 run2의 firstblock B5를 넣고 out으로 merge 시작
    - **in1 혹은 in2이 비워지면 다음 블록을 읽는다.** 예컨대 in2이 먼저 비워지면 read B6 into in2 before merge can continue.
    - 도중에 out이 full되면 work file로 옮기고 resume merge.

  ```java
  Read the first block of Ri into in1;
  Read the first block of Rj into in2;
  while ( !(both in1 and in2 are exhuasted) ){//둘다 exhausted될 때까지
      Select the smaller “leading” record of in1 and in2 and 
  	place it into the next position of out
  	(if one of the arrays is exhausted, select from the other);
      
      if (out is full)
          writeBlock(Write out to the next block of F2);//stop merge
      if (in1 is exhausted && blocks remain in Ri) //(a)에선 없음
          in1 = readBlock(next block of Ri); //stop merge
      if (in2 is exhausted && blocks remain in Rj) //(a)에선 없음
          in2 = readBlock(next block of Rj); //stop merge
  ```

  ![image](https://user-images.githubusercontent.com/17509651/40879219-c864263e-66d7-11e8-8245-dabe59ee1693.png)

- 몇 번의 access가 필요한가? (m: memory가 수용하는 block 개수, n: disk에 있는 block 총 개수)

  ![](/Users/mac/Desktop/Screen Shot 2018-06-03 at 1.52.11 PM.png)

---

## 2. External Tables

- Data File을 직접 organize하지 않고, Index File을 organize. Index record는 2가지로 이뤄짐.

  - key = search key (name, security number 등)
  - pointer = 실제 data file의 record를 가리킴. reference가 아닌 block number(int)

  => 이런 Index File을 organize하는 방법 (1) Hashing (2) Search Tree 두 가지 스키마 있음

#### 2.1. External Hashing

> Hash Table에서 Collision Resolution의 **Separate Chaining**과 같다

![image](https://user-images.githubusercontent.com/17509651/40883180-87284cf8-6732-11e8-87e3-dbcdfc71a1bb.png)

#### 2.2. B-trees

- 

#### 2.3. Multiple Indexing

maintain several indexes simultaneously

- one index file that indexes data file by one search key 예: <name, pointer>
- second index file that indexes data file by another search key 예: <socSec, pointer>

![image](https://user-images.githubusercontent.com/17509651/40883187-d2970cd8-6732-11e8-8a6d-64d0414e8418.png)