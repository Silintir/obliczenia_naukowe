#Wejście: x wskazany w opisie funkcji
#Wyjście: Wynik funkcji
function f1(n::Float64)
    x:: Float64 = n^2
    x = x+1
    x = x^(Float64(0.5))
    x = x - 1
    return x
end

#Wejście: x wskazany w opisie funkcji
#Wyjście: Wynik funkcji
function f2(n::Float64)
    x:: Float64 = n^2
    y:: Float64 = n^2
    x = x+1
    x = x^(Float64(0.5))
    x = x + 1
    x = y/x
    return x
end

#Funkcja testująca f1 i f2 dla podanych w zadaniu zmiennych
function test_functions()
    n::Float64 = 0.125 # 1/8 z traści zadania
    i::Int = 1
    while i < 10
        println(i," F1: ",f1(n))
        println(i," F2: ",f2(n))
        n = n/8
        i = i+1
    end
end
