using Polynomials

#Wspolczynniki wielomianu z zadania 4
P = [1, -210.0-2.0^(-23.0), 20615.0,-1256850.0,
      53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
      11310276995381.0, -135585182899530.0,
      1307535010540395.0,     -10142299865511450.0,
      63030812099294896.0,     -311333643161390640.0,
      1206647803780373360.0,     -3599979517947607200.0,
      8037811822645051776.0,      -12870931245150988800.0,
      13803759753640704000.0,      -8752948036761600000.0,
      2432902008176640000.0]

# Wielomian Wilkinsona
p = Float64[1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0]

P = P[end:-1:1] # Odwracamy wielomian P dla funkcji 'Poly'
P_Poly = Poly(P)
p_poly = poly(p)

result_roots = roots(P_Poly)


filetex = open("zad4texmod.txt","w")

for i = 1:length(result_roots)
    
    PTex = (abs(polyval(P_Poly, result_roots[i])))
    pTex = (abs(polyval(p_poly, result_roots[i])))
    root = result_roots[i]
    diff = (abs(result_roots[i] - (i)))
    write(filetex, "\$$(i)\$ & \$$(root)\$ & \$$(PTex)\$ & \$$(pTex)\$ & \$$(diff)\$ \\\\ \n \\hline \n")

end

close(filetex)
