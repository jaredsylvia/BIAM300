# Load necessary libraries
library(forecast)

# Load the AirPassengers dataset and convert it into a time series
data("AirPassengers")

# Add 60 to the years in the dataset so they start at 1949
AirPassengers <- ts(AirPassengers, start = c(1949 + 60, 1), frequency = 12)

# Plot the time series
plot(AirPassengers, main = "AirPassengers Time Series", xlab = "Year", ylab = "Number of Passengers")

# Split the time series in half into training and test sets
train <- window(AirPassengers, end = c(2015, 12))
test <- window(AirPassengers, start = c(2016, 1))

# Train an ARIMA model on the training set
model <- auto.arima(train)

# Predict the test set using the trained model
pred <- forecast(model, h = length(test))

# Plot the training set and overlaid test set predictions considering the length of the full time series
plot(AirPassengers, xlim = c(2009, 2020), ylim = c(0, 700), main = "AirPassengers Time Series", xlab = "Year", ylab = "Number of Passengers")
lines(test, col = "blue")
lines(pred$mean, col = "red")

# Add a legend
legend("topleft", legend = c("Training Set", "Test Set", "Predictions"), col = c("black", "blue", "red"), lty = c(1, 1, 1))
