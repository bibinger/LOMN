rm(list = ls())

# load packages

library("Rcpp")
library("RcppZiggurat")

# load functions

setwd("./replication_files")
sourceCpp("./src/fct.cpp")
source("./R/sim_functions.R")

# empty array to fetch results

.colnames = c("alpha_boot_one",
              "beta_boot_one_050p",
              "beta_boot_one_750p",
              "beta_boot_one_100p",
              "beta_boot_one_125p",
              "beta_boot_one_150p",
              "beta_boot_one_200p",
              "beta_boot_one_050n",
              "beta_boot_one_750n",
              "beta_boot_one_100n",
              "beta_boot_one_125n",
              "beta_boot_one_150n",
              "beta_boot_one_200n",
              "alpha_boot_two",
              "beta_boot_two_050p",
              "beta_boot_two_750p",
              "beta_boot_two_100p",
              "beta_boot_two_125p",
              "beta_boot_two_150p",
              "beta_boot_two_200p",
              "beta_boot_two_050n",
              "beta_boot_two_750n",
              "beta_boot_two_100n",
              "beta_boot_two_125n",
              "beta_boot_two_150n",
              "beta_boot_two_200n",
              "alpha_boot_left_one",
              "beta_boot_left_one_050p",
              "beta_boot_left_one_750p",
              "beta_boot_left_one_100p",
              "beta_boot_left_one_125p",
              "beta_boot_left_one_150p",
              "beta_boot_left_one_200p",
              "beta_boot_left_one_050n",
              "beta_boot_left_one_750n",
              "beta_boot_left_one_100n",
              "beta_boot_left_one_125n",
              "beta_boot_left_one_150n",
              "beta_boot_left_one_200n",
              "alpha_boot_left_two",
              "beta_boot_left_two_050p",
              "beta_boot_left_two_750p",
              "beta_boot_left_two_100p",
              "beta_boot_left_two_125p",
              "beta_boot_left_two_150p",
              "beta_boot_left_two_200p",
              "beta_boot_left_two_050n",
              "beta_boot_left_two_750n",
              "beta_boot_left_two_100n",
              "beta_boot_left_two_125n",
              "beta_boot_left_two_150n",
              "beta_boot_left_two_200n",
              "alpha_boot_right_one",
              "beta_boot_right_one_050p",
              "beta_boot_right_one_750p",
              "beta_boot_right_one_100p",
              "beta_boot_right_one_125p",
              "beta_boot_right_one_150p",
              "beta_boot_right_one_200p",
              "beta_boot_right_one_050n",
              "beta_boot_right_one_750n",
              "beta_boot_right_one_100n",
              "beta_boot_right_one_125n",
              "beta_boot_right_one_150n",
              "beta_boot_right_one_200n",
              "alpha_boot_right_two",
              "beta_boot_right_two_050p",
              "beta_boot_right_two_750p",
              "beta_boot_right_two_100p",
              "beta_boot_right_two_125p",
              "beta_boot_right_two_150p",
              "beta_boot_right_two_200p",
              "beta_boot_right_two_050n",
              "beta_boot_right_two_750n",
              "beta_boot_right_two_100n",
              "beta_boot_right_two_125n",
              "beta_boot_right_two_150n",
              "beta_boot_right_two_200n")

N = 5e3 # number of Monte Carlo samples

res = matrix(0, 
             nrow = N, 
             ncol = length(.colnames))
colnames(res) = .colnames

# next loop conducts the simulation

i = 1; e = 0
while(i <= N){
  print(i)
  res[i, ] = sim.local(n = 23400, # sample size
                       q = 0.0001, # noise level q = 0.0001, q = 0.0005 etc.
                       h = 4 # number of observations per time interval h = 2, 3, 4, 5, ...
                       )
  if(all(!is.na(res[i, ]))){
    i = i + 1
  }else{
    e = e + 1
  }
}

print(e)
saveRDS(res, 
        file = "./local_q0001_h4.RDS")