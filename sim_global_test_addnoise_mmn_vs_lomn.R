rm(list = ls())

# load packages

library("Rcpp")
library("RcppZiggurat")

# load functions

setwd("./replication_files")
sourceCpp("./src/fct.cpp")
source("./R/sim_functions.R")

# empty array to fetch results

.colnames = c("test_no_jump_one_noise", 
              "test_jump_one_noise_075_p",
              "test_jump_one_noise_100_p",
              "test_jump_one_noise_125_p",
              "test_jump_one_noise_150_p",
              "test_jump_one_noise_175_p",
              "test_jump_one_noise_200_p",
              "test_jump_one_noise_225_p",
              "test_jump_one_noise_075_n",
              "test_jump_one_noise_100_n",
              "test_jump_one_noise_125_n",
              "test_jump_one_noise_150_n",
              "test_jump_one_noise_175_n",
              "test_jump_one_noise_200_n",
              "test_jump_one_noise_225_n",
              "alpha_one_95",
              "beta_one_95_075_p",
              "beta_one_95_100_p",
              "beta_one_95_125_p",
              "beta_one_95_150_p",
              "beta_one_95_175_p",
              "beta_one_95_200_p",
              "beta_one_95_225_p",
              "beta_one_95_075_n",
              "beta_one_95_100_n",
              "beta_one_95_125_n",
              "beta_one_95_150_n",
              "beta_one_95_175_n",
              "beta_one_95_200_n",
              "beta_one_95_225_n",
              "test_no_jump_two_noise", 
              "test_jump_two_noise_075_p",
              "test_jump_two_noise_100_p",
              "test_jump_two_noise_125_p",
              "test_jump_two_noise_150_p",
              "test_jump_two_noise_175_p",
              "test_jump_two_noise_200_p",
              "test_jump_two_noise_225_p",
              "test_jump_two_noise_075_n",
              "test_jump_two_noise_100_n",
              "test_jump_two_noise_125_n",
              "test_jump_two_noise_150_n",
              "test_jump_two_noise_175_n",
              "test_jump_two_noise_200_n",
              "test_jump_two_noise_225_n",
              "alpha_two_95",
              "beta_two_95_075_p",
              "beta_two_95_100_p",
              "beta_two_95_125_p",
              "beta_two_95_150_p",
              "beta_two_95_175_p",
              "beta_two_95_200_p",
              "beta_two_95_225_p",
              "beta_two_95_075_n",
              "beta_two_95_100_n",
              "beta_two_95_125_n",
              "beta_two_95_150_n",
              "beta_two_95_175_n",
              "beta_two_95_200_n",
              "beta_two_95_225_n")

N = 5e3 # number of Monte Carlo samples

res = matrix(0, 
             nrow = N, 
             ncol = length(.colnames))
colnames(res) = .colnames

# next loop conducts the simulation for the setup with additive noise only

i = 1; e = 0
while(i <= N){
  print(i)
  res[i, ] = sim.global(n = 23400, # sample size
                        q = 0.0005, # noise level q = 0.0001, q = 0.0005 etc.
                        h = 3 -> h, # number of observations per time interval h = 2, 3, 4, 5, ...
                        q2c = 3 / sqrt(23400) # h / n : scaling constant for asymptotic variance in case of MMN
                        )
  if(any(is.na(res[i, ]))){
    e = e + 1
  }else{
    i = i + 1
  }
}
print(e)

saveRDS(res, 
        file = paste0("./global_q0005_95_boot_h", h, ".RDS"))