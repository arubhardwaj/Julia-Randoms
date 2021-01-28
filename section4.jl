### A Pluto.jl notebook ###
# v0.12.19

using Markdown
using InteractiveUtils

# ╔═╡ 8ae26d04-5f3e-11eb-22ba-33ff8ca44b3a
begin
	using DifferentialEquations
	using Plots
	gr()
	theme(:ggplot2)
end

# ╔═╡ 640a8b1e-60b3-11eb-13b8-87fdf01a662b
md"""
# Dynamics of Open Source Movements
#### Section 4: Competing with Open Source
"""

# ╔═╡ 5d20ce90-5f3e-11eb-13be-27ed778a5567
md"""
This section is the replication of Section 4.4 on **Dynamic Profit Maximization**, in the paper. Full paper is availiable [here](http://economics.mit.edu/files/12002)
"""

# ╔═╡ 404551cc-6131-11eb-21e7-affa5c8f7f83
md"""
List of Variables:

α $\rightarrow$ Probability of being altruistic 

K $\rightarrow$ Sharing Cost

E $\rightarrow$ Programming Cost

p $\rightarrow$ price

v $\rightarrow$ customer value of the commercial software

b0 $\rightarrow$ is a choice between two goods: the commercial softwarethat provides utility ``v−p``

λ $\rightarrow$ parameter of the need arrival process.

b $\rightarrow$ represents the altrustic share of population

δ and β $\rightarrow$ depriciation rates

Value of $B_{ij}$ is assumed to be drawn from Normal Distribution [0,10]. 

"""

# ╔═╡ 007db670-60b8-11eb-0d98-35fad3954d03
md"""
Following are the required packages for this exercise.
"""

# ╔═╡ 18d751c2-60b8-11eb-3551-67ad3e2c0294
md"""
In the first step we setup the following ODE problem in Julia. 
"""

# ╔═╡ cb0086b2-5fe5-11eb-3fe1-e91770ff6da2
begin	# Setting up ODE Problem
	
	function ode_func!(du,u,params,t)
		q, b = u
		α, β, δ, λ, v, p, E, a, K, G = params
		du[1] = dq = λ*(1-q)*b*(1-G(v-p+E-a+K)) - β*q
		du[2] = db = α*λ*q*(1-b)*(1-G(v-p)) - δ*b
	end
end

# ╔═╡ 93b3af6e-604f-11eb-2033-fd341cb43bd0
begin
	a = 2; K=1; E=2; α=0.7; β=0.1; δ=0.1; v=3; λ=1; p=0.9
	G(x) = 0 ≤ x ≤ 10 ? 1/10 : 0 # uniform distribution on [0,10]
	params = [α, β, δ, λ, v, p, E, a, K, G]
	q0=0.4; b0=0.2; u0 = [q0, b0]
	tspan=(0.0,20.0)

	ode_prob = ODEProblem(ode_func!,u0,tspan,params)
end

# ╔═╡ 3caee5f6-5fe6-11eb-331e-ff5807f3a9e9
begin
	ode_sol = solve(ode_prob)
	plot(ode_sol,linewidth=2, xaxis="t", label=["q" "b"])
end

# ╔═╡ a915105a-6174-11eb-3f67-2ba80050dcdd
ode_sol

# ╔═╡ 0df0baae-6140-11eb-1894-e1e7794a085a
md"""
Phase plane view is a graphic of trajectories drawn asparametric curves in the xy-plane. 
"""

# ╔═╡ 172094d2-600d-11eb-1357-cd1eff253b16
plot(ode_sol, vars=(1,2), linewidth=2, xaxis="q", yaxis="b", title = "Phase Plane View")

# ╔═╡ e93fc7d4-6114-11eb-3dfd-a9322231d19a
md"""
## Something More
"""

# ╔═╡ edf5981c-6114-11eb-257d-27f51a688dae
begin
	function oss_rhs(u, params)
		q, b = u
		α, β, δ, λ, v, p, E, a, K, G = params
		du = zero(u)
		du[1] = λ*(1-q)*b*(1-G(v-p+E-a+K)) - β*q
		du[2] = α*λ*q*(1-b)*(1-G(v-p)) - δ*b
		return du
	end
end

# ╔═╡ 469d0f3e-616c-11eb-3237-9d9dbfe3444e
begin
	function oss_du(du,u,params,t)
		du .= oss_rhs(u,params)
	end
end

# ╔═╡ 50cad27a-616c-11eb-1e64-4be3a6c43bc2
begin
	oss_du_prob = ODEProblem(oss_du,u0,tspan,params)
	oss_du_sol = solve(oss_du_prob)
	plot(oss_du_sol,linewidth=2, xaxis="t", label=["q" "b"])
end

# ╔═╡ 8f703f42-616c-11eb-1e8a-7ff3fe3c078a
begin
	xs = 0:0.1:1
	ys = 0:0.1:1
	
	plot(oss_du_sol, vars=(1,2), xrange=[0,1], yrange=[0,1], linewidth=2,
     xaxis="q", yaxis="b", label="(q,b)", size=(600,600),
     title="Vector field and solutions with initial condition",
     titlefontsize=12);
	
	xxs = [x for x in xs for y in ys]
	yys = [y for x in xs for y in ys]

	oss_quiver(x, y) = Tuple(oss_rhs([x,y], params) ./ 5)

	quiver!(xxs, yys, quiver=oss_quiver)
end

# ╔═╡ bf02125c-616d-11eb-3bdf-29a036821041
plot(oss_du_sol,tspan=(0.0,50.0),linewidth=2, xaxis="t", label=["q" "b"])

# ╔═╡ 64ddccc4-6115-11eb-0a39-f14e241391b4
begin
	xyzt = plot(oss_du_sol, plotdensity=10000,lw=1.5)
	xy = plot(oss_du_sol, plotdensity=10000, vars=(1), label = "q")
	xz = plot(oss_du_sol, plotdensity=10000, vars=(2), label = "b")
	xyz = plot(oss_du_sol, plotdensity=10000, vars=(1,2))
	plot(plot(xyzt,xyz),plot(xy, xz, layout=(1,2),w=1), layout=(2,1))
end

# ╔═╡ d792732e-6178-11eb-3c7d-cd2c8b694608
md"""
The top-left plot is a combined  view of the time-evolution of each quantity $q=q(t)$ and $b=b(t)$. The bottom two are just the same views, but split into two different figures, one for each. The top-right plot is what we call a phase-plane plot. Is the plot of the parametrized curve $t -> (q(t), b(t))$ in que q x b plane. 
"""

# ╔═╡ a00c4848-616f-11eb-0a5b-d9c5189dff26
animate(oss_du_sol,lw=3,every=1, xaxis="t", label=["q" "b"])

# ╔═╡ Cell order:
# ╟─640a8b1e-60b3-11eb-13b8-87fdf01a662b
# ╟─5d20ce90-5f3e-11eb-13be-27ed778a5567
# ╟─404551cc-6131-11eb-21e7-affa5c8f7f83
# ╟─007db670-60b8-11eb-0d98-35fad3954d03
# ╠═8ae26d04-5f3e-11eb-22ba-33ff8ca44b3a
# ╟─18d751c2-60b8-11eb-3551-67ad3e2c0294
# ╠═cb0086b2-5fe5-11eb-3fe1-e91770ff6da2
# ╠═93b3af6e-604f-11eb-2033-fd341cb43bd0
# ╠═3caee5f6-5fe6-11eb-331e-ff5807f3a9e9
# ╠═a915105a-6174-11eb-3f67-2ba80050dcdd
# ╠═0df0baae-6140-11eb-1894-e1e7794a085a
# ╠═172094d2-600d-11eb-1357-cd1eff253b16
# ╟─e93fc7d4-6114-11eb-3dfd-a9322231d19a
# ╠═edf5981c-6114-11eb-257d-27f51a688dae
# ╠═469d0f3e-616c-11eb-3237-9d9dbfe3444e
# ╠═50cad27a-616c-11eb-1e64-4be3a6c43bc2
# ╠═8f703f42-616c-11eb-1e8a-7ff3fe3c078a
# ╠═bf02125c-616d-11eb-3bdf-29a036821041
# ╠═64ddccc4-6115-11eb-0a39-f14e241391b4
# ╟─d792732e-6178-11eb-3c7d-cd2c8b694608
# ╠═a00c4848-616f-11eb-0a5b-d9c5189dff26
