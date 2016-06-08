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
