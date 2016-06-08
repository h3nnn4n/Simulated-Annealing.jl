using Gadfly

include("readFile.jl")
include("cnf.jl")
include("temps.jl")

function main(name)
    tic()
    size     = readSize(name)
    formula  = readFormula(name)
    s_i      = map( x -> x == 1, rand(0:1,size))
    maxIter  = 5 * 10^5
    t_0      = 220.0
    t_n      = 0.0
    iter     = 0
    temp     = linear
    x        = []
    y        = []
    ytemp    = []
    plotInt  = 10^3
    canDraw  = false
    progress = false

    while iter < maxIter
        T     = temp(t_0, t_n, iter, maxIter)
        iter += 1
        s_new = neighbour(s_i)
        t     = energy(s_i  , formula)
        t_new = energy(s_new, formula)
        p     = rand()
        Δc    = t_new - t

        if iter % plotInt == 0 || t == 0
            if canDraw
                push!(x    , iter)
                push!(y    , t   )
                push!(ytemp, T   )
            end
            if progress
                println("$iter \t $t")
            end
        end

        if t == 0
            break
        end

        if Δc < 0.0
            s_i = s_new
        elseif exp( -Δc / T ) < p
            s_i = s_new
        end
    end

    if canDraw
        draw(PNG("out_obj.png", 800px, 600px),
            plot(x = x, y = y, Geom.line,
            Theme(background_color=colorant"white"),
            Guide.xlabel("Time"),
            Guide.ylabel("Objetive function"),
            Guide.title("Simulated Annealing for 3cnf-sat"))
            )
        draw(PNG("out_temp.png", 800px, 600px),
            plot(x = x, y = ytemp, Geom.line,
            Theme(background_color=colorant"white"),
            Guide.xlabel("Time"),
            Guide.ylabel("Temperature"),
            Guide.title("Simulated Annealing for 3cnf-sat"))
            )
    end
    return iter < maxIter ? (toq(), iter, true) : (toq(), iter, false)
end
