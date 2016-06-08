include("readFile.jl")
include("cnf.jl")
include("temps.jl")

function main(name)
    size    = readSize(name)
    formula = readFormula(name)
    s_i     = map( x -> x == 1, rand(0:1,size))
    maxIter = 5 * 10^5
    t_0     = 220.0
    t_n     = 0.0
    iter    = 0
    temp    = linear

    while iter < maxIter
        T     = temp(t_0, t_n, iter, maxIter)
        iter += 1
        s_new = neighbour(s_i)
        t     = energy(s_i  , formula)
        t_new = energy(s_new, formula)
        p     = rand()
        Δc    = t_new - t

        if t == 0
            break
        end

        if Δc < 0.0
            s_i = s_new
        elseif exp( -Δc / T ) < p
            s_i = s_new
        end

        if iter % 10^2 == 0
            println(i, "\t", energy(s_i, formula))
        end

    end

    println("$(energy(s_i, formula)) $iter")
end
