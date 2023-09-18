# Load necessary libraries
library(ggplot2)
library(dplyr)

# Generate fake traffic data
set.seed(123)
num_samples <- 50
speed_bumps <- runif(num_samples, min = 0, max = 10)  # Number of speed bumps per 10 meters
average_speed <- 25 - 2 * speed_bumps + rnorm(num_samples, mean = 0, sd = 5)  # Average speed of cars

# Create a data frame
traffic_data <- data.frame(SpeedBumps = speed_bumps, AverageSpeed = average_speed)

# Show the first few rows of the data
head(traffic_data)

# Simple Linear Regression (SLR)
slr_model <- lm(AverageSpeed ~ SpeedBumps, data = traffic_data)
summary(slr_model)

# Visualize SLR
ggplot(traffic_data, aes(x = SpeedBumps, y = AverageSpeed)) +
  geom_point() +
  geom_smooth(method = "lm", col = "blue") +
  labs(title = "Simple Linear Regression",
       x = "Number of Speed Bumps per 10 meters",
       y = "Average Speed (mph)")
