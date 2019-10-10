function [solution, value] = oldSimplex(A, b, c)
    
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
    
    % Look through valid bases to find a BFS
    Bases = Basis_Matrix(m, n);
    [num_bases, ~] = size(Bases);
    for i = 1:num_bases

        B = transpose(Bases(i,:));
        N = ones([n, 1]) - B;

        % Test if B is a valid basis
        if det(A(:,B==1)) ~= 0
            
            % Compute x
            x = zeros(n, 1);
            x(B==1) = A(:,B==1)^(-1) * b;
            
            % Test if BFS
            if x >= 0

                % Call the actual algorithm with the starting basis
                [B_star, N_star] = Simplex_Helper(A, b, c, B, N);
                
                % Compute solution
                solution = zeros(n, 1);
                solution(B_star==1) = A(:,B_star==1)^(-1) * b;

                % Compute value
                value = transpose(c) * solution;

                return
            end
        end
    end
end