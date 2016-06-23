using Gadfly

include("readFile.jl")
include("cnf.jl")
include("temps.jl")

function main(name)
    tic()
    size           = readSize(name)
    formula        = readFormula(name)
    s_i            = map( x -> x == 1, rand(0:1,size))
    maxIter        = 5 * 10^5
    t_0            = 50.0
    t_n            = 0.0
    iter           = 0
    temp           = hyperbolic_cos
    acceptf        = accept_default
    x              = []
    y              = []
    ytemp          = []
    plotInt        = 1 * 10^4
    progressInt    = 5 * 10^3
    canDraw        = false
    progress       = false
    scale          = 50.0
    stopOnSolution = false
    solved         = false
    solvedIter     = 0
    while iter < maxIter
        T     = temp(t_0, t_n, iter, maxIter)
        iter += 1
        s_new = neighbour(s_i)
        t     = energy(s_i  , formula)
        t_new = energy(s_new, formula)
        p     = rand()
        Δc    = t_new - t

        if canDraw && ( iter % plotInt == 0 || t == 0 )
            push!(x    , iter          )
            push!(y    , t             )
            push!(ytemp, T             )
        end

        if progress && ( iter % progressInt == 0 )
            println("$(100.0*iter/maxIter) \t $(t) \t $T \t $Δc \t $(acceptf(Δc, T, t_0))")
        end

        if !solved
            solvedIter = iter
        end

        if t == 0
            if !solved
                solved = true
            end
            if stopOnSolution
                break
            end
        end

        if Δc < 0.0
            s_i = s_new
        elseif acceptf(Δc * scale, T, t_0) > p
            s_i = s_new
        end
    end

    if canDraw
        name  = @sprintf("out_obj_%s.png", splitext(basename(name))[1])
        draw(PNG("out_obj.png", 800px, 600px),
            plot(
                layer( x = x, y = y,
                    Geom.point, Geom.line,   Theme(default_color=colorant"orange")
                ),
                layer( x = x, y = y,
                    Geom.point, Geom.smooth, Theme(default_color=colorant"purple")
                ),
                Theme(background_color=colorant"white"),
                Guide.xlabel("Time"),
                Guide.ylabel("Objective Function"),
                Guide.title("Simulated Annealing for 3cnf-sat")
            )
        )
        name  = @sprintf("out_temp_%s.png", splitext(basename(name))[1])
        draw(PNG(name, 800px, 600px),
            plot(
                layer( x = x, y = ytemp,
                    Geom.point, Geom.line,   Theme(default_color=colorant"orange")
                ),
                layer( x = x, y = ytemp,
                    Geom.point, Geom.smooth, Theme(default_color=colorant"purple")
                ),
                Theme(background_color=colorant"white"),
                Guide.xlabel("Time"),
                Guide.ylabel("Temperature"),
                Guide.title("Simulated Annealing for 3cnf-sat")
            )
        )
    end

    return (toq(), solvedIter, solved)
end
