function [M] = Basis_Matrix(m, n)
    
    % Base case
    if n < 1
        M = [];
        return
    end
    if m < 0 | m > n
        M = [];
        return
    end

    % Base case
    if m == 0
        M = zeros([1, n]);
        return
    elseif n == 1
        M = [m];
        return
    end

    % Recursive solution
    M1 = Basis_Matrix(m-1, n-1);
    M2 = Basis_Matrix(m, n-1);
    [m1, n1] = size(M1);
    [m2, n2] = size(M2);
    M = zeros([m1+m2,n]);
    M(1:m1,1) = ones([m1, 1]);
    M(1:m1,2:n) = M1(:,:);
    M(m1+1:m1+m2,1) = zeros([m2, 1]);
    M(m1+1:m1+m2,2:n) = M2;
    
end