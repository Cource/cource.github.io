# Function Pointers in C
Theres no way that c supports lambda functions right? Well, it kinda does not, but there is this thing called function pointers.  

But how can something like that exist in c? Because c compiles down to assembly and assembly does not really distinguish between data and instructions, so, technically it is possible to just point to a line in assembly where the function starts. 🤯  

## The syntax:
> `char (*f)(int,bool)`

here:


**`char`** is the return type of the function it is pointing to, and

**`f`** is the function pointer's name

**`(int, bool)`**: the types of the parameters of the function

This function could be used just like how you would call a normal function now.

here is a simple example:
```c
int apply_function(int (*f)(int,int), int x, int, y){
  return f(x,y);
}

int add(int x, int y){
  return x+y;
}

int main(){
  printf("%d", apply_function(add, 1,2));
}
```
output: 3

---

Here is an insane map function i made with it
```c
// rather than returning a modified copy of the input, this modifies
// the input in place
void* map(void*(*f)(void*), void *xs, int len, int elem_size){
  for(int i=0; i<len; i++){
    void* elem = (char*) xs + i * elem_size;
    memcpy(elem, f(elem), elem_size);
  }
  return xs;
}

// you have to do some serious type gymnastics to make a
// mappable function
void* int_inc(void *x){
  int* x_ptr = (int*)x;
  *x_ptr = (*x_ptr)+1;
  return x;
}

int main(){
  int xs[] = {1,2,3,4};
  map(int_inc, (void*)&xs, 4, sizeof(int));
  int_array_print(xs, 4);
}
```