function [minimizer, xs_new] = Newtons_Method(f, x, df_dx1, df_dx2, df2_dx12, df2_dx22, df2_dx1x2, epsilon, xs)

    J = [df_dx1(x); df_dx2(x)];
    H = [df2_dx12(x), df2_dx1x2(x); df2_dx1x2(x), df2_dx22(x)];

    if norm(J) < epsilon
        minimizer = x;
        xs_new = xs;
        return;
    end

    d = - (H * H)^(-1) * J;

    a = Backtracking_Line_Search(f, x, d, J, .5, .5);

    x_new = x + a * d;
    xs_new = [xs, x_new];
    [minimizer, xs_new] = Newtons_Method(f, x_new, df_dx1, df_dx2, df2_dx12, df2_dx22, df2_dx1x2, epsilon, xs_new);

end