function [minimizer, xs_new] = Gradient_Projection(f, A, x, df_dx1, df_dx2, df_dx3, epsilon, xs)

    J = [df_dx1(x); df_dx2(x); df_dx3(x)];
    P = eye(3) - transpose(A) * (A * transpose(A))^(-1) * A;

    if norm(P * J) < epsilon
        minimizer = x;
        xs_new = xs;
        return;
    end

    d = (- 1 * P * J);

    a = Backtracking_Line_Search(f, x, d, J, .5, .5);

    x_new = x + a * d;
    xs_new = [xs, x_new];
    [minimizer, xs_new] = Gradient_Projection(f, A, x_new, df_dx1, df_dx2, df_dx3, epsilon, xs_new);

end