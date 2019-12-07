using DependencyWalker
using Test
using ObjectFile, Pango_jll

@testset "DependencyWalker.jl" begin
    @show Pango_jll.libpango_path
    @show readdir(dirname(Pango_jll.libpango_path))
    @show dump(readmeta(open(Pango_jll.libpango_path, "r")))
    # @test Library(Pango_jll.libpango_path) isa Library{<:ObjectHandle}
    @test Library("this does not exist.foo") isa Library{Missing}
end
