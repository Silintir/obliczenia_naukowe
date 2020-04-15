#Wejście: typ zmiennej (Float32 lub Float64)
#Wyjście: Wyniki poszczególnych algorytmów
function scalar_mult(t)

    zad5_x::Array{t,1} = [2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
    zad5_y::Array{t,1} = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]
    
    zad5_mult::Array{t,1} = [0,0,0,0,0]

    # obliczenie wszystkich iloczynów i umieszczenie ich w jedej tablicy
    n::Int = 1 # zmienna służąca do iterowania po pętli
    while n <= 5
        zad5_mult[n] = zad5_x[n]*zad5_y[n]
        n = n+1
    end
    n = 1
    
    #w przód
    println("algorytm 1:")
    acc::t = 0 # akumulator
    while n <= 5
        acc = acc + (zad5_mult[n]) # sumowanie tablicy po kolei od początku
        n = n+1
    end
    println(acc)

    #w tył
    println("algorytm 2:")
    n = 5
    acc = 0
    while n >= 1
        acc = acc + (zad5_mult[n])
        n = n-1
    end
    println(acc)

    #posortowane malejąco
    desc = sort(zad5_mult, rev=true)
    println("algorytm 3:")
    n = 1
    acc = 0
    acc_pos = 0 # akumulator dla liczb dodatnich
    acc_neg = 0 # akumulator dla liczb ujemnych
    while n <= 5
        if desc[n] > 0 # sumowanie osobno liczb dodatnich i ujemnych
            acc_pos = acc_pos + desc[n]
        else
            acc_neg = acc_neg + desc[n]
        end
        n = n+1
    end
    acc = acc_pos+acc_neg
    
    println(acc)

    #posortowane rosnąco
    asc = sort(zad5_mult)
    println("algorytm 4:")
    n = 1
    acc = 0
    acc_pos = 0
    acc_neg = 0
    while n <= 5
        if asc[n] > 0  # sumowanie osobno liczb dodatnich i ujemnych
            acc_pos = acc_pos + asc[n]
        else
            acc_neg = acc_neg + asc[n]
        end
        n = n+1
    end
    acc = acc_neg+acc_pos
    
    println(acc)
end
