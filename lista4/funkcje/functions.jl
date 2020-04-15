module Functions
export ilorazyRoznicowe, warNewton, naturalna, rysujNnfx

using Plots
using SymPy

# ZAD 1
# Funkcja obliczająca ilorazy różnicowe"
# in: x - wektor zaweirający węzły, f - wektor zawierający wartość funkcji w węzłach
# out: fx - wektor zawierający obliczone kolejne ilorazy różnicowe
function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
    n = length(f)
    fx = Vector{Float64}(undef,n)

    for i = 1:n
        fx[i] = f[i]
    end

    for i = 2:n
        for j = n : -1 : i
            fx[j] = ((fx[j] - fx[j - 1])/(x[j] - x[j - i + 1]))
        end
    end

    return fx
end

# ZAD 2
# Funkcja obliczająca wartość wielomianu interpolacyjnego w postaci Newtona
# za pomocą uogólnionego algorytmu Hornera
# in: x - wektor zawierający węzły, fx - wektor zawierający ilorazy różnicowe
# in: t - punkt w którym należy obliczyć wartość wielomianu
# out: nt - wartość wielomiau w punkcie t
function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)

    nt = 1.0 # wartość wielomianu w punkcie t
    n = length(fx) # długość wektorów
    nt = fx[n]

    for i = n-1 : -1 : 1
        nt = fx[i]+(t-x[i])*nt
    end

    return nt
    
end

# ZAD 3
# Funkcja obliczająca współczynniki wielomianu interpolacyjnego w postaci normalnej
# in: x - wektor zawierający węzły, fx - wektor zawierający ilorazy różnicowe
# out: a - wektor zawierający współczynniki w postaci normalnej
function naturalna(x :: Vector{Float64}, fx :: Vector{Float64})
    n = length(fx)                  # długość wektorów
    a = Vector{Float64}(undef,n)          # współczynniki w postaci normalnej
    a[n] = fx[n]                    # z twierdzenia a_n = c_n
    for k = n-1 : -1 : 1            
        a[k] = fx[k]-a[k+1]*x[k]    
        for i = k+1 : n-1           
            a[i] = a[i]-a[i+1]*x[k]
        end
    end
    return a
end


# ZAD 4
# Funkcja interpoluje zadaną funkcję w danym przedziale za pomocą wielomianu w postaci Newtona
# in: f -dana funkcja; a, b - końce przedziału; n - stopień wielomianu
# out: wykres wielomianu interpolacyjnego oraz interpolowanej funkcji
function rysujNnfx(f, a::Float64, b::Float64, n::Int, pict::String)
    
    x = Vector{Float64}(undef,n+1) # zawiera węzły
    y = Vector{Float64}(undef,n+1) # zawiera wartości funkcji w węzłach
    fx = Vector{Float64}(undef,n+1) # ilorazy różnicowe dla kolejtych węzłów
    
    max_w = n+1 # maksymalna ilość węzłów
    h = (b-a)/n # krok
    k_h = 0.0 # kolejne wartości h

    for i = 1:max_w
        x[i] = a+k_h
        y[i] = f(x[i])
        k_h += h
    end

    fx = ilorazyRoznicowe(x, y)

    density = 30 # dla dokładniejszego rysowania wykresów

    k_h = 0.0
    max_w *= density
    h = (b-a)/(max_w-1)

    

    w_x = Vector{Float64}(undef,density*(n+1)) 
    w_y = Vector{Float64}(undef,density*(n+1))
    w_n = Vector{Float64}(undef,density*(n+1)) # wartości wielomianu w węzłach

    for  i = 1:max_w
        w_x[i] = a + k_h
        w_y[i] = f(w_x[i])
        w_n[i] = warNewton(x, fx, w_x[i])
        k_h += h
    end

    labels = Vector{String}(undef, 2)
    labels[1] = "f(x)"
    labels[2] = "w(x)"

    plt = plot(w_x, [w_y, w_n], label=["f(x)" "w(x)"], linewidth=2.0)
    savefig(plt,pict)
end
end
