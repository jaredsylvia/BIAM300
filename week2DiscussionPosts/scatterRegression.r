# Load libraries
library(ggplot2)

#Randomly generate 100 data points between 20 and 100 in integers
y <- sample(20:100, 100, replace = TRUE)

#Square every data point in y
y <- y^2

#Sort y ascending
y <- sort(y)

#Randomly generate 100 data points between 0 and 100 in integers
x <- sample(1:100, 1000, replace = TRUE)

#Sort x ascending
x <- sort(x)

# Keep only every 10th data point in x
x <- x[seq(1, length(x), 10)]

#Pair x and y into data frame
data <- data.frame(x, y)

#Scatter plots
#Plot linear regression line
ggplot(data, aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Scatter Plot of Randomly Generated Data with Linear Regression Line",
       x = "X",
       y = "Y")

#Plot quadratic regression line
ggplot(data, aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), se = FALSE) +
  labs(title = "Scatter Plot of Randomly Generated Data with Quadratic Regression Line",
       x = "X",
       y = "Y")

#Plot cubic regression line
ggplot(data, aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ poly(x, 3), se = FALSE) +
  labs(title = "Scatter Plot of Randomly Generated Data with Cubic Regression Line",
       x = "X",
       y = "Y")

# Reverse x and y and repeat the above plots
#Plot linear regression line
ggplot(data, aes(x = y, y = x)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Scatter Plot of Randomly Generated Data with Linear Regression Line",
       x = "Y",
       y = "X")

#Plot quadratic regression line
ggplot(data, aes(x = y, y = x)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), se = FALSE) +
  labs(title = "Scatter Plot of Randomly Generated Data with Quadratic Regression Line",
       x = "Y",
       y = "X")

#Plot cubic regression line
ggplot(data, aes(x = y, y = x)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ poly(x, 3), se = FALSE) +
  labs(title = "Scatter Plot of Randomly Generated Data with Cubic Regression Line",
       x = "Y",
       y = "X")

# Sort x in descending order
x <- sort(x, decreasing = TRUE)

#Pair x and y into data frame to update x values
data <- data.frame(x, y)

#Scatter plots
#Plot linear regression line
ggplot(data, aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Scatter Plot of Randomly Generated Data with Linear Regression Line",
       x = "X",
       y = "Y")

#Plot quadratic regression line
ggplot(data, aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), se = FALSE) +
  labs(title = "Scatter Plot of Randomly Generated Data with Quadratic Regression Line",
       x = "X",
       y = "Y")

#Plot cubic regression line
ggplot(data, aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ poly(x, 3), se = FALSE) +
  labs(title = "Scatter Plot of Randomly Generated Data with Cubic Regression Line",
       x = "X",
       y = "Y")
