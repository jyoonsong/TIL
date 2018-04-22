# Ch.10 Tree

> 여기서 Tree는 **Rooted Tree** (지난 필기 참고)

### 0. Terminology

- node / vertex
- edge
- parent - child
  - B는D의parent
  - D는B의child
  - D, E,F는 B의children
- siblings
- root
- leaf
  - 자기의 child를 가지지 않는 node. 나무의 끝은 잎이니깐.
  - Terminal node(말단노드). 
- subtree 
  - B를 root로 하는 subtree - BDEF
  - C를 root로 하는 subtree - C 하나



### 1. Tree의 정의

- 비어있는 tree도 tree (base case)
- 비어있지 않으면 root가 있어야 하고, 그 밑에 set of general trees가 붙어있어야 함.

> tree 구조 쓰기 좋은 예 - **회사 조직도, 가족 관계도**



---



### 1.1. Binary Tree의 정의

모든 Node가 자식을 최대한 2개까지만 가지는 Tree

- 비어있는 tree도 tree (base case)
- 비어있지 않으면 3개의 부분으로 나뉨
  - root node
  - left subtree
  - right subtree

이 관계가 recursive하게 반복된다.



**예: Algebraic Expressions**

- 수주(?) 표현도 binary tree로 나타내기 좋은 예
- Infix => postfix, prefix로 바꿀 수 있음.


---



### 1.1.1. Binary Search Tree

- Binary Tree이면서
- 모든 Node에 들어가는 **값이 다 다르다**

> **색인(Index; 찾아보기)**를 위해 고안됨. - 나중에 다시.



**예: Binary Search Tree of Names**

- 사실 적절한 예 아님. 이름이 Tom인 사람 한 명 더 있다면 새로운 자료구조 달아줘야 함. array를 한다던지. Binary Search Tree의 노드들은 적어도 다 달라야함.
- 가장 이상적인 예. 균형이 딱 맞음. 하지만 이런 경우 많이 없다.


---



### 1.1.2. Full Binary Tree

**Height of a Tree**

- number of nodes from the root to a leaf 중 longest

- node 1개 있을 땐?

  - height 1로 잡는 게 편하다

    empty일 때 height 0일 수 있도록



**Full Binary Tree 정의**

> empty부터 시작하는 게 정의에 모순이 안 생김

- empty라면
  - height 0
- empty가 아니면
  - Root 노드 하나 있고
  - left와 right subtree가 각각 height `h-1`인 full binary tree (recursive)


---



### 1.1.3. Complete Binary Tree

**Full Binary Tree가 되고 싶으나 숫자가 안 맞아서 만들어진 녀석 (굉장히 유용!)**

n(node의 수) = 2^k - 1이어야 full binary tree가 될 수 있다

> 새로 붙는 단계의 노드 수는 **현재 전체 노드수 + 1** 만큼 붙는다. (나중에 유용)



**Complete Binary Tree의 정의**

- height h
  - level h-1까지는 full
  - level h 즉 맨 아래쪽에는 숫자를 못맞추니깐 왼쪽부터 채워나간다.


---

---



### 2. ADT of Binary Tree

#### 2.1. Array Based

- left는 1에 right는 2에
- 없으면 -1라고 약속



#### => Complete Binary Tree의 경우

0부터 시작하면

- Node i의 children = `2i+1` `2i+2` 라는 일정한 규칙이 있어 편함.
- Node i의 parent = `i-1/2`에 bottom을 취하면 됨.

1부터 시작하면

- `2i` `2i+1`
- `i/2`에 bottom



#### 2.2. Reference based

> C의 경우 Pointer based

reference 두 개씩

> dynamic 하게 하면 
> 만든 만큼만 공간을 할당받을 수 있다 (+) 
> but 메모리를 쪼개는 번거로움이 있다 (-)

```java
public class TreeNode {
	private Object item;
	private TreeNode leftChild;
	private TreeNode rightChild;
    // Constructors
	public TreeNode(Object newItem) {
		item = newItem;
		leftChild = rightChild = null;
	}
	public TreeNode(Object newItem, TreeNode left, TreeNode right) {
		item = newItem;
		leftChild = left;
		rightChild = right;
	}
    // Operations
	public Object getItem( ) {
			return item;
	}
	public void setItem(Object newItem) {
			item = newItem;
	}
	public TreeNode getLeft( ) {
			return leftChild;
	}
	public TreeNode getRight( ) {
			return rightChild;
	}
	public setLeft(TreeNode left) {
			leftChild = left;
	}
	public setRight(TreeNode right) {
			rightChild = right;
	}
} // end TreeNode

```



---

---



### 3. ADT of Binary Search Tree

#### 들어오는 순서에 따라 달라진다.

- S22일 수도 (이상적)

  - Jane이 가장 먼저 들어옴

- S23일 수도

  - Tom이 가장 먼저 들어옴
  - 그다음에 Jane, Wendy 들어옴
  - Jane이 앉고 나서 Bob, Nancy가 들어옴

- S24일 수도

  - 바람직하지 않아도 그런대로 쓸만하다

- S25일 수도 있다

  - array만도 못한 게 되버린다. 이런 일자형도 발생할 수 있음.

  - 이처럼 **깊을 수록 효율이 떨어진다**. 서치 했을 때 최악의 경우가 최대로 깊어지기 때문.

    > 그래서 **균형에 대한 관심**이 생기는 것. 균형이면 깊은 것을 피하니깐 (알고리즘 때 배움)



#### 참고: Binary Search Tree는 Index (색인, 찾아보기)로 유용하다

> 구글 검색은 그 사이트 가서 찾는 게 아니라 구글의 색인에서 찾는 것.
>
> 색인은 어떻게 생겼는가. Keyword & Reference Point 가 담김.



#### 핵심 Operations

- 2) insert (넣기)
- 3) delete (빼기)
- 1) retrieve (찾기)



#### 3.1. Search

recursive 원리: 오버헤드를 거치면 자신과 똑같지만 더 작은 문제를 만나게 됨

- 전체 tree에 대한 x 찾기는

  - a와 비교하는 overhead를 감수하고나서

    left/right subtree에 대한 x 찾기로 수행

- basecase - 맨 밑까지 가서 null을 만나면 not found



#### 3.2. Insertion

> Search와 거의 같다. 맨 마지막 만 다름.
>
> => 왜냐하면 **기존에 없는 key를 집어넣어야 하니깐**
>
> => 새로 들어온 학생이 기존 학생과 학번이 같으면 안됨

- Search 알고리즘과 같은 과정 수행
  - 성공하는 검색 값 리턴해줄 필요 없음 (difference)
- basecase - 맨 밑까지 null을 만나면 **not found 대신 거기다 매달아준다** (difference)



#### 3.3. Deletion

- 일단 찾아야 함 search
- 그 후 `deleteNode`



=> `deleteNode`는 크게 **두 가지 케이스**로 나뉜다

> 노트에 정리함

- **Case 1. Leaf Node** S32
- **Case 2. 1 child** S33, 34
- **Case 3. 2 children** S35



```java
deleteNode (dNode) {
		if (dNode is a leaf) { dNode 삭제; } // case 1
		else if (dNode has only one child c) {   // case 2
			c replaces dNode;
		} else { // dNode has two children         // case 3
			minNode =  dNode’ right subtree의 leftmost node; 
			// minNode has at most one right child
			minNode replaces dNode; 
			deleteNode(minNode); 
		}
}
```

deleteNode는 0 또는 1번만 불러질 수 있음! 

- case3에 간다고 해도 그 때 부르는 minNode는 반드시 case 1 또는 2이니깐.


---

---



### 4. 이제 실제 코드로 구현해보자

> 복습
>
> - 검색
> - insertion - 검색과 같은 과정을 밟아야 한다. 느닷없이 매달 수 없고 항상 끝에 매달려야 하니깐.
> - deletion - 3 cases (마지막 case - 구조를 바꾸면 그 위 노드가 감당을 못한다. 따라서 구조는 그대로 두고 빈자리에 minimum item을 집어넣음.

**add**

```java
/* pseudo */
insert (root, newItem) {
    if (root is null) {
        newItem을 key로 가진 새 node를 매단다; 
    }
    else if (newItem < root’s key)
        insert(root’s left child, newItem);
    else
        insert(root’s right child, newItem);
}

/* 실제 구현 */
insert(Comparable newItem) {
			root = insertItem(root, newItem);
} // 왜 나누어 놓았는가? root와 최초의 값을 연결하기 위해 
TreeNode insertItem(TreeNode tNode, Comparable newItem) {
	if (tNode == null) { // insert after a leaf  (or into an empty tree)
		tNode = new TreeNode(newItem, null, null);
	} else  if (newItem < tNode’s item) { // branch left로 내려간다
		tNode.setLeft( insertItem(tNode.getLeft( ), newItem) );
        // ***** [주목] insertItem의 return값으로 setLeft ******
        // 실제 insert하는 게 아니라 그냥 밑의 node로 이동하는 것
        // 즉 대부분의 경우에는 있는 값이 그대로 reference되고 맨 마지막에만 바뀜
	} else { // branch right로 내려간다
		tNode.setRight( insertItem(tNode.getRight( ), newItem) );
        // ***** [주목] insertItem의 return값으로 setRight ******
	}
	return tNode; 
} // end insertItem

```

**retrieve**

거의 유사

**delete**

조금 복잡

```java
/* search :: searchKey를 받아 target을 찾는다 */
TreeNode deleteItem (TreeNode tNode, Comparable searchKey) {
    if (tNode == null) {exception 처리}; // item not found!
    else {
        if (searchKey == tNode’s key) { // item found!
            tNode = deleteNode(tNode);
        } else if (searchKey < tNode’s key) {
            tNode.setLeft(deleteItem(tNode.getLeft( ), searchKey));
        } else {
            tNode.setRight(deleteItem(tNode.getRight( ), searchKey) );
        }
    }
    return tNode; // tNode: parent에 매달리는 노드
}

/* delete :: 실제 삭제한다 3 Cases */
TreeNode deleteNode (TreeNode tNode) {
    // Three cases
    //    1. tNode is a leaf
    //    2. tNode has only one child
    //    3. tNode has two children

    if ( (tNode.getLeft( ) == null)  && (tNode.getRight( ) == null)) { // case 1
        return null; 
    } else if (tNode.getLeft( ) == null ) {  // case 2 (only right child)
        return tNode.getRight( );
    } else if (tNode.getRight( ) == null) {  // case 2 (only left child)
        return tNode.getLeft( );
    } else {  // case 3 – two children
        tNode.setItem(minimum item of tNode’s right subtree);
        tNode.setRight(deleteMin(tNode.getRight( ));
        return tNode; // tNode survived
	}
}

/* minimum :: 위의 Case3을 위해 최소값을 찾아 삭제 (설정은 위에서 함) */
TreeNode deleteMin (TreeNode tNode) {
	if (tNode.getLeft( ) == null) { // found min		
		return tNode.getRight( ); // right child moves to min’s place
	} else { // branch left, then backtrack
		tNode.setLeft(deleteMin(tNode.getLeft( ));
		return tNode;
	}
}
```

---



### Traversal of Binary Tree

3가지 방법 (왼쪽 다 방문, root, 오른쪽 다 방문 순서에 따라)

- preorder - top에서 시작하여 left child부터 

- inorder - 말단에서 시작하여 맨 왼쪽 방문하고 그 오른쪽 방문

- postorder - 5개짜리 서브트리

  > prefix, postfix, infix와 유사

여기서의 방문이란 **처리(mark)** - 모든 노드에 어떤 처리를 가한다.

**preorder**

```java
preorder(root)
{
    if (root is not empty) { // base case
        Mark root;
        preorder(Left subtree of root);
        preorder(Right subtree of root);
    }
}ㅜ
```

**inorder**

```java
inorder(root)
{
    if (root is not empty) {
        inorder(Left subtree of root); 
        Mark root;
        inorder(Right subtree of root);
    }
}
```

**post order**

```java
postorder(root)
{
    if (root is not empty) {
        postorder(Left subtree of root);
        postorder(Right subtree of root); 
        Mark root;
    }
}
```

S50 efficiency - Traversal은 n에 비례 big theta가 더 정확



=> **방문순서를 쭉 나열하면 sorting이 될까?**

S51 - 수학적귀납법으로 증명(노트필기 참고)

---

[일반적 binary tree의 성질]

### Height

h(eight) = k일 때

- 마지막 줄 제외한 나머지 = 2^(k-1) - 1

- 마지막 줄 = 2^(k-1)

  > 한 개 더 많다는 게 직관적으로는 안 와닿는다! 하지만 엄청난 수임 (노트필기 참고)

- 전체 총합 = 2^k - 1

### Depth

들어오는 순서에 따라 달라진다

모든 순서 (n!가지 경우의 수) 에 대한 IPL 평균

아무렇게나 만들어진 binary tree 의 IPL의 기대치는 nlogn을 넘지 않음

= **아무렇게나 만들어진 binary tree의 평균적인 검색 시간은 logn upper bound = `O(log n )`**

> log n을 넘지 않는다는 건 아주 유용한 정보. 
>
> 즉 대충 만들어져도 평균적으로 괜찮다는 의미.



단, 재수없게 일자형 tree가 만들어지는 경우가 발생할 수도 있다.

- 꼭 순서를 지키고 오지 않아도 거의 일자형에 가까운 트리가 만들어질 수 있음

  but 위 정리에 따르면 이런 경우는 많이 발생하지 않는다.


---



### Tree size

**recursive!**

tree size = left child를 root로 하는 subtree의 size + right size + 1



---



### EX: Huffman Code

**빈도수** 즉 많이 출현하는 심볼의 인코딩을 짧게 만들자! => **압축**에 사용

> ASCII코드는 모든 가능한 심볼이 7bit

e.g. 10 digits

Binary Tree를 만든다

- 제일 작은 거 합침 8, 9
- 그 다음 작은 거 합침 6, 7
- 4, 5
- 3, 8+9
- ...
- 거꾸로 보면 tree

tree에 기반하여 코드를 설정. 좌0 우1

- 0은 트리를 쭉 따라서 00
- 9는 트리를 쭉 따라서 11111

4 => 3.04 로 압축됨



---



### Treesort

**Inorder Traversal**

- Element 모두 넣고
- inorder traversal하면 크기대로 정렬된다

=> 만드는 데 걸리는 시간

- Average Case = `O(n log n)`

  각 노드의 깊이의 합 = IPL

  각 노드의 깊이란, 그 노드를 검색할 때까지의 시간이기도 함.

  즉 삽입과 검색은 시간이 같다.

  - 아무것도 없는 상태에서 노드를 넣어서 binary search tree 만드는 시간 `O(log n)`
  - inorder traversal은 n에 비례 `O(n* log n)`

  > 너무 오래걸려서 안 쓰임. 그래도 좋은 예.


---



### Saving BST in a File

사정에 의해 컴퓨터를 꺼야할 때 등 메모리에 있던 걸 잠시 저장해둬야 할 때 어떻게 저장?

1. 있는 그대로를 재현하자.

   - **Preorder**

2. 이거 우연히 들어온 순서에 의해 들어온 건데, 이왕 저장했다가 다시 쓰는 김에 optimal한 모양으로 다시 만들어서 저장하자.

   - **Inorder**

     가운데를 root로 하고 그 좌측은 왼쪽 subtree, 그 우측은 오른쪽 subtree로 만드는 recursive

     가운데를 root로 삼는 수고를 하고 나면 자신과 똑같지만 크기가 작은 문제를 만난다


---



### n-ary tree

검색의 경우 key가 하나여선 안된다.

cf) 나중에 배울 B-tree는 키가 k1…kn n개이면 그걸 기점으로 n+1가지로 분류





---

> 어떤 주제에 대해 의문을 가지거나 질문을 던지면
>
> 우리의 이해의 차원은 한 차원 높아진다
>
> definition 1차원 => 예를 익히면 2차원 벡터 => 질문을 던지면 3차원 벡터 => 또다른 관점 =>...
>
> 벡터 element가 하나씩 늘어나는 셈
>
> => 비틀어서 생각하고 질문하면서 생각하는 것이 중요하다. 2차원으로 이해한 것과 20차원으로 이해한 것은 천지차이.