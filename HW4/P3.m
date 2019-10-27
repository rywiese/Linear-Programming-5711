%HW 4 Problem 1
clc;

w = [
    0 8 7 0;
    0 0 2 4;
    0 0 0 12;
    0 0 0 0;
];

cvx_begin
    variables v x([4,4])
    maximize v
    subject to
        x(1,2) == x(2,3) + x(2,4)
        x(1,3) + x(2,3) == x(3,4)
        x(1,2) + x(1,3) == v
        x(2,4) + x(3,4) == v
        x >= 0
        x <= w
cvx_end

cvx_begin
    variables z([4,4]) y(4)
    minimize w(1,2) * z(1,2) + w(1,3) * z(1,3) + w(2,3) * z(2,3) + w(2,4) * z(2,4) + w(3,4) * z(3,4)
    subject to
        z(1,2) >= y(1) - y(2)
        z(1,3) >= y(1) - y(3)
        z(2,3) >= y(2) - y(3)
        z(2,4) >= y(2) - y(4)
        z(3,4) >= y(3) - y(4)
        y(1) - y(4) == 1
        z >= 0
cvx_end