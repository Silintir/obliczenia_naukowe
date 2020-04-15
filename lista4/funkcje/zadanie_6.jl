# Program testuje funkcję rysujNnfx dla konkretnych przykładów

include("functions.jl")
using .Functions

f(x) = abs(x)
g(x) = 1.0 / (1.0 + x^2)

rysujNnfx(f, -1.0, 1.0, 5, "1") 
rysujNnfx(f, -1.0, 1.0, 10, "2")
rysujNnfx(f, -1.0, 1.0, 15, "3")

rysujNnfx(g, -5.0, 5.0, 5, "4")
rysujNnfx(g, -5.0, 5.0, 10, "5")
rysujNnfx(g, -5.0, 5.0, 15, "6")