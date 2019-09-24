%HW 1 Problem 4

C = [ 0, 10, 12, 17, 34;
     10,  0, 18,  8, 46;
     12, 18,  0,  9, 27;
     17,  8,  9,  0, 20;
     34, 46, 27, 20,  0];

P = [115, 385, 410, 480, 610];
N = [200, 500, 800, 200, 300];
b = N - P;

cvx_begin
    variables x(5, 5);
    minimize sum(dot(C, x))
    subject to
        sum(x(:, 1)) - sum(x(1, :)) >= b(1)
        sum(x(:, 2)) - sum(x(2, :)) >= b(2)
        sum(x(:, 3)) - sum(x(3, :)) >= b(3)
        sum(x(:, 4)) - sum(x(4, :)) >= b(4)
        sum(x(:, 5)) - sum(x(5, :)) >= b(5)
        x >= 0
cvx_end

for i = 1:5
    P(i) = P(i) + sum(x(:, i)) - sum(x(i, :));
end

x
P
