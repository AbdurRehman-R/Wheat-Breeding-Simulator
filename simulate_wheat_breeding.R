rm(list = ls())
set.seed(123)
library(AlphaSimR)

# Founder wheat population and trait
nFounders <- 100
nChr <- 10
segSitesPerChr <- 50

founderPop <- quickHaplo(nInd = nFounders,
                         nChr = nChr,
                         segSites = segSitesPerChr)

SP <- SimParam$new(founderPop)
SP$addTraitA(nQtlPerChr = 10, mean = 0, var = 1)
SP$setSexes("no")

# Initial population (cycle 0) and phenotypes
h2 <- 0.3
reps <- 2
pop <- newPop(founderPop, simParam = SP)
pop <- setPheno(pop, h2 = h2, reps = reps)
mean(pop@gv)
mean(pop@pheno)

# Breeding loop: selecting best lines by phenotype, self them, re-phenotype, and recording mean genetic value each cycle.

nCycles <- 10
selectProp <- 0.1
mean_gv <- numeric(nCycles + 1)
mean_gv <- mean(pop@gv)
currentPop <- pop

for(cycle in 1:nCycles){
  nSelected <- ceiling(selectProp * currentPop@nInd)
  selected <- selectInd(pop = currentPop,
                        use = "pheno",
                        nInd = nSelected)
  nextPop <- self(pop = selected,
                  nProgeny = 5)
  nextPop <- setPheno(pop = nextPop,
                      h2 = h2,
                      reps = reps)
  mean_gv[cycle + 1] <- mean(nextPop@gv)
  currentPop <- nextPop
}

# Plotting genetic gain

cycle_index <- 0:nCycles

plot(cycle_index, mean_gv,
     type = "b",
     xlab = "Cycle",
     ylab = "Mean genetic value",
     main = "Genetic gain across cycles")

# Saving results as CSV

cycle_index <- 0:nCycles

results <- data.frame(
  cycle = cycle_index,
  mean_gv = mean_gv
)

write.csv(results, file = "wheat_genetic_gain.csv",
          row.names = FALSE)

# Saving the plot as PNG

png("genetic_gain_plot.png", width = 800, height = 600)

plot(cycle_index, mean_gv,
     type = "b",
     xlab = "Cycle",
     ylab = "Mean genetic value",
     main = "Genetic gain across cycles")

dev.off()
