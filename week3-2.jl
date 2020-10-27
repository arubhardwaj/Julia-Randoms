### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ 7089d040-f919-11ea-33d8-c7f01daf1703
begin	
	using Pkg
	Pkg.add("Suppressor")
	using Suppressor
end

# ╔═╡ 484c70a0-f915-11ea-0393-3dd8cbbc037c
md"""
# Introduction to types in Julia
"""

# ╔═╡ 1e8d4110-f913-11ea-3fc2-e12bb8eb6973
struct Rectangle
	width::Float64
	height::Float64
	
end

# ╔═╡ 44d695b0-f913-11ea-2483-af072ca84f93
r = Rectangle(1,2.5)

# ╔═╡ 67822a20-f913-11ea-24f8-0f22a3ae7412
typeof(r)

# ╔═╡ 837f8a10-f913-11ea-1dfa-31f228c6a949
mutable struct Rectangle2
	width::Float64
	height::Float64
	
end

# ╔═╡ d398c200-f913-11ea-09a3-6dadd35634be
r2 = Rectangle2(10, 20)

# ╔═╡ dd0727f0-f913-11ea-32a7-93708001a813
r2.width = 20

# ╔═╡ cb3b6172-f914-11ea-2d04-8d447bd39660


# ╔═╡ cbc68a70-f914-11ea-0e7d-cb22adc24a25
md"""
# Introduction to multiple-dispatch
"""

# ╔═╡ dc9bc680-f914-11ea-3840-692b669f698e
width(r::Rectangle) = r.width

# ╔═╡ 9a155460-f915-11ea-3ced-31411bf39b3e
width(r)

# ╔═╡ 9efd6ee0-f915-11ea-2e70-9b75ffe70d13
begin
	area(r::Rectangle) = r.width * r.height
	area(x) = x
end

# ╔═╡ fd2dd450-f915-11ea-3bd8-75e05e7a0acf
area(12)

# ╔═╡ 1e26fdd0-f916-11ea-0c3a-5d3d5aa1547c
area("hello")

# ╔═╡ 253a83d0-f916-11ea-3227-91c9632698ce
area

# ╔═╡ 73895bfe-f916-11ea-1669-eb5df73ddc7a
md"""
# Multiple Dispatch: Complex Numbers
"""

# ╔═╡ 2a118750-f916-11ea-23b9-5d7fb5cf6658
cc = 3 + 4im #Complex numbers

# ╔═╡ 7122e350-f916-11ea-3efe-1dc326c533c8
cc+cc

# ╔═╡ 8cf318c0-f916-11ea-1437-9fc05e214a50
cc^2

# ╔═╡ 8f15f8c0-f916-11ea-24cc-d931f78274c2
sqrt(cc)

# ╔═╡ 9ef27cf0-f916-11ea-3adb-5d8788baf53a
sum(cc)

# ╔═╡ a297de40-f916-11ea-014e-ef1cd7017e2c
@which cc + c

# ╔═╡ 0aeb7ab0-f917-11ea-0bc7-bbdee55e7f89
md"""
# Introduction to Macros

"""

# ╔═╡ 287260d0-f917-11ea-1a90-3dda6e3f0766
peakflops()

# ╔═╡ 29270ad0-f917-11ea-111a-610b40e7c210
@elapsed peakflops()

# ╔═╡ 4b3c52b0-f917-11ea-1655-cbd1589ee78e
@macroexpand @elapsed peakflops()

# ╔═╡ 9a0fc430-f917-11ea-1200-175eddc13ebe
Base.remove_linenums!( @macroexpand @elapsed peakflops() )

# ╔═╡ bce28fb0-f917-11ea-02a6-177ec152e246
md"""
# Expressions in Julia
"""

# ╔═╡ 017a3920-f918-11ea-0f73-3395eae10559
x = 1 + 2

# ╔═╡ 0d07fca0-f918-11ea-3c47-f5856711d891
expr = :(1+2)

# ╔═╡ 3056129e-f918-11ea-255d-e7e46f91cbe8
expr2 = quote
	1 + 2
		end

# ╔═╡ 84f4aba0-f918-11ea-08a2-df98ad4fc8ca
typeof(expr)

# ╔═╡ 8bffa620-f918-11ea-0724-979fcca3f875
expr3 = :(y+1)

# ╔═╡ 9737f6a0-f918-11ea-3761-3dd18b287eda
with_terminal() do
	dump(expr3)
end

# ╔═╡ c0f870a0-f918-11ea-0f1b-593b5df14b4e
expr3.head

# ╔═╡ da72ab50-f91c-11ea-1abb-8dc233aad12d
expr3.args

# ╔═╡ dffe0ab0-f91c-11ea-31cd-a7b68e63f457
expr3.args[2] = :x

# ╔═╡ f54260b0-f91c-11ea-2dc2-9d88d2383264
expr3

# ╔═╡ 02101e40-f91d-11ea-0d5b-1fd38b83595a
expr3.args

# ╔═╡ Cell order:
# ╟─484c70a0-f915-11ea-0393-3dd8cbbc037c
# ╠═1e8d4110-f913-11ea-3fc2-e12bb8eb6973
# ╠═44d695b0-f913-11ea-2483-af072ca84f93
# ╠═67822a20-f913-11ea-24f8-0f22a3ae7412
# ╠═837f8a10-f913-11ea-1dfa-31f228c6a949
# ╠═d398c200-f913-11ea-09a3-6dadd35634be
# ╠═dd0727f0-f913-11ea-32a7-93708001a813
# ╠═cb3b6172-f914-11ea-2d04-8d447bd39660
# ╟─cbc68a70-f914-11ea-0e7d-cb22adc24a25
# ╠═dc9bc680-f914-11ea-3840-692b669f698e
# ╠═9a155460-f915-11ea-3ced-31411bf39b3e
# ╠═9efd6ee0-f915-11ea-2e70-9b75ffe70d13
# ╠═fd2dd450-f915-11ea-3bd8-75e05e7a0acf
# ╠═1e26fdd0-f916-11ea-0c3a-5d3d5aa1547c
# ╠═253a83d0-f916-11ea-3227-91c9632698ce
# ╟─73895bfe-f916-11ea-1669-eb5df73ddc7a
# ╠═2a118750-f916-11ea-23b9-5d7fb5cf6658
# ╠═7122e350-f916-11ea-3efe-1dc326c533c8
# ╠═8cf318c0-f916-11ea-1437-9fc05e214a50
# ╠═8f15f8c0-f916-11ea-24cc-d931f78274c2
# ╠═9ef27cf0-f916-11ea-3adb-5d8788baf53a
# ╠═a297de40-f916-11ea-014e-ef1cd7017e2c
# ╟─0aeb7ab0-f917-11ea-0bc7-bbdee55e7f89
# ╠═287260d0-f917-11ea-1a90-3dda6e3f0766
# ╠═29270ad0-f917-11ea-111a-610b40e7c210
# ╠═4b3c52b0-f917-11ea-1655-cbd1589ee78e
# ╠═9a0fc430-f917-11ea-1200-175eddc13ebe
# ╟─bce28fb0-f917-11ea-02a6-177ec152e246
# ╠═017a3920-f918-11ea-0f73-3395eae10559
# ╠═0d07fca0-f918-11ea-3c47-f5856711d891
# ╠═3056129e-f918-11ea-255d-e7e46f91cbe8
# ╠═84f4aba0-f918-11ea-08a2-df98ad4fc8ca
# ╠═8bffa620-f918-11ea-0724-979fcca3f875
# ╠═7089d040-f919-11ea-33d8-c7f01daf1703
# ╠═9737f6a0-f918-11ea-3761-3dd18b287eda
# ╠═c0f870a0-f918-11ea-0f1b-593b5df14b4e
# ╠═da72ab50-f91c-11ea-1abb-8dc233aad12d
# ╠═dffe0ab0-f91c-11ea-31cd-a7b68e63f457
# ╠═f54260b0-f91c-11ea-2dc2-9d88d2383264
# ╠═02101e40-f91d-11ea-0d5b-1fd38b83595a
