%HW 6 Problem 2

cvx_begin
    variables x y z;
    minimize x * x + .5 * y * y + (x + .5 * y) * (x + .5 * y) + (z + .5 * y) * (z + .5 * y) - 6 * x - 7 * y - 8 * z - 9
cvx_end
