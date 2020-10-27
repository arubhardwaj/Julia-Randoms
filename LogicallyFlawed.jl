### A Pluto.jl notebook ###
# v0.12.1

using Markdown
using InteractiveUtils

# ╔═╡ d09b3510-181c-11eb-3f94-29736959d770
begin
	using Pkg
	Pkg.add("Statistics")
	Pkg.add("StatsPlots")
	using GLM, CSV, DataFrames, StatsPlots, Statistics
end

# ╔═╡ 28cf6f74-181f-11eb-12c3-69fa032d0d49
begin
	Pkg.add("RegressionTables")
	using RegressionTables
end

# ╔═╡ 1685776c-1826-11eb-18c6-f166ca71a06b
begin
	Pkg.add("FixedEffectModels")
	using FixedEffectModels
end

# ╔═╡ 430562d6-1829-11eb-33a4-d587233c50df
md"""
# Logically Flawed Models
"""

# ╔═╡ c98988b0-181e-11eb-3801-091c1fcd05b2
md"""
## Simple Regression Model
"""

# ╔═╡ 9d032afa-1817-11eb-3009-017f3ef26828
md"""
### Importing CSV File
The data used here is from [Blanchard and Quah (1989)](https://uh.edu/~bsorense/BlanchardQuah1989.pdf). In this first part, I will use two variable: ```GNP``` and ```Unrate```. This will be a Regression model with one ``independent`` variable.
"""

# ╔═╡ 4a3095e0-1814-11eb-170e-73e98ef9b865
data = CSV.read("/home/arubhardwaj/E/BQdata.csv");

# ╔═╡ 4ccb6628-1818-11eb-3138-a3ce081c5ea7
begin
	using Plots
	plot(data.GNP, data.Unrate, legend=false)
end

# ╔═╡ 3cd846e6-1818-11eb-1a56-8bbed622d195
md"""
### Exploring the data set
"""

# ╔═╡ ff72d148-1814-11eb-1f62-6509d39e70d0
head(data)

# ╔═╡ bf65a92c-1819-11eb-1ad1-c54851c2f92b
begin
	plot(data.GNP, label = "GNP", title = "GNP vs. Unrate", lw = 2);
	plot!(data.Unrate,label = "Unrate", lw=2)
end

# ╔═╡ 4563c00a-181e-11eb-21b2-4776521cf4bc
scatter(data.GNP, data.Unrate, color ="brown", legend = false)

# ╔═╡ d5ffc49c-1819-11eb-1e74-a1af849835e2
md"""
#### Regresssion Model
Now, we will run the following regression model to quantify the impact of ``Unrate`` on the ``GNP``. 

$$GNP = \alpha + \beta \times Unrate + \epsilon$$

where, $\alpha$ is an intercetp, which defines the value of ``GNP`` when ``Unrate`` is ``zero``. $\beta$ value quantify the impact of change in ``GNP`` when ``Unrate`` changes and $\epsilon$ is an error term.
"""

# ╔═╡ 2855a346-181b-11eb-2aa2-9d50d1c21f8e
md"""
We will use [GML.jl](https://juliastats.org/GLM.jl) package for estimating our regression model. 
"""

# ╔═╡ 169475c8-181c-11eb-2aff-53301e64b7cd
model = lm(@formula(GNP~Unrate), data)

# ╔═╡ 4f7a3e18-181c-11eb-2a55-ddfec060a4bc
md"""
The above results shows the coefficients of $\alpha$ and $\beta$, along with then it also gives other statistics. From the ``p-values`` of the coefficient it appears that the coefficients are statistically significant. Yayyy!!!!
"""

# ╔═╡ 9505a24a-181e-11eb-1570-e1d95e79b802
md"""
##### Value of $R^2$
"""

# ╔═╡ 96e88efa-181c-11eb-0ee2-8d1bc150db7d
r2(model)

# ╔═╡ ade8751e-1821-11eb-2b30-6d3f1ec81370
md"""
### Fancy Table for Output 
"""

# ╔═╡ a5b8a4fa-1820-11eb-2fdf-63b888509960
import PlutoUI

# ╔═╡ 9d671c7c-181f-11eb-1d30-c3318d310a1a
PlutoUI.with_terminal() do
	regtable(model; renderSettings = asciiOutput())
end

# ╔═╡ 9f3da2a8-181e-11eb-3018-e7cbb3a6f7cd
md"""
## Fixed Effect Model

**Disclaimer: The following exersice is logically flawed, please don't judge me on its basis. I was just exploring the [FixedEffectModels.jl](https://github.com/matthieugomez/FixedEffectModels.jl)**

:)

"""

# ╔═╡ e33e489c-181e-11eb-1e8a-4137751690d5
md"""
### Importing CSV File
The data set used here is of ``Fish Market``, taken from [Kaggle](https://www.kaggle.com/aungpyaeap/fish-market). This dataset is a record of 7 common different fish species in fish market sales.
"""

# ╔═╡ a6a8fc76-1824-11eb-24d2-57f0f3204e38
fish = CSV.read("/home/arubhardwaj/Downloads/Fish.csv");

# ╔═╡ fce676c4-1824-11eb-2d9a-4d6787ac36a0
head(fish)

# ╔═╡ 36165688-1825-11eb-14f5-9d32fcde5c6f
bar(fish.Species, fish.Weight)

# ╔═╡ 1eaea0ca-1827-11eb-002c-c366d153c2bd
FEmodel1 = reg(fish, @formula(Height ~ Length1 + Length2 + Length3 + Weight + Width + fe(Species)))

# ╔═╡ ba41ec7c-1827-11eb-3f67-99d730dd0468
FEmodel2 = reg(fish, @formula(Height ~ Length1 + Length2 + Length3 + Weight + fe(Species)))

# ╔═╡ cb77ca0c-1827-11eb-3a97-d914c6e8aba7
FEmodel3 = reg(fish, @formula(Height ~ Length1 + Length2 + Length3 + Weight + fe(Species)))

# ╔═╡ e66bd542-1827-11eb-0ee5-8ff3098bc1c9
FEmodel4 = reg(fish, @formula(Height ~ Length2 + Width + Weight + fe(Species)), Vcov.cluster(:Species))

# ╔═╡ 210db8a0-1828-11eb-144a-1555f524f0cc
PlutoUI.with_terminal() do
	regtable(FEmodel1, FEmodel2, FEmodel3, FEmodel4; renderSettings = asciiOutput())
end

# ╔═╡ a6155c88-1828-11eb-2422-65fadc4afbe4
md"""

**The End.....**

"""

# ╔═╡ Cell order:
# ╟─430562d6-1829-11eb-33a4-d587233c50df
# ╠═d09b3510-181c-11eb-3f94-29736959d770
# ╟─c98988b0-181e-11eb-3801-091c1fcd05b2
# ╟─9d032afa-1817-11eb-3009-017f3ef26828
# ╠═4a3095e0-1814-11eb-170e-73e98ef9b865
# ╟─3cd846e6-1818-11eb-1a56-8bbed622d195
# ╠═ff72d148-1814-11eb-1f62-6509d39e70d0
# ╠═4ccb6628-1818-11eb-3138-a3ce081c5ea7
# ╠═bf65a92c-1819-11eb-1ad1-c54851c2f92b
# ╠═4563c00a-181e-11eb-21b2-4776521cf4bc
# ╟─d5ffc49c-1819-11eb-1e74-a1af849835e2
# ╟─2855a346-181b-11eb-2aa2-9d50d1c21f8e
# ╠═169475c8-181c-11eb-2aff-53301e64b7cd
# ╟─4f7a3e18-181c-11eb-2a55-ddfec060a4bc
# ╟─9505a24a-181e-11eb-1570-e1d95e79b802
# ╠═96e88efa-181c-11eb-0ee2-8d1bc150db7d
# ╠═28cf6f74-181f-11eb-12c3-69fa032d0d49
# ╟─ade8751e-1821-11eb-2b30-6d3f1ec81370
# ╟─a5b8a4fa-1820-11eb-2fdf-63b888509960
# ╠═9d671c7c-181f-11eb-1d30-c3318d310a1a
# ╟─9f3da2a8-181e-11eb-3018-e7cbb3a6f7cd
# ╟─e33e489c-181e-11eb-1e8a-4137751690d5
# ╠═a6a8fc76-1824-11eb-24d2-57f0f3204e38
# ╠═fce676c4-1824-11eb-2d9a-4d6787ac36a0
# ╠═36165688-1825-11eb-14f5-9d32fcde5c6f
# ╠═1685776c-1826-11eb-18c6-f166ca71a06b
# ╠═1eaea0ca-1827-11eb-002c-c366d153c2bd
# ╠═ba41ec7c-1827-11eb-3f67-99d730dd0468
# ╠═cb77ca0c-1827-11eb-3a97-d914c6e8aba7
# ╠═e66bd542-1827-11eb-0ee5-8ff3098bc1c9
# ╠═210db8a0-1828-11eb-144a-1555f524f0cc
# ╟─a6155c88-1828-11eb-2422-65fadc4afbe4
