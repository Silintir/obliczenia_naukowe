#Wejście: brak
#Wyjście: Pierwsza liczba zmiennoprzecinkowa spełniające zadane równanie
function check_eq_first()
    x::Float64 = 1
    while x<=2
	if Float64(x) * Float64(1/x) != Float64(1.0)
	    return x
	end
	x = nextfloat(x)
    end	
    return 0
end

#Wejście: brak
#Wyjście: Ostatnia liczba zmiennoprzecinkowa spełniające zadane równanie
function check_eq_last()
    x::Float64 = 2
    while x>=1
	if Float64(x) * Float64(1/x) != Float64(1.0)
	    return x
	end
	x = prevfloat(x)
    end	
    return 0
end
