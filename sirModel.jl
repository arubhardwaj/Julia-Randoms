### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 85b68812-63d3-11eb-3346-87a005eb0f3f
begin
	using DifferentialEquations
	using Plots
end

# ╔═╡ f8ec88ae-64e6-11eb-065d-4b630cba652d
# Replication of equations from https://www.maa.org/press/periodicals/loci/joma/the-sir-model-for-spread-of-disease-the-differential-equation-model

# Thanks to @TheCoolMoriarty for helping me in solving a weird issue!!! Come on MAA, learn to write a blog (or whatever it was)!

# ╔═╡ 9a769076-63d3-11eb-2939-218ce06fb993
begin
	function SIR(du,u,p,t)
		s,i,r = u
		b,k = p
		du[1] = -b*s*i
		du[2] = b*s*i - k*i
		du[3] = k*i
	end
end

# ╔═╡ a3e14b10-63d3-11eb-0a93-03db75344710
begin
	#initian conditions
	p = [0.5/7900000.0,0.33]
	u0 = [7900000.0,10.0,0.0]
	# u0 = [1.,1.27e-6,0.]
	tspan = (0.0,140.0)
	ode_prob = ODEProblem(SIR,u0,tspan,p)
end

# ╔═╡ 98d94a74-63d3-11eb-2f58-ff3ea92382f4
sir_solve = solve(ode_prob)

# ╔═╡ b26ef4c0-63d3-11eb-3282-d99acabaeda5
plot(sir_solve)

# ╔═╡ 24ecead4-63d4-11eb-0d0f-4d28474c186c
begin
	xyzt = plot(sir_solve, plotdensity=10000,lw=1.5)
	xy = plot(sir_solve, plotdensity=10000, vars=(1))
	xz = plot(sir_solve, plotdensity=10000, vars=(2))
	xx = plot(sir_solve, plotdensity=10000, vars=(3))
	xyz = plot(sir_solve, plotdensity=10000, vars=(1,2,3))
	plot(plot(xyzt,xyz))
end

# ╔═╡ 7bb1dc12-63d4-11eb-0784-036bf08c6e8c
plot(xy, xz, xx)

# ╔═╡ Cell order:
# ╠═f8ec88ae-64e6-11eb-065d-4b630cba652d
# ╠═85b68812-63d3-11eb-3346-87a005eb0f3f
# ╠═9a769076-63d3-11eb-2939-218ce06fb993
# ╠═a3e14b10-63d3-11eb-0a93-03db75344710
# ╠═98d94a74-63d3-11eb-2f58-ff3ea92382f4
# ╠═b26ef4c0-63d3-11eb-3282-d99acabaeda5
# ╠═24ecead4-63d4-11eb-0d0f-4d28474c186c
# ╠═7bb1dc12-63d4-11eb-0784-036bf08c6e8c
