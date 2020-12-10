library(tidyverse)
source("queries.R")

get_pool_name <- function(dat) {
  
  paste0(dat %>%
           mutate(perc = paste0(round(as.numeric(denormWeight)/sum(as.numeric(denormWeight)),2)*100, "%", " ", symbol)) %>%
           pull(perc), collapse = " ")
  
}

get_pool_names <- function(dat) {
  
  names <- unlist(lapply(dat$data$pools$tokens, get_pool_name))
  fin <- c(names[1])
  
  for(n in 2:length(names)){
    
    cntr <- 0
    for(i in 1:(n-1)){
      
      if(names[n] == names[i]) {
        
        cntr = cntr + 1
        
      }
      
    }
    
    if(cntr > 0) {
      
      fin <- append(fin, paste0(names[n], " ", cntr + 1))
      
    } else {
      
      fin <- append(fin, names[n])
      
    }
    
  }
  
  return(fin)
  
}

get_pool_stats <- function(dat, pool) {
  
  ind = which(get_pool_names(dat) == pool)
  print(get_pool_names(dat))
  li <- list(
    "liquidity" = round(as.numeric(dat$data$pools[ind, "liquidity"]),2),
    "swapFee" = round(as.numeric(dat$data$pools[ind, "swapFee"]),2),
    "swapCount" = round(as.numeric(dat$data$pools[ind, "swapsCount"]),2),
    "totalSwapFee" = round(as.numeric(dat$data$pools[ind, "totalSwapFee"]),2),
    "totalSwapVolume" = round(as.numeric(dat$data$pools[ind, "totalSwapVolume"]),2)
  )
  
  paste0("Liquity: ", li["liquidity"], "\n",
      "Swap Fee: ", li["swapFee"], "\n",
      "Swap Count: ", li["swapCount"], "\n",
      "Total Swap Fee: ", li["totalSwapFee"], "\n",
      "Total Swap Volume: ", li["totalSwapVolume"], "\n")
  
}

# data <- private$data$pools$tokens[[1]]
# 
# paste0(data %>%
#   mutate(perc = paste0(round(as.numeric(denormWeight)/sum(as.numeric(denormWeight)),2)*100, "%", " ", symbol)) %>%
#   pull(perc), collapse = " ")
# 
# 
# pool_names <- lapply(private$data$pools$tokens, get_pool_name)
# 
# private_data <- list(
#   "pool_names" = pool_names,
#   "swaps" = 
# )
# 
# 
# private$data$pools$swaps[[1]] %>%
#   mutate(day = as.Date(as.POSIXct(timestamp, origin="1970-01-01"))) %>%
#   group_by(day) %>%
#   summarize(su)
# 
# View(private$data$pools)








