#funcja właściwa zapisana dla wygody
function f3(x::Float64)
    return sin(x) + cos(3*x)
end

#Wejście: typ zmiennej (Float16, Float32 lub Float64)
#Wyjście: Epsilon maszynowy z dokładnością do wejściowego typu
function diriv()
    n::Int = 0
    h::Float64 = 0 # liczba h
    w::Float64 = 0 # przybliżona wartość pochodnej
    dir::Float64 = cos(1.0) - 3*sin(3.0)
    while n <= 54
        h = 2.0^(-n) 
        w = (f3(1.0 + h) - f3(1.0))/h
        println(n," pochodna: ",w)
        println(n," błąd: ", abs(dir - w))
        println(n," h+1 ", h+1)
        n = n+1
    end
end
