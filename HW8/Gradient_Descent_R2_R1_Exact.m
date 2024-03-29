function [minimizer, xs_new] = Gradient_Descent_R2_R1_Exact(f, x, df_dx1, df_dx2, epsilon, xs)
    
    J = [df_dx1(x); df_dx2(x)];

    if norm(J) < epsilon
        minimizer = x;
        xs_new = xs;
        return;
    end

    d = - J;

    function [y] = Taylor(alph)
        y = f(x + alph * d);
    end
    a = Golden_Section_Search(@Taylor, 0, 1, .001); % Using a smaller value of epsilon here gave me a memory error

    x_new = x + a * d;
    xs_new = [xs, x_new];
    [minimizer, xs_new] = Gradient_Descent_R2_R1_Exact(f, x_new, df_dx1, df_dx2, epsilon, xs_new);

end