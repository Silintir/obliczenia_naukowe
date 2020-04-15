# Program testuje funkcję rysujNnfx dla konkretnych przykładów

include("functions.jl")
using .Functions




x = [-1.0, 0.0, 1.0, 2.0]
fx = [-1.0, 0.0, -1.0, 2.0]
A = ilorazyRoznicowe(x,fx)
println(naturalna(x,A))

# x^3 -x^2 -x