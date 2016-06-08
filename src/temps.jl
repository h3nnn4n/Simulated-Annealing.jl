function linear(t_0, t_n, i, n)
    return t_0 - i * (t_0 - t_n)/n
end

ln(x) = log(e, x)

function logaritmic(t_0, t_n, i, n)
    return t_0 - i ^ ( ln(t_0 - t_n) / ln(n) )
end

