# Test-stack-heap-Fortran
Problem: sometimes when using ifort in Windows, you get a **stack overflow**.
Assuming that the code is correct, there are two possible ways of fixing this problem that I know of:

(1) Put all arrays on the heap (but the code may become slower)

(2) Increase the size of the stack
The program **main_test_mask.f90** provides a simple test of this issue

Given n1=3000, n2=1000, if you compile with 

ifort -o run_win.exe main_test_mask.f90

and then run, you get a STACK OVERFLOW
There are TWO WAYS to eliminate this problem, without changing the code
(i.e. keep on using temporary arrays and array functions like pack,any, etc.)

(1) HEAP ARRAYS

ifort -o run_win.exe main_test_mask.f90 /heap-arrays0

(2) INCREASE SIZE OF THE STACK

ifort -o run_win.exe main_test_mask.f90 -link -stack:2147483647

Both works on Windows, which is best for performance? 
Probably (2)
