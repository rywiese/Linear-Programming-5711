% Takes as input an LP = (A, b, c)
%
% Returns the optimal solution and optimal value
%
% Returns an error string "None - problem infeasible"
% and an optimal value of Inf if the problem is infeasible
function [solution, value] = Simplex(A, b, c)
    
    % Get m and n
    [m, n] = size(A);

    % Error handling
    if m >= n
        error("m must be less than n")
    end
    if length(b) ~= m
        error("b must have length m")
    end
    if length(c) ~= n
        error("c must have length n")
    end
    
    % Phase 1

    % Initialize parameters for subproblem
    A_hat = zeros(m, n+m);
    A_hat(:, 1:n) = A;
    A_hat(:, n+1:n+m) = eye(m);
    
    b_hat = b;
    for i = 1:m
        if b_hat(i) < 0
            b_hat(i) = - 1 * b_hat(i);
            A_hat(i,:) = - 1 * A_hat(i,:);
        end
    end

    c_hat = zeros(n+m, 1);
    c_hat(n+1:n+m) = ones(m, 1);

    B_hat = zeros(n+m, 1);
    B_hat(n+1:n+m) = ones(m, 1);
    N_hat = ones(n+m, 1) - B_hat;

    % Solve subproblem
    [B_star] = Simplex_Helper(A_hat, b_hat, c_hat, B_hat);
    N_star = ones(n+m, 1) - B_star;
    
    % Obtain solution to subproblem
    x_hat = zeros(n+m, 1);
    x_hat(B_star==1) = A_hat(:,B_star==1)^(-1) * b_hat;
    
    % Test for feasibility
    if transpose(c_hat) * x_hat ~= 0
        solution = "None - problem infeasible";
        value = inf;
        return
    end

    B_star = B_star(1:n);
    N_star = ones(n, 1) - B_star;

    % Phase 2
    [B] = Simplex_Helper(A, b, c, B_star);
                
    % Compute solution
    solution = zeros(n, 1);
    solution(B==1) = A(:,B==1)^(-1) * b;

    % Compute value
    value = transpose(c) * solution;

end