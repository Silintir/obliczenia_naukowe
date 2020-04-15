include("./blocksys.jl")
include("./matrixgen.jl")

using .Blocksys
using .Matrixgen

#blockmat(1000, 4, 2.0, "A1000.txt")
(A,n,l) = load_matrix("../Dane50000_1_1/A.txt")

b = right_side_vector(A,n,l)
#x,it = gauss(A,n,l,b)

#x,it = gauss_with_pivots(A,n,l,b)

#B,it = matrix_to_LU(A,n,l)
#x,it = solve_from_LU(B, b, n, l)

B, p,it = matrix_to_LU_with_pivots(A,n,l)
x,it = solve_from_LU_with_pivots(B, b, n, l, p)

write_results("results4.txt", x, n, true)



