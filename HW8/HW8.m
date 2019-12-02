clc; clear;

minimizer = Gradient_Descent_R2_R1_Exact(@f, [0; 0], @df_dx1, @df_dx2, .00001);

"Problem 1 using exact line search"
minimizer
f(minimizer)

function [y] = f(x)
    y = exp(1 - x(1) - x(2)) + exp(x(1) + x(2) - 1) + x(1)^2 + x(1) * x(2) + x(2)^2 + 2 * x(1) - 3 * x(2);
end

function [y] = df_dx1(x)
    y = - exp(1 - x(1) - x(2)) + exp(x(1) + x(2) - 1) + 2 * x(1) + x(2) + 2;
end

function [y] = df_dx2(x)
    y = - exp(1 - x(1) - x(2)) + exp(x(1) + x(2) - 1) + x(1) + 2 * x(2);
end