#Wejście: typ zmiennej (Float16, Float32 lub Float64)
#Wyjście: Epsilon maszynowy z dokładnością do wejściowego typu
function macheps(t)
    m::t = 1.0 # zmienna służąca nam do zapisywania postępu
    while t(1.0) + t(m/2) > t(1.0)
	m = m/2.0
    end
    return m #epsilon maszynowy
end

#Wejście: typ zmiennej (Float16, Float32 lub Float64)
#Wyjście: Liczba Eta z dokładnością do wejściowego typu
function etagen(t)
    i::t = 1.0 # zmienna po której bedziemy iterować by ostatecznie otrzymać z niej liczę eta
    while t(i/2) > t(0)
	i = i/2
    end
    return i #eta
end

#Wejście: typ zmiennej (Float16, Float32 lub Float64)
#Wyjście: Liczba MAX z dokładnością do wejściowego typu
function max_finder(t)
    max::t = 1 # liczba max, tóra będzie stopniowo zwiększana, aż do inf
    while !isinf(max*2) # możemy używać szbszej metody mnożenia, by dostać się do połowy reprezentacji
	max = max*2
    end

    j = max/2
    while !isinf(max +j) # następnie używamy dodawania aby dodając kojelnie wyrazy szeregu max/2, max/4 ... aż do osiągnięcia infinum w kolejnej iteracji
	max = max + j
	j = j/2
    end
    return max # wartość max
end
