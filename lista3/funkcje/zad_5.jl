include("./functions.jl")

using .Functions

e = Base.MathConstants.e

# Funkcja posiadająca zera w punktach przecięcia się funkcji 3x i e^x
function f(x)
    return e^x - 3x
end 

function test(f)

    println(mbisekcji(f, 0.5, 1.0, 0.0001, 0.0001))
    println(mbisekcji(f, 1.25, 1.75, 0.0001, 0.0001))
   
end

test(f)
