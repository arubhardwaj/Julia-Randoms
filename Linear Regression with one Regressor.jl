### A Pluto.jl notebook ###
# v0.11.10

using Markdown
using InteractiveUtils

# ╔═╡ 6e20f390-eec6-11ea-2c2e-55135c1101d7
begin
	using DataFrames
	df = DataFrame(Y = [2,4,6,8,12,17,14,16,22,40,55], 
               X = [157, 244, 333, 121, 400, 600, 610, 890, 921, 911, 1110 ],
              )
end

# ╔═╡ b2810ae0-eec9-11ea-0b37-89d30d2b2534
begin 
	using Pkg
	Pkg.add("GLM")
	using GLM
end

# ╔═╡ 2a01e770-eec4-11ea-3fdd-b594dec3516e
md"""
# Linear Regression with One Regressor
"""

# ╔═╡ 7337d120-eec4-11ea-2f39-214b80080ed6
md"""
Linear regression is a basic tool in econometrics and this chapter will introduce to run regression model, with one regressor, in Julia. Regression is used to model the relationship between a dependent variable  $Y$ and one or more independent variables (also called as explanatory variables), denoted as $X_1, X_2, X_3,..., X_k$.

In this chapter, we will deal with the regression model with one regressor. Although there is a package in Julia called ``GLM``, wich makes everything simple and we will make use of this package, too. In addition to it, we will see how to find OLS estimates writing formula manually. Therefore, this notebook is divided into *two* sections: finding OLS estimates manually and running regression using ``GLM`` package.
"""

# ╔═╡ 293fe510-eec6-11ea-3f56-31c12b1bf481
md"""
## Section 1: Finding OLS Estimates Manually

"""

# ╔═╡ 3d655d90-eec6-11ea-1b21-3df34286df8c
md"""
It is a good habbit to write equations manually and it is very simple to do so in Julia, unlike other programming languages.

Let's create some data first, to run regression.

"""

# ╔═╡ 87ec89f0-eec7-11ea-22c2-7f110b101e08
md"""
Here, I am using Pluto notebooks which require us to mention ```begin``` and ```end``` whenever we have multiple codes to run in a single cell.

As, it is mentioned below the column name; both $X$ and $Y$ are in Int64 form. hence we are all set to proceed with calculating the coefficients using the model mentioned above.
"""

# ╔═╡ 04bc9880-eec8-11ea-1aa8-0191dcca266e
begin
	X = df.X
	Y = df.Y
	β = (X'X)\(X'Y)
end

# ╔═╡ 701fc970-eec9-11ea-05fe-b59eb9df6ce6
α = 17.81 - β*(sum(Y)/11)

# ╔═╡ b3cd7d80-eec8-11ea-2de3-e5239cef6eda
md"""
The estimate of β, which is the slope in this model, is 0.033 and the intercept value (α) is 17.217.

"""

# ╔═╡ 954c3c60-eec9-11ea-3f71-2baa1a0deeed
md"""
# Section 2: Regression Model Using GLM Package
"""

# ╔═╡ 073e4f70-eeca-11ea-1537-bb13e2f54813
md"""
The above code is required to add ```GLM``` package in working environment and tell Julia to use it. If using ```Pkg``` is showing an error, then one has to write ```using Pkg``` to use it.

The best thing about using ```GLM``` package is that the results also show other statistics like standard error, t-values and p-values.  
"""

# ╔═╡ 644290f0-eeca-11ea-20b2-dd08737c2557
begin
	reg = GLM.lm(@formula(Y~X), df)
	reg
end

# ╔═╡ d2c57112-eece-11ea-3053-6b68fdae8e8d
md"""
To find the value of $R^2$, we need to ask Julia to do so seprately. It is shown below:
"""

# ╔═╡ fddffcd0-eece-11ea-2ec1-75af68922330
r2(reg)

# ╔═╡ Cell order:
# ╟─2a01e770-eec4-11ea-3fdd-b594dec3516e
# ╟─7337d120-eec4-11ea-2f39-214b80080ed6
# ╟─293fe510-eec6-11ea-3f56-31c12b1bf481
# ╟─3d655d90-eec6-11ea-1b21-3df34286df8c
# ╠═6e20f390-eec6-11ea-2c2e-55135c1101d7
# ╟─87ec89f0-eec7-11ea-22c2-7f110b101e08
# ╠═04bc9880-eec8-11ea-1aa8-0191dcca266e
# ╠═701fc970-eec9-11ea-05fe-b59eb9df6ce6
# ╟─b3cd7d80-eec8-11ea-2de3-e5239cef6eda
# ╟─954c3c60-eec9-11ea-3f71-2baa1a0deeed
# ╠═b2810ae0-eec9-11ea-0b37-89d30d2b2534
# ╟─073e4f70-eeca-11ea-1537-bb13e2f54813
# ╠═644290f0-eeca-11ea-20b2-dd08737c2557
# ╟─d2c57112-eece-11ea-3053-6b68fdae8e8d
# ╠═fddffcd0-eece-11ea-2ec1-75af68922330
