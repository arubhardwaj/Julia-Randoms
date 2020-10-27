### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ 7dd71fa0-ed48-11ea-2ed3-c541ff4e4962
begin
	using Pkg
	Pkg.add(["Images", "ImageIO", "ImageMagick"])
	using Images
end

# ╔═╡ c797a800-ed46-11ea-1408-21f67d3cb4e7
md"""
# First taste of abstraction with arrays
"""

# ╔═╡ 247c2c82-ed47-11ea-22d0-2b655832f67a
keeptrack = [typeof(1), typeof(1.0), typeof("one"), typeof(1//1)]

# ╔═╡ 9510f980-ed47-11ea-071d-119158619bda
typeof(keeptrack)

# ╔═╡ 9f192e70-ed47-11ea-3efe-319e3e79780e
cute_one = load(download("https://image.shutterstock.com/image-illustration/numeral-1-foil-balloon-number-260nw-1156249828.jpg"))

# ╔═╡ fe535830-ed46-11ea-01c3-4fba15d60cbb
element = cute_one

# ╔═╡ 092ac400-ed47-11ea-2779-bd333d7d484b
fill(element, 3,4)

# ╔═╡ 0e525880-ed47-11ea-17eb-c73fa421070d
typeof(element)

# ╔═╡ e6d8e0f2-ed49-11ea-18b3-cdf7c159bc21
md"""
Alen summed up by saying "the notion of array is a container that contains elements, that can be of many mnay different types. Soon we will see one can write functions on anything and they will be independent of type, as long as it makes sense".

"""

# ╔═╡ Cell order:
# ╟─c797a800-ed46-11ea-1408-21f67d3cb4e7
# ╠═7dd71fa0-ed48-11ea-2ed3-c541ff4e4962
# ╠═fe535830-ed46-11ea-01c3-4fba15d60cbb
# ╠═092ac400-ed47-11ea-2779-bd333d7d484b
# ╠═0e525880-ed47-11ea-17eb-c73fa421070d
# ╠═247c2c82-ed47-11ea-22d0-2b655832f67a
# ╠═9510f980-ed47-11ea-071d-119158619bda
# ╠═9f192e70-ed47-11ea-3efe-319e3e79780e
# ╟─e6d8e0f2-ed49-11ea-18b3-cdf7c159bc21
