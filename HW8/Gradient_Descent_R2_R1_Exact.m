function [minimizer] = Gradient_Descent_R2_R1_Exact(f, x, df_dx1, df_dx2, epsilon)

    if norm([df_dx1(x), df_dx2(x)]) < epsilon
        minimizer = x;
        return;
    end

    d = zeros([2, 1]);
    d(1) = -1 * df_dx1(x);
    d(2) = -1 * df_dx2(x);

    function [y] = Taylor(alph)
        y = f(x + alph * d);
    end
    a = Golden_Section_Search(@Taylor, 0, 1, epsilon);

    minimizer = Gradient_Descent_R2_R1_Exact(f, x + a * d, df_dx1, df_dx2, epsilon);

end