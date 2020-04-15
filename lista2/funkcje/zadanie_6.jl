# n - "głębokość rekursji"
# c - stała
# x0 - parametr x
function recur(n, c, x0) # obliczanie rekurencji
    if (n == 0)
        return x0
    end

    return recur(n - 1, c, x0)^2 + c
end


filetex = open("zad6tex.txt","w")
for i in 1:40
    write(filetex, "\$$(i)\$ & \$$(recur(i, -2, 1))\$ & \$$(recur(i, -2, 2))\$ & \$$(recur(i, -2,  1.99999999999999))\$  \\\\ \n \\hline\n")
end

close(filetex)


filetex2 = open("zad6tex.txt","w")
for i in 1:40
    write(filetex2, "\$$(i)\$ & \$$(recur(i, -1, 1))\$ & \$$(recur(i, -1, -1))\$ & \$$(recur(i, -1, 0.75))\$ & \$$(recur(i, -1, 0.25))\$ \\\\ \n \\hline\n")
end

close(filetex2)
