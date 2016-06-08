function evaluate(vars, formula)
    vals = []
    for clausule in formula
        a, b, c = clausule[1], clausule[2], clausule[3]

        x1 = a > 0 ? vars[a] : !vars[-a]
        x2 = b > 0 ? vars[b] : !vars[-b]
        x3 = c > 0 ? vars[c] : !vars[-c]

        v = x1 || x2 || x3

        push!(vals, v)
    end

    return vals
end

function energy(vars, formula)
    q = length(filter( x -> x, evaluate(vars, formula)))
    p = length(formula)

    return 1.0 - q/p
end

function neighbour(vars)
    nv    = copy(vars)
    p       = rand(1:length(vars))
    nv[p] = !nv[p]
    return nv
end
