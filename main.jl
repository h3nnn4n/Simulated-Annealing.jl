include("readFile.jl")
include("cnf.jl")

function main(name)
    size    = readSize(name)
    formula = readFormula(name)
    s_i     = map( x -> x == 1, rand(0:1,size))
    maxIter = 5 * 10^5
    T       = 20.0
    iter    = 0

    while iter < maxIter
        iter += 1
        s_new = neighbour(s_i)
        t     = temp(s_i  , formula)
        t_new = temp(s_new, formula)
        p     = rand()
        Δc    = t_new - t

        if Δc < 0.0
            s_i = s_new
        elseif exp( -Δc / T ) < p
            s_i = s_new
        end

        if iter % 10^3 == 0
            println(i, "\t", temp(s_i, formula))
        end

        if t == 0
            break
        end
    end

    println("$(temp(s_i, formula)) $iter")
end
