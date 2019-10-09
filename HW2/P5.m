%HW 2 Problem 5

A = [-1   1;
      1,  1;
     -1, -1;
      1, -1]

b = [6; 18; -1; 7]

cvx_begin
    variables c(2, 1) r d(4, 1);
    maximize r
    subject to
        A * c <= b
        0 <= c
        c <= [11; 10]
        0 <= r
        r <= d
        for i=1:4
            d(i) <= (1 / sqrt(2)) * (b(i) - (A(i, :) * c));
        end
cvx_end

c
d