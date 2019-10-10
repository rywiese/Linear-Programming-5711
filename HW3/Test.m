% Randomly generates an LP with m and n
%
% Outputs the results from cvx as well as
% from my custom Simplex fuction
%
% Feel free to test with different values of m and n
%
% LP is randomly generated each time, so if a problem
% is infeasible, just run the same call to Test again
% (or a few more times) until you get meaningful output
function Test(m, n)

    % Error handling
    if m >= n
        error("invalid arguments to Test(m, n) - m must be less than n")
    end

    % Randomly generate LP
    A = rand([m, n]);
    b = rand([m, 1]);
    c = rand([n, 1]);

    % Solve LP using cvx and output results
    cvx_begin
        variables x(n)
        minimize dot(c, x)
        subject to
            A * x == b
            x >= 0
    cvx_end
    x

    % Solve LP using my function
    [solution, value] = Simplex(A, b, c);

    % Output results
    "My simplex implementation:"
    solution
    value

end