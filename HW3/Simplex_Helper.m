function [solution, value] = Simplex_Helper(A, b, c, B, N)
    
    % Get m and n
    [m, n] = size(A);
    
    % Compute x
    x = zeros(n, 1);
    x(B==1) = A(:,B==1)^(-1) * b;

    % Compute c_hat
    % c_hat^T = transpose(c) - transpose(c(B==1)) * A(:,B==1)^(-1) * A;
    c_hat = c - transpose(A(:,B==1)^(-1) * A) * c(B==1);

    % Stopping condition
    if(c_hat >= 0)
        solution = x;
        value = transpose(c) * x;
        return
    end

    % Choose j
    %[~,I] = min(c_hat(N==1));
    %j = I(1);
    smallest = inf;
    j = -1;
    for k = 1:n
        if N(k) == 1
            if c_hat(k) < smallest
                smallest = c_hat(k);
                j = k;
            end
        end
    end


    % Compute d
    d = zeros(n, 1);
    e = zeros(n, 1);
    e(j) = 1;
    d(N==1) = e(N==1);
    d(B==1) = -1 * (A(:,B==1))^(-1) * A(:,N==1) * e(N==1);

    % Check for unboundedness
    if(d >= 0)
        error("Problem is unbounded")
    end

    % Choose i
    smallest = inf;
    i = -1;
    for k = 1:n
        if B(k) == 1 & d(k) < 0
            if -1 * x(k) / d(k) < smallest
                smallest = -1 * x(k) / d(k);
                i = k;
            end
        end
    end

    % Recursively solve problem with new basis
    B_hat = B;
    B_hat(i) = 0;
    B_hat(j) = 1;

    N_hat = N;
    N_hat(j) = 0;
    N_hat(i) = 1;

    [solution, value] = Simplex_Helper(A, b, c, B_hat, N_hat);
end