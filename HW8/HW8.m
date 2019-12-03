clc; clear;

% Problem 1i

"Problem 1 using exact line search"
[minimizer, xs] = Gradient_Descent_R2_R1_Exact(@f, [0; 0], @df_dx1, @df_dx2, .00001, [[0; 0]]);
minimizer
f(minimizer)
[~, n] = size(xs);
%plot(xs(1,:), xs(2,:))

% Problem 1ii

"Problem 1 using backtracking line search"
[minimizer, xs] = Gradient_Descent_R2_R1_Backtrack(@f, [0; 0], @df_dx1, @df_dx2, .00001, [[0; 0]]);
minimizer
f(minimizer)
[~, n] = size(xs);
%plot(xs(1,:), xs(2,:))

% Problem 2

"Problem 2 using Newton's method"
[minimizer, xs] = Newtons_Method(@f, [0; 0], @df_dx1, @df_dx2, @df2_dx12, @df2_dx12, @df2_dx1x2, .00001, [[0; 0]]);
minimizer
f(minimizer)
[~, n] = size(xs);
%plot(xs(1,:), xs(2,:))

% Problem 3

"Problem 3 using gradient projection"
A = [1, 2, 3];
[minimizer, xs] = Gradient_Projection(@g, A, [4; 0; 0], @dg_dx1, @dg_dx2, @dg_dx3, .00001, [[4; 0; 0]]);
minimizer
f(minimizer)
[~, n] = size(xs);
%plot(xs(1,:), xs(2,:))


"Problem 3 using CVX"
cvx_begin
    variables x(3);
    minimize exp(x(1) + x(2) + x(3)) + x(1)^2 + 2 * x(2)^2 + 3 * x(3)^2 - 2 * x(1) - 7 * x(2) - 5 * x(3)
    subject to
        A * x == 4
cvx_end
x
exp(x(1) + x(2) + x(3)) + x(1)^2 + 2 * x(2)^2 + 3 * x(3)^2 - 2 * x(1) - 7 * x(2) - 5 * x(3)

% f
function [y] = f(x)
    y = exp(1 - x(1) - x(2)) + exp(x(1) + x(2) - 1) + x(1)^2 + x(1) * x(2) + x(2)^2 + 2 * x(1) - 3 * x(2);
end

% First order derivatives
function [y] = df_dx1(x)
    y = - exp(1 - x(1) - x(2)) + exp(x(1) + x(2) - 1) + 2 * x(1) + x(2) + 2;
end

function [y] = df_dx2(x)
    y = - exp(1 - x(1) - x(2)) + exp(x(1) + x(2) - 1) + x(1) + 2 * x(2) - 3;
end

% Second order derivatives
function [y] = df2_dx12(x)
    y = exp(1 - x(1) - x(2)) + exp(x(1) + x(2) - 1) + 2;
end

function [y] = df2_dx1x2(x)
    y = exp(1 - x(1) - x(2)) + exp(x(1) + x(2) - 1) + 1;
end

% g (for problem 3)
function [y] = g(x)
    y = exp(x(1) + x(2) + x(3)) + x(1)^2 + 2 * x(2)^2 + 3 * x(3)^2 - 2 * x(1) - 7 * x(2) - 5 * x(3);
end

% First order derivatives
function [y] = dg_dx1(x)
    y = exp(x(1) + x(2) + x(3)) + 2 * x(1) - 2;
end

function [y] = dg_dx2(x)
    y = exp(x(1) + x(2) + x(3)) + 4 * x(2) - 7;
end

function [y] = dg_dx3(x)
    y = exp(x(1) + x(2) + x(3)) + 6 * x(3) - 5;
end