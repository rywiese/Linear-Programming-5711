%HW 1 Problem 5
T = 3; % number of time periods
K = 3; % number of investment vehicles
q = 1; % bank interest rate in percent

% external cash flow
p = [10, 4 ,8];

% unit income v{k}(t,s), k=1,...,K, t = 1,...,T, s = t,...,T
v = {};
v(1,:) = {[0.08 0.01 1.13;
0 0.02 1.1;
0 0 1.03]};
v(2,:) = {[0.06 0.03 1.07;
0 0.04 1.16;
0 0 1.04]};
v(3,:) = {[0.03 0.01 1.08;
0 0.08 1.01;
0 0.0 1.1]};

cvx_begin
    variables x(T, K) h(T);
    maximize sum(v{1}(1:T, T) .* x(1:T, 1) + v{2}(1:T, T) .* x(1:T, 2) + v{3}(1:T, T) .* x(1:T, 3)) + (1 + .01 * q) * h(T)
    subject to
        sum(x(1,:)) + h(1) == p(1)
        sum(x(2,:)) + h(2) - (sum(v{1}(1:1, 1) .* x(1:1, 1)) + sum(v{2}(1:1, 1) .* x(1:1, 2)) + sum(v{3}(1:1, 1) .* x(1:1, 3)) + (1 + .01 * q) * h(1)) == p(2)
        sum(x(3,:)) + h(3) - (sum(v{1}(1:2, 2) .* x(1:2, 1)) + sum(v{2}(1:2, 2) .* x(1:2, 2)) + sum(v{3}(1:2, 2) .* x(1:2, 3)) + (1 + .01 * q) * h(2)) == p(3)
        x >= 0
        h >= 0
cvx_end

x
h
