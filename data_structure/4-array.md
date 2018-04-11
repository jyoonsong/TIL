# Ch04. List (Array)

> 내가 정리 - **ADT List Implementation w/ Array**



### Operations

1. createList( )
2. isEmpty( )
3. size()
4. add(newPosition, newItem)
5. remove(index)
6. removeAll( )
7. get(index)



### Interface

```java
public interface ListInterface {
  // 위 operations를 그대로
  // createList는 object생성 문법으로 대체
		public boolean isEmpty( );
		public int size( );
		public void add(int index, Object item)
			throws ListIndexOutOfBoundsException,
				ListException;
		public Object get(int index)
			throws ListIndexOutOfBoundsException;
		public void remove(int index)
			throws ListIndexOutOfBoundsException;
		public void removeAll( );
}
```



### Implementation

```java
public class ListArrayBased implements ListInterface {
	private final int MAX_LIST = 50;
	private Object items[ ];   // array of list items[1…MAX_LIST]
	private int numItems;      // # of items in the list
  
  // Constructor
	public ListArrayBased( ) {
		items = new Object[MAX_LIST+1];
		numItems = 0;
	}
  
  // 각 Operation 구현
	public boolean isEmpty( ) {
			return (numItems == 0);
	}
	public int size( ) {
			return numItems;
	}
	public void removeAll( ) {
		items = new Object[MAX_LIST+1];
		numItems = 0;
	}
	public void add(int index, Object item)
			throws ListIndexOutOfBoundsException {
		if (numItems > MAX_LIST) {
			Exception 처리;
		}
		if (index >= 1 && index <= numItems+1) { // shift right
			for (int pos = numItems; pos >= index; pos--) {
				items[pos+1] = items[pos];
			}
			items[index] = item;
			numItems++;
		} else {
			Exception 처리;
		}
	}
  	public Object get(int index)
			throws ListIndexOutOfBoundsException {
		if (index >= 1 && index <= numItems) { 
			return items[index];
		} else { // index out of range
			Exception handling;
		}
	}
	public void remove(int index)
			 throws ListIndexOutOfBoundsException {
		if (index >= 1 && index <= numItems) { // shift left
			for (int pos = index+1; pos <= size( ); pos++) {
				items[pos-1] = items[pos];
			}
			numItems--;
		} else { // index out of range
			Exception handling;
		}
	}
} // end class ListArrayBased
```



- `add`를 좀더 자세히 살펴볼까?

  ```java
  public void add(int index, Object item)
    throws ListIndexOutOfBoundsException {
    // max보다 큰 게 들어오면 에러
    if (numItems > MAX_LIST) {
      Exception 처리;
    }
    
    // 1~max 사이 들어오면 
    if (index >= 1 && index <= numItems+1) {
      // 끝에서부터 들어온 index까지 한 칸씩 shift to right
      for (int pos = numItems; pos >= index; pos--) {
        items[pos+1] = items[pos];
      }
      // 이제 비워진 자리에 넣는다
      items[index] = item;
      // 개수 update
      numItems++;
      
    // 1보다 작은 게 들어오면 에러
    } else {
      Exception 처리;
    }
  }
  ```

- `remove`를 좀더 자세히 살펴볼까?

  ```java
  public void remove(int index)
    throws ListIndexOutOfBoundsException {
    
    // 1~numItems 사이가 들어오면
    if (index >= 1 && index <= numItems) {
      // index(지울 애)의 옆자리부터 마지막까지 shift to left
      for (int pos = index+1; pos <= size( ); pos++) {
        items[pos-1] = items[pos];
      }
      // 개수 update
      numItems--;
    } 
   
    // index out of range
    else { 
      Exception handling;
    }
  }
  ```

  ​