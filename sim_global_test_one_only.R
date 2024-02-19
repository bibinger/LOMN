rm(list = ls())

# load packages

library("Rcpp")
library("RcppZiggurat")

# load functions

setwd("./replication_files")
sourceCpp("./src/fct.cpp")
source("./R/sim_functions.R")

# empty array to fetch results

.colnames = c("jump_time",
              "jump_time_one_010_p",
              "jump_time_one_015_p",
              "jump_time_one_020_p",
              "jump_time_one_025_p",
              "jump_time_one_030_p",
              "jump_time_one_050_p",
              "jump_time_one_010_n",
              "jump_time_one_015_n",
              "jump_time_one_020_n",
              "jump_time_one_025_n",
              "jump_time_one_030_n",
              "jump_time_one_050_n",
              "test_no_jump_one_noise", 
              "test_jump_one_noise_010_p",
              "test_jump_one_noise_015_p",
              "test_jump_one_noise_020_p",
              "test_jump_one_noise_025_p",
              "test_jump_one_noise_030_p",
              "test_jump_one_noise_050_p",
              "test_jump_one_noise_010_n",
              "test_jump_one_noise_015_n",
              "test_jump_one_noise_020_n",
              "test_jump_one_noise_025_n",
              "test_jump_one_noise_030_n",
              "test_jump_one_noise_050_n",
              "alpha_one_95",
              "beta_one_95_010_p",
              "beta_one_95_015_p",
              "beta_one_95_020_p",
              "beta_one_95_025_p",
              "beta_one_95_030_p",
              "beta_one_95_050_p",
              "beta_one_95_010_n",
              "beta_one_95_015_n",
              "beta_one_95_020_n",
              "beta_one_95_025_n",
              "beta_one_95_030_n",
              "beta_one_95_050_n")

N = 5e3 # number of Monte Carlo samples

res = matrix(0, 
             nrow = N, 
             ncol = length(.colnames))
colnames(res) = .colnames

# next loop conducts the simulation

i = 1; e = 0
while(i <= N){
  print(i)
  res[i, ] = sim.global.one(n = 23400, # sample size
                            q = 0.0001 # noise level q = 0.0001, etc. 
                            ) 
  if(any(is.na(res[i, ]))){
    e = e + 1
  }else{
    i = i + 1
  }
}
print(e)

saveRDS(res, 
        file = "global_q0001_one.RDS")