capture program drop entropy_index
program define entropy_index
    syntax varlist(min=2 numeric) [if] [in], GENerate(name)

    // Mark sample
    marksample touse

    // Step 1: Normalize Indicators (Min-Max Normalization)
    foreach var of local varlist {
        quietly summarize `var' if `touse'
        local min_`var' = r(min)  // Store minimum value
        local max_`var' = r(max)  // Store maximum value
        gen norm_`var' = (`var' - `min_`var'') / (`max_`var'' - `min_`var'') if `touse'
    }

    // Step 2: Compute Proportions
    foreach var of local varlist {
        egen total_norm_`var' = total(norm_`var') if `touse'
        gen prop_`var' = norm_`var' / total_norm_`var' if `touse'
    }

    // Step 3: Calculate Entropy
    egen n = total(1) if `touse'  // Total number of observations
    gen k = 1 / ln(n) if `touse'  // Scaling constant

    foreach var of local varlist {
        gen ln_prop_`var' = ln(prop_`var' + 1e-6) if `touse'  // Add small constant to avoid log(0)
        gen entropy_`var' = -k * prop_`var' * ln_prop_`var' if `touse'
        egen e_`var' = total(entropy_`var') if `touse'
    }

    // Step 4: Compute Divergence and Weights
    foreach var of local varlist {
        gen divergence_`var' = 1 - e_`var' if `touse'
    }

    egen total_divergence = rowtotal(`=subinstr("`varlist'", " ", " divergence_", .)') if `touse'

    foreach var of local varlist {
        gen weight_`var' = divergence_`var' / total_divergence if `touse'
    }

    // Step 5: Construct the Composite Index
    gen `generate' = 0 if `touse'
    foreach var of local varlist {
        replace `generate' = `generate' + weight_`var' * norm_`var' if `touse'
    }
end