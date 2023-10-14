! Given n1=3000, n2=1000, if you compile with 
! ifort -o run_win.exe main_test_mask.f90
! and then run, you get a STACK OVERFLOW
! There are TWO WAYS to eliminate this problem, without changing the code
! (i.e. keep on using temporary arrays and array functions like pack,any, etc.)
! (1) HEAP ARRAYS
! ifort -o run_win.exe main_test_mask.f90 /heap-arrays0
! (2) INCREASE SIZE OF THE STACK
! ifort -o run_win.exe main_test_mask.f90 -link -stack:2147483647
! Both works on Windows, which is best for performance? 
! Probably (2)
    
program main_test_mask
    implicit none
    real(8), allocatable :: cons(:,:), A(:)
    integer, parameter :: n1=3000, n2=1000
    integer :: n_true
    
    write(*,*) "Test logical indexing in Fortran..."
    
    
    allocate(cons(n1,n2))
    call random_number(cons)
    cons = cons-0.5d0
    ! IMPORTANT: while cons is (n1,n2), A is a 1-DIM allocatable array
    ! with n_true<=n1*n2 elements
    
    write(*,*) "Before count"
    n_true = count(cons>0d0)
    
    write(*,*) "Before pack"
    A = pack(cons,cons>0d0)
    
    write(*,*) "Before shape"
    write(*,*) "Shape of cons = ", shape(cons)
    write(*,*) "n_true        = ", n_true
    write(*,*) "Shape of A    = ", shape(A)
    
end program main_test_mask
    