set.seed(12345)

pois_process <- function(num_arrivals, lambda) {
  arrival_time_stamps <- c() # vector of arrival times
  
  for(i in 1:num_arrivals) {
    inter_arrival_time <- rexp(n = 1, rate = lambda) # inter-arrival times ~ exp(lambda)
    
    if (i == 1) {
      temp <- 0
    } else {
      temp <- arrival_time_stamps[i-1] 
    }
    
    arrival_time <- sum(temp, inter_arrival_time) 
    # sum of N inter-arrival times is the arrival time for the Nth event
    arrival_time_stamps <- c(arrival_time_stamps, arrival_time) 
    # append arrival times to vector
  }
  
  Nt <- 1:length(arrival_time_stamps)
  plot(c(0, Nt) ~ c(0, arrival_time_stamps), type = 's')
  
}

