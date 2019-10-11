% Takes as input an LP = (A, b, c) and the basis B
%
% Returns a new basis B* such that B* is the basis for the optimal BFS
%
% Only to be used as a helper function for the full simplex algorithm
function [B_star] = Simplex_Helper(A, b, c, B)
    
    % Get m and n
    [m, n] = size(A);
    
    % Compute x
    x = zeros(n, 1);
    x(B==1) = A(:,B==1)^(-1) * b;

    % Compute N
    N = ones(n, 1) - B;

    % Compute c_hat
    % c_hat^T = transpose(c) - transpose(c(B==1)) * A(:,B==1)^(-1) * A;
    c_hat = c - transpose(A(:,B==1)^(-1) * A) * c(B==1);

    % Stopping condition
    if c_hat >= -0.000001
        B_star = B;
        return
    end

    % Choose j using smallest index rule
    for k = 1:n
        if N(k) == 1
            if c_hat(k) < 0
                j = k;
                break;
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

    % Choose i using smallest index rule
    theta = inf;
    for k = 1:n
        if B(k) == 1 & d(k) < 0
            if -1 * x(k) / d(k) < theta
                theta = -1 * x(k) / d(k);
                i = k;
            end
        end
    end

    % Recursively solve problem with new basis
    B_hat = B;
    B_hat(i) = 0;
    B_hat(j) = 1;

    [B_star] = Simplex_Helper(A, b, c, B_hat);
end