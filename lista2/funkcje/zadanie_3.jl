include("./resources/hilb.jl")
include("./resources/matcond.jl")

matrix_max = 20 # maksymalny rozmiar macierzy Hilberta
c = [Float64(1), Float64(10), Float64(10^3), Float64(10^7), Float64(10^12), Float64(10^16)] # wskaźnik uwarunkowania macierzy losowej
n = [5, 10, 20] # rozmiar macierzy losowej


function gauss(A,b)
    A\b # Eliminacja Gauss'a
end

function inversion(A,b)
    inv(A)*b # Odwrócenie macierzy
end

function error(xap, x)
    norm(xap - x) / norm(x) # Błąd względny
end

function generate_matrix(A,n)

    x = ones(Float64,n) # Wypełnianie naszej macierzy
    b = A*x # Tworzenie wektora

    x_gauss = gauss(A,b)
    x_inv = inversion(A,b)
    error_gauss = error(x_gauss, x) # Obliczanie błędu metodą Gauss'a
    error_inv = error(x_inv, x) # Obliczanie błędy metodą inwersji


    println("Size: $(n)x$(n)")
    println("Rank: $(rank(A))")
    println("Cond: $(cond(A))")
    println("Gauss: $(error_gauss)")
    println("Inversion: $(error_inv)\n")
end

#  macierz Hilberta
println("Hilbert\n")
for i = 1: matrix_max
    generate_matrix(hilb(i),i)
end

# macierz losowa
println("Random\n")
for i = 1: length(n)
    for j = 1: length(c)
        generate_matrix(matcond(n[i],c[j]), n[i])
    end
end
