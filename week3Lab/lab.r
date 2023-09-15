# Load necessary libraries
library(ggplot2)

# Set the parameters for the binomial distribution
n <- 20  # Number of trials
p <- 0.5  # Probability of success

# Generate a sequence of x values (number of successes)
x_values <- 0:n

# Calculate the corresponding probability mass function (PMF) values
pmf_values <- dbinom(x_values, size = n, prob = p)

# Create a data frame for plotting
binomial_data <- data.frame(x = x_values, pmf = pmf_values)

# Calculate mean and standard deviation for binomial distribution
mean_binomial <- n * p
sd_binomial <- sqrt(n * p * (1 - p))

# Create the plot for binomial distribution
binomial_plot <- ggplot(binomial_data, aes(x = x, y = pmf)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  geom_vline(xintercept = mean_binomial, color = "red", linetype = "dashed") +
  geom_vline(xintercept = mean_binomial - sd_binomial, color = "blue", linetype = "dashed") +
  geom_vline(xintercept = mean_binomial + sd_binomial, color = "blue", linetype = "dashed") +
  labs(title = "Binomial Distribution",
       x = "Number of Successes",
       y = "Probability") +
  theme_minimal() +
  annotate("text", x = 12, y = 0.15, label = "Discrete\nProbability\nDistribution")

# Set the parameter for the Poisson distribution
lambda <- 5  # Poisson parameter

# Generate a sequence of x values (number of occurrences)
x_values <- 0:20  # Let's consider up to 20 occurrences

# Calculate the corresponding probability mass function (PMF) values
pmf_values <- dpois(x_values, lambda)

# Create a data frame for plotting
poisson_data <- data.frame(x = x_values, pmf = pmf_values)

# Calculate mean and standard deviation for Poisson distribution
mean_poisson <- lambda
sd_poisson <- sqrt(lambda)

# Create the plot for Poisson distribution
poisson_plot <- ggplot(poisson_data, aes(x = x, y = pmf)) +
  geom_bar(stat = "identity", fill = "lightgreen", color = "black") +
  geom_vline(xintercept = mean_poisson, color = "red", linetype = "dashed") +
  labs(title = "Poisson Distribution",
       x = "Number of Occurrences",
       y = "Probability") +
  theme_minimal() +
  annotate("text", x = 10, y = 0.15, label = "Discrete\nProbability\nDistribution")

# Set the mean and standard deviation for the normal distribution
mean_val <- 0  # Mean (μ)
sd_val <- 1     # Standard deviation (σ)

# Generate a sequence of x values
x_values <- seq(-5, 5, length = 400)

# Calculate the corresponding probability density function (PDF) values
pdf_values <- dnorm(x_values, mean_val, sd_val)

# Create a data frame for plotting
normal_data <- data.frame(x = x_values, pdf = pdf_values)

# Create a custom legend
custom_legend <- guide_legend(title = "Standard Deviations",
                               override.aes = list(fill = c("blue", "red", "green", "orange", "purple", "pink"),
                                                   linetype = c(0, 0, 0, 0, 0, 0)))

# Create the plot
normal_plot <- ggplot(normal_data, aes(x = x, y = pdf)) +
  geom_line(color = "blue") +
  geom_ribbon(aes(ymin = 0, ymax = pdf, fill = ifelse(x >= mean_val - sd_val & x <= mean_val + sd_val, "Within 1 SD", "Outside 1 SD")), alpha = 0.5) +
  geom_ribbon(aes(ymin = 0, ymax = pdf, fill = ifelse(x >= mean_val - 2*sd_val & x <= mean_val + 2*sd_val, "Within 2 SD", "Outside 2 SD")), alpha = 0.3) +
  geom_ribbon(aes(ymin = 0, ymax = pdf, fill = ifelse(x >= mean_val - 3*sd_val & x <= mean_val + 3*sd_val, "Within 3 SD", "Outside 3 SD")), alpha = 0.2) +
  labs(title = "Normal Distribution",
       x = "X",
       y = "Density") +
  theme_minimal() +
  theme(legend.position = "top") +
  guides(fill = custom_legend)

# Arrange the plots in a grid
library(gridExtra)
grid.arrange(binomial_plot, poisson_plot, normal_plot, ncol=3)
