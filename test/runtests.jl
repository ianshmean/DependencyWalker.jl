using DependencyWalker
using Test
using ObjectFile, Pango_jll

@testset "DependencyWalker.jl" begin
    @show Pango_jll.libpango_path
    @show readdir(dirname(Pango_jll.libpango_path))

    if Sys.islinux() || Sys.isfreebsd()
        const handle_type = ELFHandle
    elseif Sys.isapple()
        const handle_type = MachOHandle
    elseif Sys.iswindows()
        const handle_type = COFFHandle
    else
        const handle_type = nothing
    end

    open(Pango_jll.libpango_path, "r") do io
        oh = readmeta(io, handle_type)
        @show dump(oh)
        @show find_libraries(oh)
    end
    # @test Library(Pango_jll.libpango_path) isa Library{<:ObjectHandle}
    @test Library("this does not exist.foo") isa Library{Missing}
end
