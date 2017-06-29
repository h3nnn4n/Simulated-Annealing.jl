include("problems.jl")
include("temps.jl")

function main()
    tic()

    res = 32
    nbits = 4

    change_f3_size(res)
    change_deceptiveN_size(res, nbits)

    size           = res * nbits
    formula        = 0
    #=s_i            = map( x -> x == 1, rand(0:1, size))=#
    s_i            = (rand(Float64, 10) .* 10.0) .- 5.0
    maxIter        = 1 * 10^8
    t_0            = 20.0
    t_n            = 0.0
    iter           = 0
    temp           = hyperbolic_cos
    acceptf        = accept_default
    x              = []
    y              = []
    ytemp          = []
    progressInt    = 1 * 10^5
    progress       = true
    scale          = 1.0

    best           = 300
    bb             = s_i

    while iter < maxIter
        T     = temp(t_0, t_n, iter, maxIter)
        iter += 1
        s_new = neighbour(s_i)
        t     = energy(s_i  , formula)
        t_new = energy(s_new, formula)
        p     = rand()
        Δc    = t_new - t

        if iter == 0
            best = t
        end

        if t_new < best
            best = t_new
            bb = s_new
        end

        if progress && ( iter % progressInt == 0 )
            @printf("%10.2f %10.2f %10.2f %10.2f %10.2f %10.2f\n", 100.0*iter/maxIter, t, T, Δc, acceptf(Δc, T, t_0), best)
        end

        if Δc < 0.0
            s_i = s_new
        elseif acceptf(Δc * scale, T, t_0) > p
            s_i = s_new
        end
    end

    println(bb)
    println(best)

    #=return (toq(), solvedIter, solved, x, y)=#
end

main()
