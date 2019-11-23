clear; clc;

cvx_begin
    variables a b c;
    minimize exp(a - b)
    subject to
        -10 <= a
        a <= 3
        exp(2*a - b/2) + exp(b/2 - c) <= 1
        a - b == 2 * c
cvx_end