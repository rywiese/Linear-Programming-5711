function [minimizer] = Golden_Section_Search(f, xl, xr, epsilon)

    if (xr - xl) < epsilon
        minimizer = (xl + xr) / 2;
        return;
    end

    phi = (3 - sqrt(5)) / 2;
    xl_new = phi * xr + (1 - phi) * xl;
    xr_new = phi * xl + (1 - phi) * xr;

    if f(xl_new) < f(xr_new)
        minimizer = Golden_Section_Search(f, xl, xr_new, epsilon);
    else
        minimizer = Golden_Section_Search(f, xl_new, xr, epsilon);
    end
end