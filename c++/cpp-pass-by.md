# Pointer vs Reference

```c++
// Pointer can be moved
int * ptr;
int var = 7;
int foo = 21;
ptr = &var;
ptr = &foo;

// Reference 
int & ref = var;
```

- **Pointer** has freedom to move around and point to different variables
- **Reference**, once assigned, just becomes a reference to that location in memory

![](/Users/mac/Desktop/dev/TIL/c++/Screen%20Shot%202018-11-23%20at%209.53.25%20AM.png)



# Pass By Value/Reference/Pointer

> https://www.youtube.com/watch?v=UWYnUGnChhA

```c++
void passByVal(int val);
void passByRef(int & ref);
void passByPtr(int * ptr);

int main() {
    return 0;
}

void passByVal(int val) {
    val = 10;
    printf("val = %i\n", val);
}
void passByRef(int & ref) {
    ref = 20;
    printf("ref = %i\n", ref);
}
void passByPtr(int * ptr) {
    *ptr = 30;
    printf("*ptr = %i\n", *ptr); // ptr하면 주소를 출력
}
```



### [1] Pass By Value vs Pass by Reference

```c++
int main() {
    int x = 5;
    printf("x = %i\n", x); 	// x = 5
    
    passByVal(x); 			// val = 10
    printf("x = %i\n", x); 	// x = 5
    
    passByRef(x);			// ref = 20
    printf("x = %i\n", x);	// x = 20
}
```

- Pass By Value : `val`은 단순 copy of `x`
- Pass By Refer : `ref`는 `x`를 부르는 또다른 이름



### [2] Pass By Pointer

```c++
int main() {
    int x = 5;
    int * xptr = &x;
    printf("x = %i\n", x);			// x = 5
    printf("*xptr = %i\n", *xptr);	// *xptr = 5
    
    passByPtr(xptr);				// *ptr = 30
    printf("x = %i\n", x);			// x = 30
    printf("*xptr = %i\n", *xptr);	// *xptr = 30
}
```

- **Pass By Pointer** : `ptr`은 `x`의 주소를 저장



# Pass By Pointer vs Pointer Reference

> https://www.youtube.com/watch?v=7HmCb343xR8

```c++
#include <iostream>
#include <cstdlib>
using namespace std;

int box1 = 1;
int box2 = 2;
int * gptr;

void passByPtr(int * ptr) {
    *ptr = 3;
    ptr = gptr;
    *ptr = 4;
}
void passByPtrRef(int * & ptrRef) {
    *ptrRef = 5;
    ptrRef = gptr;
    *ptrRef = 6;
}

int main(int argc, char * argv[]) {
    int * p = &box1;
    gptr = &box2;
    
    cout << "\n_______Current conditions________\n";
    
    if (p == &box1)
        cout << "p is pointing to box1\n";			// this
    else if (p == &box2)
        cout << "p is pointing to box2\n";
    else
        cout << "p is pointing to another box\n";
    
    if (gptr == &box1)
        cout << "gptr is pointing to box1\n";
    else if (gptr == &box2)
        cout << "gptr is pointing to box2\n";		// this
    else
        cout << "gptr is pointing to another box\n";
    
    cout << "box1 contains the value: " << box1 << endl; // 1
    cout << "box2 contains the value: " << box2 << endl; // 2
    
    return 0;
}
```



### [1] Pass by Pointer

```c++
passByPtr(p);
```

- `p` is pointing to `box2`
- `gptr` is pointing to `box2`
- `box1` contains the value `3`
- `box2` contains the value `4`



### [2] Pass by Pointer Reference

```c++
passByPtrRef(p);
```

- `p` is pointing to `box2`
- `gptr` is pointing to `box2`
- `box1` contains the value `5`
- `box2` contains the value `6`



![](/Users/mac/Desktop/dev/TIL/c++/screenshot.png)





# Double Pointer (Pointer to a Pointer)

> https://www.youtube.com/watch?v=ZMDYsr9scGo

```c++
#include <iostream>
#include <cstdlib>
using namespace std;

int main() {
    int box = 5;
    int * ptr = &box;	// pointer
    int ** dPtr = &ptr;	// pointer to a pointer
    
    cout << "box holds: " << box << endl;		// 5
    cout << "box lives at: " << &box << endl;	// 0xA
    
    cout << "ptr points to address: " << ptr << endl; // 0xA
    cout << "thing that ptr points to has value: " << *ptr; // 5
    cout << "ptr lives at: " << &ptr << endl; // 0xB
    
    cout << "dPtr points to: " << dPtr << endl; // 0xB
    cout << "thing that dPtr points to has value: " << *dPtr; // 0xA
    cout << "ptr that dPtr points to points to value: " << **dPtr; // 5
    cout << "dPtr lives at: " << &dPtr; // 0xC
}
```

| Thing:     | `dPtr` | `ptr` | `box` |
| ---------- | ------ | ----- | ----- |
| Values:    | 0xB    | 0xA   | 5     |
| Addresses: | 0xC    | 0xB   | 0xA   |

