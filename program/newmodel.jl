using Plots
using DifferentialEquations

r₀ = 184/56
θ₀ = 0.0
tspan = (0, 45.0)
boat_r = Float64[0.0, 45.0]
fi = Float64[3*π/4]

function ode_fn(du,u, p, t)
    du[1] = 1
    du[2] =  sqrt(20.16) / u[1]
end

prob = ODEProblem(ode_fn, [r₀, θ₀], tspan)
sol = solve(prob, dtmax=0.01)
r = [u[1] for u in sol.u]
θ = [u[2] for u in sol.u]
intersection_r = 0

for (i,θ) in enumerate(θ)
    if (round(θ, digits=2) == round(fi[1], digits=2))
        global intersection_r = r[i]
        break
    end
end

plt1 = plot(proj = :polar, aspect_ratio=:equal, dpi=300, title="Задача о погоне",legend=true)
plot!(plt1, θ, r, label="Траектория катера", color=:green)
plot!(plt1, [fi], boat_r, label="Траектория лодки", color=:red)
plot!( plt1, [fi], [intersection_r], seriestype = :scatter, label="Точка пересечения", color=:blue)
savefig(plt1, "model1.png")

r₀ = 184/36
θ₀ = -pi
prob = ODEProblem(ode_fn, [r₀, θ₀], tspan)
sol = solve(prob, dtmax=0.01)
r = [u[1] for u in sol.u]
θ = [u[2] for u in sol.u]

for (i,θ) in enumerate(θ)
    if (round(θ, digits=2) == round(fi[1], digits=2))
        global intersection_r = r[i]
        break
    end
end

plt2 = plot(proj = :polar, aspect_ratio=:equal, dpi=300, title="Задача о погоне",legend=true)
plot!(plt2, θ, r, label="Траектория катера", color=:green)
plot!(plt2, [fi], boat_r, label="Траектория лодки", color=:red)
plot!( plt2, [fi], [intersection_r], seriestype = :scatter, label="Точка пересечения", color=:blue)
savefig(plt2, "model2.png")
