%HW 1 Problem 2

% generate instance
m = 20;
n = 40;
rng(0); %  seeds the random number generator using 0
A = randi([0,1],m,n);
b = A * [ones(m/2,1);zeros(n-m/2,1)];

e = ones([n 1])
cvx_begin
    variables x(n) y(n)
    minimize dot(e, y)
    subject to
        -1 * y <= x
        x <= y
        -1 <= x
        x <= 1
        A * x == b
cvx_end

x