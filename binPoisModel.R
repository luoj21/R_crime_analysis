set.seed(123)

binPois <- function(n, prob, lambda) {
  y <- rpois(n, lambda = lambda)
  x_y <- rbinom(n, size = y, prob = prob) # x given y
  
  x_y_df <- as.data.frame(x_y)
  
  graph <- ggplot(data = x_y_df, aes(x_y)) +
    geom_histogram(bins = 20, alpha = 0.6, fill = "red") +
    theme_minimal() +
    ggtitle(paste0("Estimated Distribution of ", n, " Incidents")) + 
    theme(plot.title = element_text(hjust = 0.5))
  
  return(graph)
}
