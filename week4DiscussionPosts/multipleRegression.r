# Load necessary libraries
library(ggplot2)
library(dplyr)
library(gridExtra)
library(plotly)

# Generate fake traffic data with additional factors
set.seed(123)
num_samples <- 50
speed_bumps <- runif(num_samples, min = 0, max = 10)  # Number of speed bumps per 10 meters
gated_community <- sample(c(FALSE, TRUE), num_samples, replace = TRUE)  # FALSE or TRUE for not in a gated community or in a gated community
school_present <- sample(c(FALSE, TRUE), num_samples, replace = TRUE)  # FALSE or TRUE for school not present or school present
speed_limit_signs <- runif(num_samples, min = 0, max = 10)  # Density of speed limit signs

# Simulated impact of factors on average speed
average_speed <- 25 - 2 * speed_bumps - 3 * as.numeric(gated_community) - 1.5 * speed_limit_signs - 5 * as.numeric(school_present) + rnorm(num_samples, mean = 0, sd = 5)

# Create a data frame
traffic_data <- data.frame(SpeedBumps = speed_bumps, GatedCommunity = gated_community, SchoolPresent = school_present, SpeedLimitSigns = speed_limit_signs, AverageSpeed = average_speed)

# Set a new color palette
my_palette <- c("#9b3c34", "#1e5079")

# Create each plot
plot1 <- ggplot(traffic_data, aes(x = SpeedBumps, y = AverageSpeed, color = factor(GatedCommunity))) +
  geom_point() +
  geom_smooth(method = "lm", aes(group = 1), linetype = "dashed", col = my_palette[1]) +
  labs(title = "Average Speed vs. Speed Bumps",
       x = "Number of Speed Bumps per 10 meters",
       y = "Average Speed (mph)",
       color = "Gated Community") +
  theme_minimal() +
  scale_color_manual(values = my_palette, labels = c("False", "True"))

plot2 <- ggplot(traffic_data, aes(x = SpeedLimitSigns, y = AverageSpeed, color = SpeedBumps)) +
  geom_point() +
  geom_smooth(method = "lm", aes(group = 1), linetype = "dashed", col = my_palette[1]) +
  labs(title = "Average Speed vs. Speed Limit Signs and Speed Bumps",
       x = "Density of Speed Limit Signs",
       y = "Average Speed (mph)",
       color = "Number of Speed Bumps") +
  theme_minimal() +
  scale_color_gradient(low = my_palette[1], high = my_palette[2])

plot3 <- ggplot(traffic_data, aes(x = SpeedLimitSigns, y = AverageSpeed, color = factor(SchoolPresent))) +
  geom_point() +
  geom_smooth(method = "lm", aes(group = 1), linetype = "dashed", col = my_palette[1]) +
  labs(title = "Average Speed vs. Speed Limit Signs",
       x = "Density of Speed Limit Signs",
       y = "Average Speed (mph)",
       color = "School Present") +
  theme_minimal() +
  scale_color_manual(values = my_palette, labels = c("False", "True"))

plot4 <- ggplot(traffic_data, aes(x = SpeedLimitSigns, y = AverageSpeed, color = factor(SchoolPresent), shape = factor(GatedCommunity), size = SpeedBumps)) +
  geom_point() +
  geom_smooth(method = "lm", aes(group = 1), linetype = "dashed", col = my_palette[1]) +
  labs(title = "Average Speed vs. Speed Limit Signs, School Presence, and Speed Bumps",
       x = "Density of Speed Limit Signs",
       y = "Average Speed (mph)",
       color = "School Present",
       shape = "Gated Community",
       size = "Number of Speed Bumps") +
  theme_minimal() +
  scale_color_manual(values = my_palette, labels = c("False", "True")) +
  scale_shape_manual(values = c(16, 17), labels = c("False", "True"))

# Arrange the plots in a grid
grid.arrange(plot1, plot2, plot3, plot4, ncol = 2)


# Create a 3D scatter plot with adjusted color and symbols for representation
plot_3d <- plot_ly(traffic_data, x = ~SpeedBumps, y = ~SpeedLimitSigns, z = ~AverageSpeed,
                   color = ~factor(SchoolPresent), symbol = ~factor(GatedCommunity),
                   type = "scatter3d", mode = "markers",
                   colors = c('#aa2f1adc', '#264c6b'),
                   symbols = c('circle', 'x'))

# Display the plot
plot_3d


