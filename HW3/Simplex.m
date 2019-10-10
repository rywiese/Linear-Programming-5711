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
    A_hat = zeros(m, n+m);
    A_hat(:, 1:n) = A;
    A_hat(:, n+1:n+m) = eye(m);
    
    b_hat = b;
    for i = 1:m
        if b_hat(i) < 0
            b(i) = - 1 * b(i);
            A(i,:) = - 1 * A(i,:);
        end
    end

    c_hat = zeros(n+m, 1);
    c_hat(n+1:n+m) = ones(m, 1);

    B_hat = zeros(n+m, 1);
    B_hat(n+1:n+m) = ones(m, 1);
    N_hat = ones(n+m, 1) - B_hat;

    [B, N] = Simplex_Helper(A_hat, b_hat, c_hat, B_hat, N_hat);
    x_hat = zeros(n+m, 1);
    x_hat(B==1) = A_hat(:,B==1)^(-1) * b_hat;
    y = transpose(c_hat) * x_hat;

    % Phase 2
    [B_star, N_star] = Simplex_Helper(A, b, c, B, N);
                
    % Compute solution
    solution = zeros(n, 1);
    solution(B_star==1) = A(:,B_star==1)^(-1) * b;

    % Compute value
    value = transpose(c) * solution;

end