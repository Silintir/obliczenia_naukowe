include("./functions.jl")

using .Functions

e = Base.MathConstants.e

# Funkcja e^(1-x)-1, x - argument
function f1(x)
    return e^(1-x) - 1
end

# Funkcja xe^-x, x - argument
function f2(x)
    return x*e^(-x)
end

# Pochodna funkcji f1
function pf1(x)
    return -e^(1-x)
end

# Pochodna funkcji f2
function pf2(x)
    return -(x-1)*e^(-x)
end

# testy f1
println(mbisekcji(f1, 0.0, 1.5, 0.00001, 0.00001))
println(mbisekcji(f1, -2.0, 4.0, 0.00001, 0.00001))
println(mbisekcji(f1, 0.0, 1000.0, 0.00001, 0.00001))
println(mbisekcji(f1, -1000.0, 1000.0, 0.00001, 0.00001))

println(mstycznych(f1, pf1, -1.0, 0.00001, 0.00001, 100))
println(mstycznych(f1, pf1, 0.0, 0.00001, 0.00001, 100))
println(mstycznych(f1, pf1, 1.0, 0.00001, 0.00001, 100))
println(mstycznych(f1, pf1, 5.0, 0.00001, 0.00001, 100))
println(mstycznych(f1, pf1, 15.0, 0.00001, 0.00001, 100))

println(msiecznych(f1, -1.5, 2.0, 0.00001, 0.00001, 100))
println(msiecznych(f1, 0.0, 3.0, 0.00001, 0.00001, 100))
println(msiecznych(f1, -4.0, 4.0, 0.00001, 0.00001, 100))
println(msiecznych(f1, -5.0, 100.0, 0.00001, 0.00001, 100))

println("+++++++++++++++++++++++++++++++++++++++++++++++")
# # testy f2
println(mbisekcji(f2, -0.25, 0.5, 0.00001, 0.00001))
println(mbisekcji(f2, -1.0, 4.0, 0.00001, 0.00001))
println(mbisekcji(f2, -500.0, 500.0, 0.00001, 0.00001))
println(mbisekcji(f2, -10.0, 1000.0, 0.00001, 0.00001))

println(mstycznych(f2, pf2, -2.0, 0.00001, 0.00001, 100))
println(mstycznych(f2, pf2, 0.0, 0.00001, 0.00001, 100))
println(mstycznych(f2, pf2, 1.0, 0.00001, 0.00001, 100))
println(mstycznych(f2, pf2, 5.0, 0.00001, 0.00001, 100))
println(mstycznych(f2, pf2, 15.0, 0.00001, 0.00001, 100))

println(msiecznych(f2, -1.0, 1.0, 0.00001, 0.00001, 100))
println(msiecznych(f2, 0.25, 1.5, 0.00001, 0.00001, 100))
println(msiecznych(f2, -2.0, 5.0, 0.00001, 0.00001, 100))
println(msiecznych(f2, -5.0, 100.0, 0.00001, 0.00001, 100))

