using Plots
using SymPy

# T - typ (float32/float64)
function iterate(T) # generowanie listy wyników równania zwykłej rekurencji
    P = ones(T, 40) # wypełnienie listy o długości 40 jedynkami
    p = T(0.01) # p0
    r = 3

    for i in 1:40
        p = p + r * p * (T(1.0)- p)
        P[i] = p
    end

    return P
end

function iterate_trunc(T) # generowanie listy wyników równania zmodyfikowane rekurencji
    P = ones(T, 40)
    p = T(0.01)
    r = 3

    for i in 1:40
        p = p + r * p * (T(1.0)- p)
        if(i == 10) # przy 10 iteracji ucięcie liczb znaczących
            p = trunc(p*1000)/1000
        end
        P[i] = p
    end

    return P
end


T = Float32

result = iterate(T)
result_trunc = iterate_trunc(T)


T = Float64

result64 = iterate(T)

# odkomentować w celu generacji wyików w formie tabeli latexa
# filetex = open("zad5textrunc.txt","w")
# for i in 1:length(result_trunc)
#     #println("$(result[i])\t $(result_trunc[i])")
#     write(filetex, "\$$(i)\$ & \$$(result[i])\$ & \$$(result_trunc[i])\$ \\\\ \n \\hline\n")
# end

# close(filetex)


# filetex64 = open("zad5tex64.txt","w")

# for i in 1:length(result)
#     #println("$(result[i])\t $(result64[i])")
#     write(filetex64, "\$$(i)\$ & \$$(result[i])\$ & \$$(result64[i])\$ \\\\ \n \\hline\n")
# end

#close(filetex64)

# generowanie wykresu
p = plot(1:40,result64, label="float64")
plot!(p,result_trunc, label="modified")
savefig(p,"comparition3.png")
