### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ a6606bf0-f83a-11ea-1f1c-3788f9480be1



using LinearAlgebra

# ╔═╡ 5677fc70-f844-11ea-065a-59069b0caa2c
begin
	using Interact
end

# ╔═╡ b5b74a20-f8a2-11ea-0874-9175009cb02e
using InteractiveUtils

# ╔═╡ d2d781ce-f837-11ea-2848-e93a0b94d7f6
struct OneHot <: AbstractVector{Int}
	n::Int
	k::Int
end

# ╔═╡ 6be9c180-f838-11ea-3c1e-cf4d3bca935c
Base.size(x::OneHot) = (x.n,)

# ╔═╡ ae56e9d0-f838-11ea-0a8b-a1a462f2742b
Base.getindex(x::OneHot, i::Int) = Int(x.k==i)

# ╔═╡ d4f674c0-f838-11ea-02f9-f35c8b6dba72
myonevector = OneHot(6,2)

# ╔═╡ 627d3ae2-f839-11ea-0c16-3fc9220ba3a6
with_terminal() do
	dump(myonevector)
end

# ╔═╡ 75f8b7c0-f839-11ea-373c-95cac319a32d
md"""
# Diagonal Matrix
"""

# ╔═╡ e8501c50-f839-11ea-3d05-fb532afdc00d
M = [5 0 0 
	 0 6 0 
	 0 0 -10]

# ╔═╡ 2b4c6fd0-f83b-11ea-364e-95921f7eef5e
begin
	using SparseArrays
# Sparse Matrix
	sparse(M)
	
end

# ╔═╡ 685a2030-f83a-11ea-2862-4f7ba317e05d
Diagonal(M)

# ╔═╡ ca3935c0-f83a-11ea-2a81-f58bbd54cb33
Diagonal([3, 5, 7])

# ╔═╡ 267a3500-f840-11ea-0e58-05914d5c0b61
md"""
# Sparse Matrix

"""

# ╔═╡ 399a2460-f840-11ea-3227-c117a2cb89c8
[0 8 9; 5 0 0; 11 10 12]

# ╔═╡ 477421d0-f840-11ea-0ad1-e7acaf43012c
vv = rand(1:9, 1_000_000)

# ╔═╡ b7f084d0-f840-11ea-3901-73c09c725fd6
begin	
	using Statistics
	mean(vv), std(vv), sqrt(10 * 2/3)
end

# ╔═╡ 994848d0-f843-11ea-09ed-a5f315498b5e
md"""
# Multiplication Table
"""

# ╔═╡ e2408d40-f843-11ea-2551-1776f817a479
outer(v, w) = [ x * y for x ∈ v, y ∈ w] # Table

# ╔═╡ 127ae550-f844-11ea-010b-9fda5e5ef56a
outer(1:10, 1:10)

# ╔═╡ 55ba7400-f8a0-11ea-06fc-c1e968f4f6dc
begin	
	k = 500
	outer(1:k, 1:k)
	
end

# ╔═╡ c5a56e70-f88a-11ea-2dd3-752632daf907
function factor(mult_table)
	v = mult_table[:,1]
	w = mult_table[1,:]
	if v[1] != 0 w /= v[1] end
		
	if outer(v, w) = mult_table
			return v,w
	else error("Fuck you!!!")
	end
end

# ╔═╡ 8cfad7ce-f890-11ea-33cf-d511d729b89a
show_image(outer(rand(10), rand(10)))

# ╔═╡ b5ad5f10-f8a2-11ea-36f4-35ec987c25fd


# ╔═╡ b5a8f242-f8a2-11ea-2cea-7fb739f13004


# ╔═╡ b5a10300-f8a2-11ea-2974-7db7007f6969


# ╔═╡ b59bf9f0-f8a2-11ea-29f2-09ef21b71532


# ╔═╡ b59235f0-f8a2-11ea-0cae-f5cb8b6272ba


# ╔═╡ Cell order:
# ╠═a6606bf0-f83a-11ea-1f1c-3788f9480be1
# ╠═d2d781ce-f837-11ea-2848-e93a0b94d7f6
# ╠═6be9c180-f838-11ea-3c1e-cf4d3bca935c
# ╠═ae56e9d0-f838-11ea-0a8b-a1a462f2742b
# ╠═d4f674c0-f838-11ea-02f9-f35c8b6dba72
# ╠═627d3ae2-f839-11ea-0c16-3fc9220ba3a6
# ╟─75f8b7c0-f839-11ea-373c-95cac319a32d
# ╠═e8501c50-f839-11ea-3d05-fb532afdc00d
# ╠═685a2030-f83a-11ea-2862-4f7ba317e05d
# ╠═ca3935c0-f83a-11ea-2a81-f58bbd54cb33
# ╟─267a3500-f840-11ea-0e58-05914d5c0b61
# ╠═2b4c6fd0-f83b-11ea-364e-95921f7eef5e
# ╠═399a2460-f840-11ea-3227-c117a2cb89c8
# ╠═477421d0-f840-11ea-0ad1-e7acaf43012c
# ╠═b7f084d0-f840-11ea-3901-73c09c725fd6
# ╟─994848d0-f843-11ea-09ed-a5f315498b5e
# ╠═e2408d40-f843-11ea-2551-1776f817a479
# ╠═127ae550-f844-11ea-010b-9fda5e5ef56a
# ╠═55ba7400-f8a0-11ea-06fc-c1e968f4f6dc
# ╠═5677fc70-f844-11ea-065a-59069b0caa2c
# ╠═c5a56e70-f88a-11ea-2dd3-752632daf907
# ╠═8cfad7ce-f890-11ea-33cf-d511d729b89a
# ╠═b5b74a20-f8a2-11ea-0874-9175009cb02e
# ╠═b5ad5f10-f8a2-11ea-36f4-35ec987c25fd
# ╠═b5a8f242-f8a2-11ea-2cea-7fb739f13004
# ╠═b5a10300-f8a2-11ea-2974-7db7007f6969
# ╠═b59bf9f0-f8a2-11ea-29f2-09ef21b71532
# ╠═b59235f0-f8a2-11ea-0cae-f5cb8b6272ba
