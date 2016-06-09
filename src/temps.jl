function linear(t_0, t_n, i, n)
    return t_0 - i * (t_0 - t_n)/n
end

ln(x) = log(e, x)

function logaritmic(t_0, t_n, i, n)
    return t_0 - i ^ ( ln(t_0 - t_n) / ln(n) )
end

function hyperbolic_cos(t_0, t_n, i, n)
     return (t_0 - t_n) / cosh(6.0 * (i/n))
end

function accept_default(Δc, T, t_0)
    return exp( -Δc / T )
end
