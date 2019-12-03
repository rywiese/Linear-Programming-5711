function [minimizer, xs_new] = Gradient_Descent_R2_R1_Exact(f, x, df_dx1, df_dx2, epsilon, xs)
    
    J = [df_dx1(x); df_dx2(x)];

    if norm(J) < epsilon
        minimizer = x;
        xs_new = xs;
        return;
    end

    d = - J;

    a = Backtracking_Line_Search(f, x, d, J, .5, .5);

    x_new = x + a * d;
    xs_new = [xs, x_new];
    [minimizer, xs_new] = Gradient_Descent_R2_R1_Exact(f, x_new, df_dx1, df_dx2, epsilon, xs_new);

end