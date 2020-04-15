include("./functions.jl")

using .Functions
using Test

println(msiecznych(x -> x^3 - 6*x + 9, -5.0, 5.0, 2.0^-12, 2.0^-12, 100))


#bisekcja
@testset "Metoda bisekcji test" begin
    @test isapprox(mbisekcji(x -> x+4, -5.0, 5.0, 2.0^-12, 2.0^-12)[1], -4, atol=0.001)
    @test isapprox(mbisekcji(x -> x^3 + 6*x + 9, -5.0, 5.0, 2.0^-12, 2.0^-12)[1], -1.207, atol=0.001)
    @test isapprox(mbisekcji(x -> x^3 - 6*x + 9, -5.0, -1.0, 2.0^-12, 2.0^-12)[1], -3, atol=0.001)
end

#newton
@testset "Metoda newtona test" begin
    @test isapprox(mstycznych(x -> x+4, x -> 1, -3.8, 2.0^-12, 2.0^-12, 50)[1], -4, atol=0.001)
    @test isapprox(mstycznych(x -> x^3 + 6*x + 9, x -> 3x^2 + 6, -1.0, 2.0^-12, 2.0^-12, 50)[1], -1.207, atol=0.001)
    @test isapprox(mstycznych(x -> x^3 - 6*x + 9, x -> 3x^2 - 6, -2.8, 2.0^-12, 2.0^-12, 50)[1], -3, atol=0.001)
end

#sieczne
@testset "Metoda siecznych test" begin
    @test isapprox(msiecznych(x -> x+4, -5.0, 5.0, 2.0^-12, 2.0^-12, 50)[1], -4, atol=0.001)
    @test isapprox(msiecznych(x -> x^3 + 6*x + 9, -5.0, 5.0, 2.0^-12, 2.0^-12, 50)[1], -1.207, atol=0.001)
    @test isapprox(msiecznych(x -> x^3 - 6*x + 9, -5.0, -1.0, 2.0^-12, 2.0^-12, 50)[1], -3, atol=0.001)
end

