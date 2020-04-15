#Funkcja oblicza działąnie arytmetyczne krok po kroku, by zapobiec jakiemukolwiek wpływowi optymalizacji kompilatora bądź innej kolejności obliczeń

#Wejście: typ zmiennej (Float16, Float32 lub Float64)
#Wyjście: Epsilon maszynowy z dokładnością do wejściowego typu
function macheps_check(t)
    x::t = 4
    x = x/t(3.0)
    x = x-t(1.0)
    x = t(3.0)*x
    x = x-t(1.0)
    return x
end
