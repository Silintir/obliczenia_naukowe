module Functions

export mbisekcji, mstycznych, msiecznych

# Funkcja oblicza miesjce zerowe podanej funkcji f za pomocą metody bisekcji
# f - dana funkcja; a, b - końce przedziału początkowego; delta, epsilon - dokładności obliczeń
function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)

    u = f(a) # wartość f w punkcie a (początek przedziału)
    v = f(b) # wartość f w punkcie b (koniec przedziału)
    e = b - a # długość (a, b)
    
    if  sign(u) == sign(v)
        return (0,0,0,1) # funkcja nie zmienia znaku w przedziale [a,b]
    end

    i = 1 # liczba iteracji
    while true

        e = e/2 # połowa długości przedziału
        c = a + e # środek przedziału
        w = f(c) # wartość f w środku przedziału

        if abs(e) < delta || abs(w) < epsilon # warunek końca
            return (c,w,i,0)
        end

        if sign(w) != sign(u)
            b = c
            v = w
        else
            a = c
            u = w
        end
        i += 1
    end
end


# Funkcja oblicza miejsce zerowe podanej funkcji f za pomocą metody Newtona
# f, pf - dana funkcja i jej pochodna; x0 - przybliżenie początkowe;
# delta, epsilon - dokładności obliczeń; maxit - maksymalna dopuszczalna liczba iteracji
function mstycznych(f, pf, x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)

    v = f(x0) # wartość f w x0

    if abs(v) < epsilon 
        return (x0,v,0,2) # pochodna bliska zeru
    end

    for k = 1:maxit

        x1 = x0 - v/pf(x0) # następne przybliżenie rozwiązania
        v = f(x1)  # wartość f w następnym przybliżeniu

        if abs(x1 - x0) < delta || abs(v) < epsilon # warunek końca
            return (x1,v,k,0)
        end
        
        x0 = x1 # zmiana punktu początkowego
        
    end

    return (x0,v,maxit,1) # err jeśli nie osiągnięto wyniku w max iteracji
            
end


# Funkcja oblicza miesjce zerowe podanej funkcji f za pomocą metody siecznych
# f - dana funkcja; x0, x1 - przybliżenia początkowe;
# delta, epsilon - dokładności obliczeń; maxit - maksymalna dopuszczalna liczba iteracji
function msiecznych(f, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    
    fa = f(x0)  # wartość f w x0
    fb = f(x1) # wartość f w x1

    for k = 1:maxit

        if abs(fa) > abs(fb) # zamiana x0 z x1 i fa z fb jeśli odległość od zera  fa  jest większa niż fb

            temp = x0
            x0 = x1
            x1 = temp

            temp = fa 
            fa = fb
            fb = temp
            
        end

        s = (x1 - x0)/(fb - fa)
        x1 = x0
        fb = fa
        x0 = x0 - fa*s # następne x0 w punkcie przecięcia się siecznej z OX
        fa = f(x0) # wartość funkcji w nowym x0

        if abs(x1 - x0) < delta || abs(fa) < epsilon # warunek końca
            return (x0,fa,k,0)
        end
        
    end

    return (x0, fa, maxit, 1) # err jeśli nie osiągnięto wyniku w max iteracji
end

end
