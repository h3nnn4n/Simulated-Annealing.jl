function readFormula(name)
    f = open(name)
    lines = readlines(f)

    formula = []

    for i in lines
        if i[1] == 'c' || i[1] == 'p'

        else
            j = split(i, " ")

            if j[1] == "%\n"
                break
            end

            if j[1] == ""
                push!(formula, (parse(Int, j[2]), parse(Int, j[3]), parse(Int, j[4])))
            else
                push!(formula, (parse(Int, j[1]), parse(Int, j[2]), parse(Int, j[3])))
            end
        end
    end

    return formula
end

function readSize(name)
    f = open(name)
    lines = readlines(f)
    for i in lines
        if i[1] == 'p'
            j = split(i, " ")
            return(parse(Int, j[3]))
        end
    end
    return -1
end

