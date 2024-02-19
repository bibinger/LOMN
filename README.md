# LOMN
R code for replication of simulations from "Jump detection in high-frequency order prices"

Disclaimer:
This collection of R-code (augmented by cpp-functions) serves the reproduction of the 
simulations presented in the manuscript "Jump detection in high-frequency order prices" 
written by Markus Bibinger, Nikolaus Hautsch and Alexander Ristig. The latter author 
prepared this collection of R-code. Without permission of the author, the code must not 
be re-distributed or used for commercial purposes.


Software:
The code required for the reproduction of the simulations is (mainly) written in the R 
language and delivered in form of scripts. The software recommended below is available 
under the license GPL-3. The results presented in the manuscript were computed in R 
under version 4.0.1 — 'See Things Now'. The following packages were used: Rcpp 
(version: 1.0.4.6) as well as RcppZiggurat (version: 0.1.5). Moreover, the provided 
cpp-based-functions 'rep_col', 'rep_row', 'row_min' and 'row_max' originate from the 
R package Rfast (version: 1.9.9), written by Manos Papadakis, Michail Tsagris, 
Marios Dimitriadis, Stefanos Fafalios, Ioannis Tsamardinos, Matteo Fasiolo, 
Giorgos Borboudakis, John Burkardt, Changliang Zou, Kleanthi Lakiotaki 
and Christina Chatzipantsiou. (2020). 
Rfast: A Collection of Efficient and Extremely Fast R Functions. R package version 1.9.9.
https://CRAN.R-project.org/package=Rfast


Instructions to reproduce the simulation studies:
The simulation studies can be reproduced by running the corresponding scripts
'sim_global_test_one_only.R','sim_global_test_mmn_vs_lomn.R' and 'sim_local.R'. 
These files in turn load the functions of the R-script 'sim_functions.R' and the cpp-script 
'fct.cpp'. The results have to be summarized by averaging, e.g., by colMeans().
