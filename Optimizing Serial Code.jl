A = rand(100,100)
B = rand(100,100)
C = rand(100,100)

# using BenchmarkTools

# Defining Function for columns

function inner_rows!(C,A,B)
  for i ∈ 1:100, j ∈ 1:100
    C[i,j] = A[i,j] + B[i,j]
  end
end
@btime inner_rows!(C,A,B)


# Next function for rows
function inner_cols!(C,A,B)
  for j ∈ 1:100, i ∈ 1:100
    C[i,j] = A[i,j] + B[i,j]
  end
end
@btime inner_cols!(C,A,B)

A = rand(100, 100)
typeof(A)
# creates an array

function inner_alloc!(C,A,B)
  for j ∈ 1:100, i ∈ 1:100
    val = [A[i,j] + B[i,j]]
    C[i,j] = val[1]
  end
end
@btime inner_alloc!(C,A,B)


# Does not create an array
function inner_noalloc!(C,A,B)
  for j ∈ 1:100, i ∈ 1:100
    val = A[i,j] + B[i,j]
    C[i,j] = val[1]
  end
end
@btime inner_noalloc!(C,A,B)

# Note that one can use the StaticArrays.jl library to get statically-sized arrays and thus arrays which are stack-allocated
# using StaticArrays

val = SVector{3,Float64}(1.0, 2.1, 3.1) 

typeof(val)

# like before

function static_inner_alloc!(C,A,B)
  for j ∈ 1:100, i ∈ 1:100
    val = @SVector [A[i,j] + B[i,j]]
    C[i,j] = val[1]
  end
end
@btime static_inner_alloc!(C,A,B)


@macroexpand @SVector [A[i,j] + B[i,j]]


# Mutation to Avoid Heap Allocations
# 3 allocating version
function inner_noalloc!(C,A,B)
  for j ∈ 1:100, i ∈ 1:100
    val = A[i,j] + B[i,j]
    C[i,j] = val[1]
  end
end

@btime inner_noalloc!(C,A,B)

# Non Allocating version

function inner_alloc(A,B)
  C = similar(A)
  for j in 1:100, i in 1:100
    val = A[i,j] + B[i,j]
    C[i,j] = val[1]
  end
end
@btime inner_alloc(A,B)

# With C
function inner_alloc(A,B)
  C = similar(A)
  for j in 1:100, i in 1:100
    val = A[i,j] + B[i,j]
    C[i,j] = val[1]
  end
  C
end
@btime inner_alloc(A,B)

A
B
@btime sum([A + B for k ∈ 1:10])


# Julia's Broadcasting Mechanism

A = [1:10]

A .+ B .+ C;

map((a,b,c)->a+b+c,A,B,C);



function unfused(A,B,C)
  tmp = A .+ B
  tmp .+ C
end
@btime unfused(A,B,C)

fused(A,B,C) = A .+ B .+ C
@btime fused(A,B,C)

D = similar(A)
fused!(D,A,B,C) = (D .= A .+ B .+ C)
@btime fused!(D,A,B,C);




# Heap Allocations from Slicing


A[50,50]
@show A[1]

E = @view A[1:5,1:5]
E[1] = 2.0
@show A[1]

A[1] = 2.0



# Asymptopic Cost of Heap Allocations

# using LinearAlgebra, BenchmarkTools
function alloc_timer(n)
    A = rand(n,n)
    B = rand(n,n)
    C = rand(n,n)
    t1 = @belapsed $A .* $B
    t2 = @belapsed ($C .= $A .* $B)
    t1,t2
end
ns = 2 .^ (2:11)
res = [alloc_timer(n) for n in ns]
alloc   = [x[1] for x in res]
noalloc = [x[2] for x in res]

using Plots
plot(ns,alloc,label="=",xscale=:log10,yscale=:log10,legend=:bottomright,
     title="Micro-optimizations matter for BLAS1")
plot!(ns,noalloc,label=".=")


@btime 2 .+ 3 .* 6
@btime 2+3*6






# using LinearAlgebra, BenchmarkTools
function alloc_timer(n)
    A = rand(n,n)
    B = rand(n,n)
    C = rand(n,n)
    t1 = @belapsed $A*$B
    t2 = @belapsed mul!($C,$A,$B)
    t1,t2
end
ns = 2 .^ (2:7)
res = [alloc_timer(n) for n in ns]
alloc   = [x[1] for x in res]
noalloc = [x[2] for x in res]

# using Plots
plot(ns,alloc,label="*",xscale=:log10,yscale=:log10,legend=:bottomright,
     title="Micro-optimizations only matter for small matmuls")
plot!(ns,noalloc,label="mul!")

#######################################################

# Julia's Type Inference and the Compiler


#######################################################




