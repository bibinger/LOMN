rm(list = ls())

# load packages

library("Rcpp")
library("RcppZiggurat")

# load functions

setwd("./replication_files")
sourceCpp("./src/fct.cpp")
source("./R/sim_functions.R")

# empty array to fetch results

.colnames = c("q.two",
              "test_no_jump_ask_noise", 
              "test_jump_ask_noise_075_p",
              "test_jump_ask_noise_100_p",
              "test_jump_ask_noise_125_p",
              "test_jump_ask_noise_150_p",
              "test_jump_ask_noise_175_p",
              "test_jump_ask_noise_200_p",
              "test_jump_ask_noise_225_p",
              "test_jump_ask_noise_075_n",
              "test_jump_ask_noise_100_n",
              "test_jump_ask_noise_125_n",
              "test_jump_ask_noise_150_n",
              "test_jump_ask_noise_175_n",
              "test_jump_ask_noise_200_n",
              "test_jump_ask_noise_225_n",
              "alpha_ask_95",
              "beta_ask_95_075_p",
              "beta_ask_95_100_p",
              "beta_ask_95_125_p",
              "beta_ask_95_150_p",
              "beta_ask_95_175_p",
              "beta_ask_95_200_p",
              "beta_ask_95_225_p",
              "beta_ask_95_075_n",
              "beta_ask_95_100_n",
              "beta_ask_95_125_n",
              "beta_ask_95_150_n",
              "beta_ask_95_175_n",
              "beta_ask_95_200_n",
              "beta_ask_95_225_n",
              "test_no_jump_bid_noise", 
              "test_jump_bid_noise_075_p",
              "test_jump_bid_noise_100_p",
              "test_jump_bid_noise_125_p",
              "test_jump_bid_noise_150_p",
              "test_jump_bid_noise_175_p",
              "test_jump_bid_noise_200_p",
              "test_jump_bid_noise_225_p",
              "test_jump_bid_noise_075_n",
              "test_jump_bid_noise_100_n",
              "test_jump_bid_noise_125_n",
              "test_jump_bid_noise_150_n",
              "test_jump_bid_noise_175_n",
              "test_jump_bid_noise_200_n",
              "test_jump_bid_noise_225_n",
              "alpha_bid_95",
              "beta_bid_95_075_p",
              "beta_bid_95_100_p",
              "beta_bid_95_125_p",
              "beta_bid_95_150_p",
              "beta_bid_95_175_p",
              "beta_bid_95_200_p",
              "beta_bid_95_225_p",
              "beta_bid_95_075_n",
              "beta_bid_95_100_n",
              "beta_bid_95_125_n",
              "beta_bid_95_150_n",
              "beta_bid_95_175_n",
              "beta_bid_95_200_n",
              "beta_bid_95_225_n",
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

# next loop conducts the simulation for the setup with additive noise and rounding errors

N = 5e3 # number of Monte Carlo samples

res = matrix(0, 
             nrow = N, 
             ncol = length(.colnames))
colnames(res) = .colnames

# next loop conducts the simulation

i = 1; e = 0
while(i <= N){
  print(i)
  res[i, ] = sim.global.round(n = 23400, # sample size
                              q = 0.0005, # noise level q = 0.0005 etc.
                              h = 5 -> h, # number of observations per time interval h = 2, 3, 4, 5, ...
                              q2c = 5 / sqrt(23400), # h / n : scaling constant for asymptotic variance in case of MMN
                              S0 = 50, # initial efficient price
                              tsize = 0.01 # tick size
                              )
  if(any(is.na(res[i, ]))){
    e = e + 1
  }else{
    i = i + 1
  }
}
print(e)

saveRDS(res, 
        file = paste0("./global_round_q0005_95_boot_h", h, ".RDS"))