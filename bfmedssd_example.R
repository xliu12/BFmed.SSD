# Sample size determination (SSD) for testing mediation with the mediation Bayes factor

# illustrative example

# The R functions
source("functions_BFmed_SSD.R")


# Standardized path coefficients in the simple mediation model
# Liu et al. (2019) Example 1
a <- 0.25
b <- 0.26
cp <- 0.16



# Fixed effect sizes ------------
res1 <- BFmed.SSD(
  N = seq(100, 200, by=5), 
  std.a = 0.25, std.b = 0.26, std.cp = 0.16, 
  Design.PriorOdds.a = c(1/10, 1/3, 1), Design.PriorOdds.b = 1,
  Analysis.PriorOdds.a = 1, Analysis.PriorOdds.b = 1,
  cutoff.BF = 3, absolute.cutoff = TRUE,
  cutoff.FPR = 0.05, relative.cutoff = TRUE,
  R = 1e4, seed = 12345
) 

# Table
res1 

# Plot 
plot.true.positive.med( res1 )
plot.false.positive.med( res1 )


# Uncertainty in effect sizes --------
ustd.a <- .194
std.a <- .250
# std.a/ustd.a = s_x / s_y
# also holds for the standard error and confidence limits
se_ustd.a <- 0.083 # 
se_ustd.a * (std.a/ustd.a) -> se_std.a

ustd.b <- 0.089
std.b <- .26 # .258 approximately .26
se_ustd.b <- 0.038
se_ustd.b * (std.b/ustd.b) -> se_std.b

ustd.cp <- 0.042
std.cp <- 0.16 
se_ustd.cp <- 0.029
se_ustd.cp * (std.cp/ustd.cp) -> se_std.cp


res2 <- BFmed.SSD(
  N = seq(100, 400, by=5), 
  std.a = 0.25, std.b = 0.26, std.cp = 0.16, 
  uncertain.effect = TRUE,
  sigma.a = se_std.a, sigma.b = se_std.b, sigma.cp = se_std.cp,
  Design.PriorOdds.a = c(1/10, 1/3, 1), Design.PriorOdds.b = 1,
  Analysis.PriorOdds.a = 1, Analysis.PriorOdds.b = 1,
  cutoff.BF = 3, absolute.cutoff = TRUE,
  cutoff.FPR = 0.05, relative.cutoff = TRUE,
  R = 1e4, seed = 12345
) 


# Table
res2

# Plot 
plot.true.positive.med( res2 )
plot.false.positive.med( res2 )
