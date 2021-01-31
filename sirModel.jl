### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 85b68812-63d3-11eb-3346-87a005eb0f3f
begin
	using DifferentialEquations
	using Plots
end

# ╔═╡ 9a769076-63d3-11eb-2939-218ce06fb993
begin
	function sir!(dt, l, param,t)
		s,i,r = l
		b,k= param
		dt[1] = ds = -b*s*i
		dt[2] = di = (b*s*i)-(k*i)
		dt[3] = dr = k*i
	end
end

# ╔═╡ a3e14b10-63d3-11eb-0a93-03db75344710
begin
	k = 1/3
	b = 1/2
	s0 = 7900000
	i0 = 10
	r0 = 0
	tspan = (1,20)
	param = [b,k]
	l0 = [s0,i0,r0]
	ode_prob = ODEProblem(sir!, l0, tspan, param)
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
# ╠═85b68812-63d3-11eb-3346-87a005eb0f3f
# ╠═9a769076-63d3-11eb-2939-218ce06fb993
# ╠═a3e14b10-63d3-11eb-0a93-03db75344710
# ╠═98d94a74-63d3-11eb-2f58-ff3ea92382f4
# ╠═b26ef4c0-63d3-11eb-3282-d99acabaeda5
# ╠═24ecead4-63d4-11eb-0d0f-4d28474c186c
# ╠═7bb1dc12-63d4-11eb-0784-036bf08c6e8c
