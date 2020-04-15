include("./functions.jl")

using .Functions

# Dana funkcja, x - argument
function f(x)
    return sin(x) - (x/2)^2
end

# Pochodna funkcji f
function pf(x)
    return cos(x) - (x/2)
end


# podpunkt pierwszy
println(mbisekcji(f, 1.5, 2.0, 0.000005, 0.000005))

# podpunkt drugi
println(mstycznych(f, pf, 1.5, 0.000005, 0.000005, 32))

# podpunkt trzeci
println(msiecznych(f, 1.0, 2.0, 0.000005, 0.000005, 32))
