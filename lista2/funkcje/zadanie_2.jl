using Plots
using SymPy

plotly() # Inicjalizacja sterownika web'owego
T = Float64

fun(x) = (T(T(exp(x))*(T(log(T(1) + T(exp(-x))))))) 

plt = plot(fun, -10, 1000,legend=false)
display(plt) 
