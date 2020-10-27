### A Pluto.jl notebook ###
# v0.12.1

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

# ╔═╡ f76e24ec-0bdb-11eb-31e3-57ca8a2ba3ed
begin
	using Pkg
	Pkg.add(["Suppressor", "PlutoUI", "StatsBase", "Plots", "DataStructures", "GR"])
	using PlutoUI
	using Plots
	using GR
	using DataStructures
	using Suppressor
	using StatsBase
end

# ╔═╡ 2425ff2e-0bdb-11eb-0cf9-970152ec784f
md"""
# Rolling a Dice
"""

# ╔═╡ fb163c38-0bdb-11eb-396a-1b9219257abe
begin
	num_sides = 6
	sides = 1:num_sides
end

# ╔═╡ 0d216ada-0bdc-11eb-222e-694f40440d7f
sides

# ╔═╡ 1e3401aa-0bdc-11eb-1fe3-931a8357dd46
typeof(sides)

# ╔═╡ 0fd1bc24-0bdc-11eb-1e9c-a3023c98d514
rand(sides)

# ╔═╡ 3f7e2962-0bdc-11eb-3d21-7777c4a3dfe4
md"""
The above codes show what will happen when we role a dice, and ``rand(sides)`` specifies the roll of die for once.

To do this for multiple times, we need to specify **N** in ``rand(sides, N)``. The example of this is:
"""

# ╔═╡ 7c4b35ec-0bdc-11eb-333c-0562625d2457
rand(sides, 10)

# ╔═╡ 88a0005c-0bdc-11eb-37e2-abc37641c634
md"""
As it is visible, that it rolled 10 dice and the output of them are shown in **Int64[]** datatype. Now, to make it more easy for us to specify the **N**, we will rewrite the command as:
"""

# ╔═╡ 50dcd456-0bde-11eb-08b0-91e3291e18bd
num_rolls = 1:1200

# ╔═╡ 781ca3c2-0bdc-11eb-0c85-dd67a8869a7f
@bind N Slider(1:length(num_rolls), show_value=true)

# ╔═╡ 33241be8-0bde-11eb-2c26-93b28543df75
sample = rand(sides, N)

# ╔═╡ 946bf286-0bde-11eb-01a5-13e45da167a5
frequency = StatsBase.countmap(sample)

# ╔═╡ 4395bf7a-0be0-11eb-3055-c38f1d617056
bar(frequency, alpha = 1,
	xlabel = "Outcome from Roll", ylabel = "Total Frequency of Outcome",
	xlim =(0, num_sides+1), ylim = (0, 300), leg = false)

# ╔═╡ 764b6a86-0be1-11eb-0bc7-5b76686a3309
begin
	max_rolls = 1000
	rolls2 = rand(1:num_sides, max_rolls)
end

# ╔═╡ bcca6a96-0be3-11eb-08b8-890a975dabc9
@bind num_rolls2 Slider(1:max_rolls, show_value=true)

# ╔═╡ 575f87ee-0be4-11eb-2311-31adc458148e
begin
	freqs2 = SortedDict(StatsBase.countmap(rolls2[1:num_rolls2]))
	
	ks = collect(keys(freqs2))
	vs = collect(values(freqs2)) ./ num_rolls2
	
	bar(ks, vs, leg=false, alpha=0.5, xlims=(0, num_sides+1),
		size=(400,300),
		xlabel="value", ylabel="relative frequency")
	
	hline!([1 / num_sides], ls=:dash, lw=3, c=:red)
	
	 ylims!(0, 0.3)
end

# ╔═╡ 3769c216-0be8-11eb-0021-d3b1c59b25d5
md"""
# Random Variables
"""

# ╔═╡ 3d02e478-0be8-11eb-1b43-a5c5af004488
md"""
Let **X** be the outcome for flipping the coin. Each time we will run it we will have a different value of **X**, which makes it a *random variable*

We can write it as:

$$\mathbb{P}(X=1) = \frac{1}{6}$$

to say that the probability of **X** taking the value of 1 is $\frac{1}{6}$
"""

# ╔═╡ 0f4c5a4a-0be9-11eb-20a1-276b06c0e786
md"""
# Uniform Random Numbers
"""

# ╔═╡ 3f3cf308-0bea-11eb-2050-21fe372cf58c
rand(Int64)

# ╔═╡ 48aef422-0bea-11eb-02ce-a174f1045d2a
rand(Float64)

# ╔═╡ 4d4a2eb6-0bea-11eb-181a-338a0b24c3cd
rand()

# ╔═╡ 52b9ce9c-0bea-11eb-332e-81a5647001d8
begin
	max_samples = 500
	sample2 = rand(max_samples)
end

# ╔═╡ 9e914a70-0bea-11eb-151c-19e3f51a2018
@bind num_samples Slider(1:max_samples, show_value=true)

# ╔═╡ 7d736ee0-0bea-11eb-315c-81ad0fe3c29e
begin
	r = sample2[1:num_samples]
	scatter(r, 1:length(r), alpha=0.5, leg=false,
			size=(400, 300))
	scatter!(r, zeros(length(r)), alpha=0.5)
	
	ylims!(-10, max_samples)
	xlims!(0, 1)
	
	xlabel!("random variate")
	ylabel!("position in sequence (time)")
end

# ╔═╡ 7f433dae-0bea-11eb-3281-21f01ee32d31


# ╔═╡ 7f9c5a6c-0bea-11eb-2f3f-9f4b935b883d


# ╔═╡ Cell order:
# ╠═2425ff2e-0bdb-11eb-0cf9-970152ec784f
# ╠═fb163c38-0bdb-11eb-396a-1b9219257abe
# ╠═0d216ada-0bdc-11eb-222e-694f40440d7f
# ╠═1e3401aa-0bdc-11eb-1fe3-931a8357dd46
# ╠═0fd1bc24-0bdc-11eb-1e9c-a3023c98d514
# ╟─3f7e2962-0bdc-11eb-3d21-7777c4a3dfe4
# ╠═7c4b35ec-0bdc-11eb-333c-0562625d2457
# ╟─88a0005c-0bdc-11eb-37e2-abc37641c634
# ╠═50dcd456-0bde-11eb-08b0-91e3291e18bd
# ╠═781ca3c2-0bdc-11eb-0c85-dd67a8869a7f
# ╠═33241be8-0bde-11eb-2c26-93b28543df75
# ╠═946bf286-0bde-11eb-01a5-13e45da167a5
# ╠═4395bf7a-0be0-11eb-3055-c38f1d617056
# ╠═764b6a86-0be1-11eb-0bc7-5b76686a3309
# ╠═bcca6a96-0be3-11eb-08b8-890a975dabc9
# ╠═575f87ee-0be4-11eb-2311-31adc458148e
# ╠═f76e24ec-0bdb-11eb-31e3-57ca8a2ba3ed
# ╟─3769c216-0be8-11eb-0021-d3b1c59b25d5
# ╟─3d02e478-0be8-11eb-1b43-a5c5af004488
# ╟─0f4c5a4a-0be9-11eb-20a1-276b06c0e786
# ╠═3f3cf308-0bea-11eb-2050-21fe372cf58c
# ╠═48aef422-0bea-11eb-02ce-a174f1045d2a
# ╠═4d4a2eb6-0bea-11eb-181a-338a0b24c3cd
# ╠═52b9ce9c-0bea-11eb-332e-81a5647001d8
# ╠═9e914a70-0bea-11eb-151c-19e3f51a2018
# ╠═7d736ee0-0bea-11eb-315c-81ad0fe3c29e
# ╠═7f433dae-0bea-11eb-3281-21f01ee32d31
# ╠═7f9c5a6c-0bea-11eb-2f3f-9f4b935b883d
