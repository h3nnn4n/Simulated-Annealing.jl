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
    t_0      = 100.0
    t_n      = 0.0
    iter     = 0
    temp     = hyperbolic_cos
    acceptf  = accept_default
    x        = []
    y        = []
    ytemp    = []
    yprob    = []
    plotInt  = 10^3
    canDraw  = false
    progress = false
    scale    = 25.0

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
                push!(x    , iter          )
                push!(y    , t             )
                push!(ytemp, T             )
                push!(yprob, acceptf(Δc, T, t_0))
            end
            if progress
                println("$(100.0*iter/maxIter) \t $(t) \t $T \t $Δc \t $(acceptf(Δc, T, t_0))")
            end
        end

        if t == 0
            break
        end

        if Δc < 0.0
            s_i = s_new
        elseif acceptf(Δc * scale, T, t_0) > p
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
        draw(PNG("out_prob.png", 800px, 600px),
            plot(x = x, y = yprob, Geom.line,
            Theme(background_color=colorant"white"),
            Guide.xlabel("Time"),
            Guide.ylabel("Probability"),
            Guide.title("Simulated Annealing for 3cnf-sat"))
            )
    end
    return iter < maxIter ? (toq(), iter, true) : (toq(), iter, false)
end
