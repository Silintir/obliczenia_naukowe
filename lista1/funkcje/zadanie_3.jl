#Wejście: potęga dwójki od której chcemy testować
#Wyjście: brak formalnego wyjścia, funkcja zwraca na standardowe wyjście bitstringi kolejnych liczb w reprezentacji Float64
function float_check(n::Int)
    x::Float64 = 2.0^n # ilość kroków
    delta::Float64 = 2.0^(-52+n) # wielkość kroku
    k::Int = 0
    while k < 2.0^(52-n)
        println(bitstring(x+(k*sigma))," ", x+(k*sigma))
        k = k+1
        sleep(0.5)
    end
end
