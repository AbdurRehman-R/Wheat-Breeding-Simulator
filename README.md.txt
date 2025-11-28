Wheat Breeding Simulator with AlphaSimR
This project simulates a simple wheat line-breeding program using the AlphaSimR package in R. The goal is to follow a self-pollinated wheat population over multiple selection cycles, visualize mean genetic value across cycles, and show how genetic gain eventually plateaus as genetic variance is used up.

The simulation starts from 100 founder lines on 10 chromosomes with one additive trait whose genetic values are centered around zero with moderate variance. In each of 10 cycles, the top 10% of lines are selected based on phenotype, selfed to produce progeny, re-phenotyped, and the mean true genetic value is recorded.

Main files:

simulate_wheat_breeding.R – core script that sets up founders, runs the selection + selfing loop, and saves outputs.[attached_file:file:42]

wheat_breeding_simulator.Rmd (and HTML) – R Markdown report explaining the methods, code, and results.

wheat_genetic_gain.csv – table of cycle number and mean genetic value.

genetic_gain_plot.png – plot of genetic gain across cycles.

How to run:

Open the project in RStudio with R and AlphaSimR installed.​

Run simulate_wheat_breeding.R from top to bottom, or knit the R Markdown file to reproduce the analysis and plots.