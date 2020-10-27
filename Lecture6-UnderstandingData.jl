### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ ffff1220-f9d8-11ea-1944-c5d31a7d2a41
begin
	using Pkg
	Pkg.add("InstantiateFromURL")
	using InstantiateFromURL
	github_project("QuantEcon/quantecon-notebooks-julia", version = "0.8.0")	
end

# ╔═╡ 69c85ea0-f9d9-11ea-2cd8-e5096d3f36dc
using LinearAlgebra, Statistics

# ╔═╡ 4564c47e-f9da-11ea-0dac-e1fc95d12f5f
using Plots

# ╔═╡ b7d5f2a0-f9da-11ea-08e1-df1ca06b9372
begin
	Pkg.add("Interact")
	using Interact
end

# ╔═╡ e27bf530-f9db-11ea-1b7a-d17d51065b32
begin
	x = rand(1:100)
	s = rand(1:100)
	xs = x*s
	using WebIO
end

# ╔═╡ eb70135e-f91d-11ea-10c6-c550c1243ff7
md"""
# Segment 1: Convolutions in image processing
"""

# ╔═╡ 01e9dc20-f91e-11ea-3a2c-7d5e2a6084c8
outer(v,w) = [x * y for x ∈ v, y ∈ w]

# ╔═╡ 3ee7b890-f91e-11ea-0f1f-a14c76ebf423
outer(1:10, 1:10)

# ╔═╡ 46495e90-f91e-11ea-1f4d-c5dc4334d4f9
flag = outer([1,0.1,2], ones(6))

# ╔═╡ 2b8072d0-f9d5-11ea-3956-cf1d505e9c0f
begin
	show_image(flag)
end

# ╔═╡ 3f2d4d10-f91e-11ea-11f4-532ba695340e
begin 
	xx = image[1, :]
	yy = image[2, :]
end

# ╔═╡ 403fef20-f9da-11ea-3b48-818be6c8b0f4
md"""
# Plotting Data
"""

# ╔═╡ d942ec90-f9da-11ea-2a19-a93e368e5742
@bind i slider(1:length(x), show_values = true)

# ╔═╡ 496b0a80-f9da-11ea-2f6d-f323de251edb


# ╔═╡ Cell order:
# ╟─ffff1220-f9d8-11ea-1944-c5d31a7d2a41
# ╟─69c85ea0-f9d9-11ea-2cd8-e5096d3f36dc
# ╟─eb70135e-f91d-11ea-10c6-c550c1243ff7
# ╠═01e9dc20-f91e-11ea-3a2c-7d5e2a6084c8
# ╠═3ee7b890-f91e-11ea-0f1f-a14c76ebf423
# ╠═46495e90-f91e-11ea-1f4d-c5dc4334d4f9
# ╠═2b8072d0-f9d5-11ea-3956-cf1d505e9c0f
# ╠═3f2d4d10-f91e-11ea-11f4-532ba695340e
# ╟─403fef20-f9da-11ea-3b48-818be6c8b0f4
# ╠═4564c47e-f9da-11ea-0dac-e1fc95d12f5f
# ╠═b7d5f2a0-f9da-11ea-08e1-df1ca06b9372
# ╠═e27bf530-f9db-11ea-1b7a-d17d51065b32
# ╠═d942ec90-f9da-11ea-2a19-a93e368e5742
# ╠═496b0a80-f9da-11ea-2f6d-f323de251edb
