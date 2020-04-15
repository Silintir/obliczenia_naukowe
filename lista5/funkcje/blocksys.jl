module Blocksys

import SparseArrays, LinearAlgebra
using SparseArrays, LinearAlgebra

export load_matrix, load_vector, gauss, write_results, right_side_vector,
 gauss_with_pivots, matrix_to_LU, matrix_to_LU_with_pivots, solve_from_LU,
 solve_from_LU_with_pivots

# Funkcja wczytująca macierz z pliku
# in:	filepath - ścieżka do pliku z macierzą
# out:	A - macierz rzadka wczytana z pliku, n - rozmiar macierzy, l - wielkość bloku
 function load_matrix(filepath::String)
    open(filepath, "r") do file
        size = split(readline(file))
        n = parse(Int64, size[1])
        l = parse(Int64, size[2])
		
		A = spzeros(Float64, n, n)

		while !eof(file)
			ln = split(readline(file))
			i = parse(Int64, ln[1])
			j = parse(Int64, ln[2])
			v = parse(Float64, ln[3])
			A[j,i] = v
		end
		return (A, n, l)
	end
end


# Funkcja wczytująca wektor prawych stron z pliku
# in:	filepath - ścieżka do pliku z wektorem
# out:	b - wczytany wektor
function load_vector(filepath::String)
	open(filepath, "r") do file
		n = parse(Int64, readline(file))
		b = Vector{Float64}(undef, n)

		i = 1
		while !eof(file)
			b[i] = parse(Float64, readline(file))
			i-=-1
		end
		return b
	end
end

# Funkcja zapisująca rozwiązanie układu równań do pliku
# in:	filepath - ścieżka do pliku zapisowego, x - wektor z rozwiązaniem, n - rozmiar macierzy, opt - zapisanie błędu względnego
function write_results(filepath::String, x::Vector{Float64}, n::Int64, opt::Bool)
	open(filepath, "w") do file 
		if opt
			error = norm(ones(n)-x)/norm(x)
			println(file, error)
		end
		for i in 1:n
			println(file, x[i])
		end
	end
end


# Funkcja obliczająca wektor prawych stron dla zadanej macierzy
# in:	A - zadana macierz, n - rozmiar macierzy
# out:	b - obliczony wektor prawych stron
function right_side_vector(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64)
	b = zeros(Float64,n)

	for i in 1:n
		
		for j = convert(Int64, max(l * floor((i-1) / l) - 1, 1)):convert(Int64, min(l + l * floor((i-1) / l), n))
			b[i] += A[j,i]
		end

		if (i+l <= n)
			b[i] += A[i+l,i]
		end
	end
	return b
end


# Funkcja rozwiązująca układ równań liniowych metodą eliminacji Gaussa bez wyboru elementu głównego dla macierzy o zadanej budowie
# in:	A - zadana macierz, n - rozmiar macierzy, l - wielkość bloku, b - wektor prawych stron
# out:	x - rozwiązanie układu
function gauss(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64, b::Vector{Float64})
	it = 0
	for k in 1:n-1
		for i in k+1:convert(Int64, min(l + l*floor((k+1)/l), n)) # ostatni wiersz w kolumnie k
			if abs(A[k,k]) < eps(Float64)
				println("Error - Na diagonali znajduje się zero")
				return
			end
			mult = A[k,i]/A[k,k] # mnożnik
			A[k,i] = 0
			for j in k+1:convert(Int64, min(k+l, n)) # ostatnia kolumna
				A[j,i] -= mult*A[j,k]
				it+=1
			end
			b[i] -= mult*b[k]
		end
	end

	x = Vector{Float64}(undef, n)
	for i in n:-1:1 # podstawianie wstecz
		total = 0.0
		for j in i+1:min(n,i+l) 
			total += A[j,i]*x[j]
		end
		x[i] = (b[i] - total)/A[i,i]
	end
	return x,it
end

# Funkcja rozwiązująca układ równań liniowych metodą eliminacji Gaussa z częściowym wyborem elementu głównego dla macierzy o zadanej budowie
# in:	A - zadana macierz, n - rozmiar macierzy, l - wielkość bloku, b - wektor prawych stron
# out:	x - rozwiązanie układu
function gauss_with_pivots(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64,  b::Vector{Float64})
	it = 0
    p = Vector{Int64}(undef, n)
    # tworzenie wektora permutacji
    for i = 1:n
        p[i] = i
	end
	
	for k in 1:n - 1
		last_row = convert(Int64, min(l + l * floor((k+1) / l), n))
		for i in k+1:last_row
			max_row = k
			max = abs(A[k,p[k]])
			for j in i : last_row
				if (abs(A[k,p[j]]) > max)
					max_row = j;
					max = abs(A[k,p[j]])
					it+=1
				end
			end
			if (abs(max) < eps(Float64))
				println("Error - Macierz osobliwa.")
				return
			end
			p[k], p[max_row] = p[max_row], p[k] # zamiana wierszy
			mult = A[k,p[i]] / A[k,p[k]]
			A[k,p[i]] = 0
			for j in k+1:convert(Int64, min(2*l + l * floor((k+1) / l), n))
				A[j,p[i]] -=  mult * A[j,p[k]]
				it+=1
			end
			b[p[i]] -= mult * b[p[k]]
		end
	end

	x = Vector{Float64}(undef, n)
	for i in n : -1 : 1
		prev_total = 0.0
		for j in i + 1 : convert(Int64, min(2*l + l*floor((p[i]+1)/l), n))
			prev_total += A[j,p[i]] * x[j]
		end
		x[i] = (b[p[i]] - prev_total) / A[i, p[i]]
	end
	return x,it
end

# Funkcja obliczająca rozkład LU bez wyboru elementu głównego dla macierzy o zadanej budowie
# in:	A - zadana macierz, n - rozmiar macierzy, l - wielkość bloku
function matrix_to_LU(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64)
	B = A
	it = 0
	for k in 1:n-1
		for i in k+1:convert(Int64, min(l + l * floor((k+1) / l), n))
			if abs(B[k,k]) < eps(Float64)
				println("Error - Wspolczynnik rowny 0, nie mozna zastosowac metody")
				return 
			end
			mult = B[k,i]/B[k,k]
			B[k,i] = mult
			for j in k+1:convert(Int64, min(k + l, n))
				B[j,i] -= mult * B[j,k]
				it+=1
			end
		end
	end
	return B,it
end

# Funkcja obliczająca rozkład LU z częściowym wyborem elementu głównego dla macierzy o zadanej budowie
# in:	A - zadana macierz, n - rozmiar macierzy, l - wielkość bloku
# out:	p - wektor permutacji wierszy
function matrix_to_LU_with_pivots(A::SparseMatrixCSC{Float64, Int64}, n::Int64, l::Int64)
	B = A
	p = Vector{Int64}(undef, n)
    # tworzenie wektora permutacji
    for i = 1:n
        p[i] = i
	end
	it = 0
	for k in 1:n - 1
		last_row = convert(Int64, min(l + l * floor((k+1) / l), n))
		for i in k +1:last_row
			max_row = k
			max = abs(B[k,p[k]])
			for j in i : last_row
				if (abs(B[k,p[j]]) > max)
					max_row = j;
					max = abs(B[k,p[j]])
					it+=1
				end
			end
			if (abs(max) < eps(Float64))
				println("Error - Macierz osobliwa.")
				return
			end
			p[k], p[max_row] = p[max_row], p[k]
			mult = B[k,p[i]] / B[k,p[k]]
			B[k,p[i]] = mult
			for j in k+1:convert(Int64, min(2*l + l*floor((k+1)/l), n))
				B[j,p[i]] -= mult * B[j,p[k]]
				it+=1
			end
		end
	end
	return B,p,it
end

# Funkcja rozwiązująca układ równań liniowych z rozkładu LU stworzonego bez wyboru elementu głównego
# in:	A - macierz w rozkładzie LU, n - rozmiar macierzy, l - wielkość bloku, b - wektor prawych stron
# out:	x - rozwiązanie układu
function solve_from_LU(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64)
	
	z = Vector{Float64}(undef,n)
	it = 0
	for i in 1:n
		prev_total = 0.0
		for j in convert(Int64, max(l * floor((i-1) / l) - 1, 1)):i-1
			prev_total += A[j, i] * z[j]
			it+=1
		end
		z[i] = b[i] - prev_total
	end

	x = Vector{Float64}(undef,n)
	for i in n : -1 : 1
		total = 0.0
		for j in i + 1:min(n, i + l)
			total += A[j, i] * x[j]
			it+=1
		end
		x[i] = (z[i] - total) / A[i, i]
	end

	return x,it
end

# Funkcja rozwiązująca układ równań liniowych z rozkładu LU stworzonego z częściowym wyborem elementu głównego
# in:	A - macierz w rozkładzie LU, n - rozmiar macierzy, l - wielkość bloku, b - wektor prawych stron, p - wektor permutacji wierszy
# out:	x - rozwiązanie układu
function solve_from_LU_with_pivots(A::SparseMatrixCSC{Float64, Int64}, b::Vector{Float64}, n::Int64, l::Int64, p::Vector{Int64})
	it = 0
	z = Vector{Float64}(undef,n)
	for i in 1:n
		total = 0.0
		for j in convert(Int64, max(l * floor((p[i]-1) / l) - 1, 1)):i-1
			total += A[j, p[i]] * z[j]
			it+=1
		end
		z[i] = b[p[i]] - total
	end

	x = Vector{Float64}(undef,n)
	for i in n:-1:1
		total = 0.0
		for j in i+1:convert(Int64, min(2*l + l*floor((p[i]+1)/l), n))
			total += A[j, p[i]] * x[j]
			it+=1
		end
		x[i] = (z[i] - total) / A[i, p[i]]
	end
	return x,it

end

end
