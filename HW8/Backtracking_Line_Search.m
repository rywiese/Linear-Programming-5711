function [a] = Backtracking_Line_Search(f, x, d, df_dx1, df_dx2, alph, bet)
    function Backtracking_Line_Search_Helper(t)
        if f(x + t * d) <= f(x) + alph * t * [df_dx1(x), df_dx2(x)] * d
            a = t;
        else
            Backtracking_Line_Search_Helper(bet * t);
        end
    end
    Backtracking_Line_Search_Helper(1);
end