include("./blocksys.jl")
include("./matrixgen.jl")

using .Blocksys
using .Matrixgen


function testGauss(A, n, l, b)
    println("gauss")
    At = copy(A)
    bt = copy(b)
    it2 = @time gauss(At, n, l, bt)
    At = copy(A)
    bt = copy(b)
    println("  alloc ", @allocated gauss(At, n, l, bt))
    println("  it ", it2[2])

    println("gaussPivots")
    At = copy(A)
    bt = copy(b)
    it = @time gauss_with_pivots(At, n, l, bt)
    At = copy(A)
    bt = copy(b)
    println("  alloc ", @allocated gauss_with_pivots(At, n, l, bt))
    println("  it ", it[2])

    return (it2[2], it[2])
end

function solLU(A, n, l, b)
    println("mat to LU")
    A1 = copy(A)
    b1 = copy(b)
    it = @time matrix_to_LU(A1, n, l)
    A2 = copy(A)
    b2 = copy(b)
    println("  alloc ", @allocated matrix_to_LU(A2, n, l))

    println("  sol")
    it2 = @time solve_from_LU(A1, b1, n, l)
    println("  alloc ", @allocated solve_from_LU(A2, b2, n, l))
    return it[2] + it2[2]
end

function solLUPiv(A, n, l, b)
    println("mat to LU")
    A1 = copy(A)
    b1 = copy(b)
    it = @time matrix_to_LU_with_pivots(A1, n, l)
    A2 = copy(A)
    b2 = copy(b)
    println("  alloc ", @allocated matrix_to_LU_with_pivots(A2, n, l))

    println("  sol")
    itt = @time solve_from_LU_with_pivots(A1, b1, n, l, it[2])
    println("  alloc ", @allocated solve_from_LU_with_pivots(A2, b, n, l, it[2]))
    return it[3] + itt[2]
end

function testLU(A, n, l, b)
    println("LU")
    it = solLU(A, n, l, b)
    println("  it ", it)

    println("LU Pivots")
    it = solLUPiv(A, n, l, b)
    println("  it ", it)
end

function testLib(A, b)
    println("StdLib")
    At = reverse(rotr90(Matrix(A)), dims=2)
    @time At \ b
    println("  alloc ", @allocated At \ b)
end

function genPlot()
    blockmat(1000, 4, 10.0, "A1000.txt")
    mat1k = load_matrix("A1000.txt")
    b1k = [right_side_vector(mat1k...)]

    blockmat(2000, 4, 10.0, "A2000.txt")
    mat2k = load_matrix("A2000.txt")
    b2k = [right_side_vector(mat2k...)]

    blockmat(3000, 4, 10.0, "A3000.txt")
    mat3k = load_matrix("A3000.txt")
    b3k = [right_side_vector(mat3k...)]

    blockmat(4000, 4, 10.0, "A4000.txt")
    mat4k = load_matrix("A4000.txt")
    b4k = [right_side_vector(mat4k...)]

    blockmat(5000, 4, 10.0, "A5000.txt")
    mat5k = load_matrix("A5000.txt")
    b5k = [right_side_vector(mat5k...)]

    blockmat(6000, 4, 10.0, "A6000.txt")
    mat6k = load_matrix("A6000.txt")
    b6k = [right_side_vector(mat6k...)]

    blockmat(7000, 4, 10.0, "A7000.txt")
    mat7k = load_matrix("A7000.txt")
    b7k = [right_side_vector(mat7k...)]

    blockmat(8000, 4, 10.0, "A8000.txt")
    mat8k = load_matrix("A8000.txt")
    b8k = [right_side_vector(mat8k...)]

    blockmat(9000, 4, 10.0, "A9000.txt")
    mat9k = load_matrix("A9000.txt")
    b9k = [right_side_vector(mat9k...)]

    mat16 = load_matrix("../Dane16_1_1/A.txt")
    matTest = copy(mat16[1])
    mat10k = load_matrix("../Dane10000_1_1/A.txt")
    mat50k = load_matrix("../Dane50000_1_1/A.txt")


    b16 = load_vector("../Dane16_1_1/b.txt")
    b10k = load_vector("../Dane10000_1_1/b.txt")
    b50k = load_vector("../Dane50000_1_1/b.txt")

    
    println("----- n = 16 -----")
    g = testGauss(mat16..., b16)
    l = solLU(mat16..., b16)
    lp = solLUPiv(mat16..., b16)
    testLib(mat16[1], b16)

    println("----- n = 1000 -----")
    g = testGauss(mat1k..., b1k[1])
    l = solLU(mat1k..., b1k[1])
    lp = solLUPiv(mat1k..., b1k[1])
    testLib(mat1k[1], b1k[1])

    println("----- n = 2000 -----")
    g = testGauss(mat2k..., b2k[1])
    l = solLU(mat2k..., b2k[1])
    lp = solLUPiv(mat2k..., b2k[1])
    testLib(mat2k[1], b2k[1])

    println("----- n = 3000 -----")
    g = testGauss(mat3k..., b3k[1])
    l = solLU(mat3k..., b3k[1])
    lp = solLUPiv(mat3k..., b3k[1])
    testLib(mat3k[1], b3k[1])

    println("----- n = 4000 -----")
    g = testGauss(mat4k..., b4k[1])
    l = solLU(mat4k..., b4k[1])
    lp = solLUPiv(mat4k..., b4k[1])
    testLib(mat4k[1], b4k[1])

    println("----- n = 5000 -----")
    g = testGauss(mat5k..., b5k[1])
    l = solLU(mat5k..., b5k[1])
    lp = solLUPiv(mat5k..., b5k[1])
    testLib(mat5k[1], b5k[1])

    println("----- n = 6000 -----")
    g = testGauss(mat6k..., b6k[1])
    l = solLU(mat6k..., b6k[1])
    lp = solLUPiv(mat6k..., b6k[1])
    testLib(mat6k[1], b6k[1])

    println("----- n = 7000 -----")
    g = testGauss(mat7k..., b7k[1])
    l = solLU(mat7k..., b7k[1])
    lp = solLUPiv(mat7k..., b7k[1])
    testLib(mat7k[1], b7k[1])

    println("----- n = 8000 -----")
    g = testGauss(mat8k..., b8k[1])
    l = solLU(mat8k..., b8k[1])
    lp = solLUPiv(mat8k..., b8k[1])
    testLib(mat8k[1], b8k[1])

    println("----- n = 9000 -----")
    g = testGauss(mat9k..., b9k[1])
    l = solLU(mat9k..., b9k[1])
    lp = solLUPiv(mat9k..., b9k[1])
    testLib(mat9k[1], b9k[1])

    println("----- n = 10000 -----")
    g = testGauss(mat10k..., b10k)
    l = solLU(mat10k..., b10k)
    lp = solLUPiv(mat10k..., b10k)
    testLib(mat10k[1], b10k)

    println("----- n = 50000 -----")
    g = testGauss(mat50k..., b50k)
    l = solLU(mat50k..., b50k)
    lp = solLUPiv(mat50k..., b50k)

end

genPlot()

