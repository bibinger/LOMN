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
              "jump_time_one_050_p",
              "jump_time_one_075_p",
              "jump_time_one_100_p",
              "jump_time_one_125_p",
              "jump_time_one_150_p",
              "jump_time_one_175_p",
              "jump_time_one_200_p",
              "jump_time_one_225_p",
              "jump_time_one_250_p",
              "jump_time_one_275_p",
              "jump_time_one_300_p",
              "jump_time_one_050_n",
              "jump_time_one_075_n",
              "jump_time_one_100_n",
              "jump_time_one_125_n",
              "jump_time_one_150_n",
              "jump_time_one_175_n",
              "jump_time_one_200_n",
              "jump_time_one_225_n",
              "jump_time_one_250_n",
              "jump_time_one_275_n",
              "jump_time_one_300_n",
              "test_no_jump_one_noise", 
              "test_jump_one_noise_050_p",
              "test_jump_one_noise_075_p",
              "test_jump_one_noise_100_p",
              "test_jump_one_noise_125_p",
              "test_jump_one_noise_150_p",
              "test_jump_one_noise_175_p",
              "test_jump_one_noise_200_p",
              "test_jump_one_noise_225_p",
              "test_jump_one_noise_250_p",
              "test_jump_one_noise_275_p",
              "test_jump_one_noise_300_p",
              "test_jump_one_noise_050_n",
              "test_jump_one_noise_075_n",
              "test_jump_one_noise_100_n",
              "test_jump_one_noise_125_n",
              "test_jump_one_noise_150_n",
              "test_jump_one_noise_175_n",
              "test_jump_one_noise_200_n",
              "test_jump_one_noise_225_n",
              "test_jump_one_noise_250_n",
              "test_jump_one_noise_275_n",
              "test_jump_one_noise_300_n",
              "alpha_one_95",
              "beta_one_95_050_p",
              "beta_one_95_075_p",
              "beta_one_95_100_p",
              "beta_one_95_125_p",
              "beta_one_95_150_p",
              "beta_one_95_175_p",
              "beta_one_95_200_p",
              "beta_one_95_225_p",
              "beta_one_95_250_p",
              "beta_one_95_275_p",
              "beta_one_95_300_p",
              "beta_one_95_050_n",
              "beta_one_95_075_n",
              "beta_one_95_100_n",
              "beta_one_95_125_n",
              "beta_one_95_150_n",
              "beta_one_95_175_n",
              "beta_one_95_200_n",
              "beta_one_95_225_n",
              "beta_one_95_250_n",
              "beta_one_95_275_n",
              "beta_one_95_300_n",
              "jump_time_two_050_p",
              "jump_time_two_075_p",
              "jump_time_two_100_p",
              "jump_time_two_125_p",
              "jump_time_two_150_p",
              "jump_time_two_175_p",
              "jump_time_two_200_p",
              "jump_time_two_225_p",
              "jump_time_two_250_p",
              "jump_time_two_275_p",
              "jump_time_two_300_p",
              "jump_time_two_050_n",
              "jump_time_two_075_n",
              "jump_time_two_100_n",
              "jump_time_two_125_n",
              "jump_time_two_150_n",
              "jump_time_two_175_n",
              "jump_time_two_200_n",
              "jump_time_two_225_n",
              "jump_time_two_250_n",
              "jump_time_two_275_n",
              "jump_time_two_300_n",
              "test_no_jump_two_noise", 
              "test_jump_two_noise_050_p",
              "test_jump_two_noise_075_p",
              "test_jump_two_noise_100_p",
              "test_jump_two_noise_125_p",
              "test_jump_two_noise_150_p",
              "test_jump_two_noise_175_p",
              "test_jump_two_noise_200_p",
              "test_jump_two_noise_225_p",
              "test_jump_two_noise_250_p",
              "test_jump_two_noise_275_p",
              "test_jump_two_noise_300_p",
              "test_jump_two_noise_050_n",
              "test_jump_two_noise_075_n",
              "test_jump_two_noise_100_n",
              "test_jump_two_noise_125_n",
              "test_jump_two_noise_150_n",
              "test_jump_two_noise_175_n",
              "test_jump_two_noise_200_n",
              "test_jump_two_noise_225_n",
              "test_jump_two_noise_250_n",
              "test_jump_two_noise_275_n",
              "test_jump_two_noise_300_n",
              "alpha_two_95",
              "beta_two_95_050_p",
              "beta_two_95_075_p",
              "beta_two_95_100_p",
              "beta_two_95_125_p",
              "beta_two_95_150_p",
              "beta_two_95_175_p",
              "beta_two_95_200_p",
              "beta_two_95_225_p",
              "beta_two_95_250_p",
              "beta_two_95_275_p",
              "beta_two_95_300_p",
              "beta_two_95_050_n",
              "beta_two_95_075_n",
              "beta_two_95_100_n",
              "beta_two_95_125_n",
              "beta_two_95_150_n",
              "beta_two_95_175_n",
              "beta_two_95_200_n",
              "beta_two_95_225_n",
              "beta_two_95_250_n",
              "beta_two_95_275_n",
              "beta_two_95_300_n")

N = 5e3 # number of Monte Carlo samples

res = matrix(0, 
             nrow = N, 
             ncol = length(.colnames))
colnames(res) = .colnames

# next loop conducts the simulation

i = 1; e = 0
while(i <= N){
  print(i)
  res[i, ] = sim.global(n = 23400, # sample size
                        q = 0.0001, # noise level q = 0.0001, q = 0.0005 etc.
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
        file = paste0("./global_q0001_95_boot_h", h, ".RDS"))