function Test(m, n)

    if m >= n
        error("invalid arguments to Test(m, n) - m must be less than n")
    end

    A = rand([m, n]);
    b = rand([m, 1]);
    c = rand([n, 1]);

    cvx_begin
        variables x(n)
        minimize dot(c, x)
        subject to
            A * x == b
            x >= 0
    cvx_end
    while false && ~(0 <= sum(x) || sum(x) <= 0)
        A = rand([m, n]);
        b = rand([m, 1]);
        c = rand([n, 1]);
        cvx_begin
            variables x(n)
            minimize dot(c, x)
            subject to
                A * x == b
                x >= 0
        cvx_end
    end
    x

    [solution, value] = Simplex(A, b, c);

    "My simplex implementation:"
    solution
    value

end