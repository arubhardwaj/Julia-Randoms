### A Pluto.jl notebook ###
# v0.11.10

using Markdown
using InteractiveUtils

# ╔═╡ e4e056f0-ede6-11ea-04d5-353a792739a5
begin
	import Pkg
	Pkg.add("InstantiateFromURL")
	using InstantiateFromURL
	github_project("QuantEcon/quantecon-notebooks-julia", version = "0.8.0")
end

# ╔═╡ 28337270-ede7-11ea-053e-4f3edfbcba77
begin	
	using LinearAlgebra, Statistics
	using ForwardDiff, Zygote, Optim, JuMP, Ipopt, BlackBoxOptim, Roots, NLsolve, LeastSquaresOptim
	using Optim: converged, maximum, maximizer, minimizer, iterations
end

# ╔═╡ 56be3b30-ede6-11ea-24d8-fd690160fb7e
md"""
# Solvers, Optimizers, and Automatic Differentiation

"""

# ╔═╡ e08958e0-ede6-11ea-04e9-dfca29f607b3


# ╔═╡ Cell order:
# ╟─56be3b30-ede6-11ea-24d8-fd690160fb7e
# ╠═e08958e0-ede6-11ea-04e9-dfca29f607b3
# ╠═e4e056f0-ede6-11ea-04d5-353a792739a5
# ╠═28337270-ede7-11ea-053e-4f3edfbcba77
