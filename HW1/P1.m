%HW 1 Problem 1

c = [-7.8 -7.1 0 0];
b = [90 80];
A = [1/4, 1/3, 1, 0; 1/8, 1/3, 0, 1];

cvx_begin
    variables x(4);
    minimize c * x
    subject to
        A*x == transpose(b)
        x >= 0
cvx_end
