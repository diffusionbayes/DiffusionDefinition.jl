@diffusion_process FitzHughNagumoConjug{T} begin
    :dimensions
    process --> 2
    wiener --> 1

    :parameters
    (ϵ, s, γ, β, σ) --> T

    #=
    :conjugate
    phi(t, x) -->(
        (-x[2],),
        (x[1]-x[1]^3+(1-3*x[1]^2)*x[2],),
        (one(x[1]),),
        (-x[1],),
        (zero(x[1]),),
        (zero(x[1]),),
    )
    nonhypo(x) --> x[2:2]
    num_non_hypo --> 1
    =#

    :additional
    constdiff --> true
end

DiffusionDefinition.b(t, x, P::FitzHughNagumoConjug) = @SVector [
    x[2],
    (
        (P.ϵ - P.γ)*x[1]
        - P.ϵ*(x[1]^3 + (3.0*x[1]^2 - 1.0)*x[2])
        + P.s
        - P.β
        - x[2]
    )
]

σ(t, x, P::FitzHughNagumoConjug) = @SMatrix [0.0; P.σ]
