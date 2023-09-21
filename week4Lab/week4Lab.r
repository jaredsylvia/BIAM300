# Load necessary libraries
library(ggplot2)
library(dplyr)
library(gridExtra)

# Data

Y <- c(90, 66, 78, 65, 65, 60, 63, 72, 54, 81, 58, 71, 70, 92) # math final exam score (%)
X1 <- c(82, 66, 72, 59, 86, 50, 60, 91, 46, 80, 68, 58, 88, 82) # math coursework score (%)
math <- c("yes", "no", "yes", "yes", "no", "yes", "no", "no", "no", "yes", "no", "yes", "no", "yes")
X2 <- ifelse(math == "yes", 1, 0) # indicator for liking math (1=yes, 0=no)


data <- data.frame(Y = Y, X1 = X1)

# Linear regression model
model <- lm(Y ~ X1, data = data)

# Scatter plot with regression line
scatter_plot <- ggplot(data, aes(x = X1, y = Y)) +
    geom_point(color = "blue") +
    geom_smooth(method = "lm", formula = y ~ x, color = "red", se = FALSE) +
    labs(
        title = "Final Exam Score vs. Coursework Score",
        x = "Coursework Score (%)",
        y = "Final Exam Score (%)"
    ) +
    theme_minimal()

# Residual plot
residual_plot <- ggplot(data, aes(x = X1, y = residuals(model))) +
    geom_point(color = "blue") +
    geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
    labs(
        title = "Residual Plot",
        x = "Coursework Score (%)",
        y = "Residuals"
    ) +
    theme_minimal()

# Q-Q plot for residuals
qq_plot <- ggplot(data, aes(sample = residuals(model))) +
    geom_qq() +
    geom_qq_line(color = "red") +
    labs(
        title = "Normal Q-Q Plot of Residuals",
        x = "Theoretical Quantiles",
        y = "Sample Quantiles"
    ) +
    theme_minimal()

# Residuals vs. Fitted Values plot
residuals_vs_fitted <- ggplot(data, aes(x = fitted(model), y = residuals(model))) +
  geom_point(color = "blue") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Residuals vs. Fitted Values",
       x = "Fitted Values",
       y = "Residuals") +
  theme_minimal()

# Print plots
print(scatter_plot)
print(residual_plot)
print(qq_plot)
print(residuals_vs_fitted)


# Arrange the plots in a 2x2 grid
grid_arrange <- grid.arrange(scatter_plot, qq_plot, residual_plot, residuals_vs_fitted,
                             ncol = 2, nrow = 2,
                             top = "Regression Analysis Visualizations")

# Print the grid arrangement
print(grid_arrange)


# Summary of the regression
summary(model)
