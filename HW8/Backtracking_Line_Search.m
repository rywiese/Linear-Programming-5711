function [a] = Backtracking_Line_Search(f, x, d, J, alph, bet)
    function Backtracking_Line_Search_Helper(t)
        if f(x + t * d) <= f(x) + alph * t * transpose(J) * d
            a = t;
        else
            Backtracking_Line_Search_Helper(bet * t);
        end
    end
    Backtracking_Line_Search_Helper(1);
end