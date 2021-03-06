using Distributions

f3_size = 0
deceptiveN_size = 0
deceptiveN_nbits = 0

function change_deceptiveN_size( nsize :: Int, nbits :: Int )
    global deceptiveN_size  = nsize
    global deceptiveN_nbits = nbits
end

function change_f3_size( nsize :: Int )
    global f3_size = nsize
end

function eval_f3( vet )
    if     reduce(&, true, vet .== [false, false, false])
        return 28
    elseif reduce(&, true, vet .== [false, false, true ])
        return 26
    elseif reduce(&, true, vet .== [false, true , false])
        return 22
    elseif reduce(&, true, vet .== [true , false, false])
        return 14
    elseif reduce(&, true, vet .== [true , true , true ])
        return 30
    else
        return 0
    end

    return 0
end

function objf_f3( ind )
    obj = 0
    gens = ind

    for i in 1:f3_size
        obj += eval_f3(gens[(i-1)*3+1:i*3])
    end

    return obj
end

function objf_f3s( ind )
    obj = 0
    gens = [x for x in ind]

    for i in 1:f3_size
        obj += eval_f3([gens[i], gens[i + 10], gens[i+20]])
    end

    return obj
end

function objf_deceptiveN( ind )
    obj = 0
    gens = [x for x in ind]

    for i in 1:deceptiveN_size
        v = sum(gens[(i-1) * deceptiveN_nbits + 1: i * deceptiveN_nbits])

        if v == 0
            obj += deceptiveN_nbits + 1
        else
            obj += v
        end
    end

    return obj
end

function objf_rosen( ind )
    d = length(ind)

    xi    = ind[1:d-1]
    xnext = ind[2:d]

    s = mapfoldr(x -> 100.0 * (x[2] - x[1]^2.0)^2.0 + (x[1] - 1.0)^2.0, +, collect(zip(xi, xnext)))

    return s
end

function objf_sphere( ind )
    obj = 0.0

    s = length(ind)

    for i in 1:s
        obj += ind[i] ^ 2.0
    end

    return obj
end

###

function evaluate(vars, formula)
    #=return objf_f3( vars )=#
    #=return objf_f3s( vars )=#
    #=return objf_deceptiveN( vars )=#
    #=return objf_sphere( vars )=#
    return objf_rosen( vars )
end

function energy(vars, formula)
    q = evaluate(vars, formula)
    p = 160


    return q

    #=return 1.0 - q/p=#
    #=return p - q=#
end

function neighbour(vars)
    nv    = copy(vars)
    p       = rand(1:length(vars))

    #=nv[p] = !nv[p]=#
    nv[p] += rand(Normal(0, .25))

    for i in 1:length(vars)
        nv[p] = clamp(nv[p], -5.12, 5.12)
    end

    return nv
end
















