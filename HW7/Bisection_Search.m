% Takes as input a function g, a left bound l, a right bound r,
% and an error bound epsilon
%
% Returns solution with |g(solution)| <= epsilon
function [solution] = Bisection_Search(g, l, r, epsilon)

    if (g(l) < 0) && (g(r) > 0)
        solution = Bisection_Search_Pos(g, l, r, epsilon);
    elseif (g(l) > 0) && (g(r) < 0)
        solution = Bisection_Search_Neg(g, l, r, epsilon);
    else
        error("IVT not applicable. g(l) and g(r) must have opposite signs.");
    end

end