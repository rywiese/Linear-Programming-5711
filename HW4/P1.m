%HW 4 Problem 1
clc;

c = [2; 3.5; 8; 1.5];
b = [25; 40; 400];
A = [4 6 20 1; 8 12 0 30; 130 120 150 70];

cvx_begin
    variables x(4);
    minimize transpose(c) * x
    subject to
        A*x == b
        x >= 0
cvx_end

cvx_begin
    variables y(3);
    maximize transpose(b) * y
    subject to
        transpose(A) * y <= c
cvx_end