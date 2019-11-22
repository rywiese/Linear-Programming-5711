% Takes as input a function g, a left bound l, a right bound r,
% and an error bound epsilon
%
% Assume epsilon > 0, g(l) < 0, g(r) > 0
%
% Returns solution with |g(solution)| <= epsilon
%
% This is a helper funciton, only to be used in Bisection_Search
function [solution] = Bisection_Search_Pos(g, l, r, epsilon)

    % Base case
    m = (l + r) / 2;
    if abs(g(m)) <= epsilon
        solution = m;
        return;
    end

    % Solution to the left of m
    if g(m) > 0
        solution = Bisection_Search(g, l, m, epsilon);
        return;
    end

    % Solution to the right of m
    if g(m) < 0
        solution = Bisection_Search(g, m, r, epsilon);
        return;
    end

end