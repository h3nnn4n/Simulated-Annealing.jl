include("main.jl")

function tester()
    n     = nworkers()
    out   = open("data.log", "w")
    cd("../instances")
    files = readdir()
    for file in files
        name = split(splitext(file)[1], '-')[1]
        if name == "uf20"
            print("$file \t")
            info = main(file)
            println(info)
            write(out, "$file $info\n")
            flush(out)
        end
    end
    cd("../src")
    close(out)
end

function tester_article()
    names = ["../instances/uf20-01.cnf",
             "../instances/uf50-01.cnf",
             "../instances/uf75-01.cnf",
             "../instances/uf100-01.cnf",
             "../instances/uf250-01.cnf"]

    out   = open("data.dat", "w")
    mmm = 10

    func = "hcos"

    for name in names
        println("$name")
        times   = 0
        iters   = 0
        solveds = 0
        xs      = []
        ys      = []
        for i in 1:mmm
            println("$i")
            time, iter, solved, x, y = main(name)
            times   += time
            iters   += iter
            solveds += solved
            if i == 1
                xs = copy(x)
                ys = copy(y)
            else
                for j in 1:length(xs)
                    xs[j] += x[j]
                    ys[j] += y[j]
                end
            end
        end

        write(out, "$name $(times/mmm) $(iters/mmm) $(solveds/mmm)\n")
        flush(out)

        name = @sprintf("out_%s_%s.dat", splitext(basename(name))[1], func)
        f    = open(name, "w")

        for j in 1:length(xs)
            write(f, "$(xs[j]/mmm) $(ys[j]/mmm)\n")
        end
        close(f)
    end

    close(out)
end
