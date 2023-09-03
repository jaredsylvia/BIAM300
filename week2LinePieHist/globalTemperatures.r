# Load common packages
library(dplyr)
library(tidyr)
library(ggplot2)
library(zoo)

# Load data from csv file
globalTemps <- read.csv("./GlobalTemperature.csv", header = TRUE, sep = ",")

# Clean GlobalTemperatures
# Keep only Year, Month, Monthly Anomaly, and Uncertainty
globalTemps <- globalTemps %>% select(Year, Month, MonthAnom, MonthUnc)

# Create a new column called Date that is the combination of Year and Month as 'Year-Month-1' using as.Date
# as.date() will convert the string to a date object
globalTemps$Date <- as.Date(paste(globalTemps$Year, globalTemps$Month, 1, sep = "-"))

# Drop Year and Month columns
globalTemps <- globalTemps %>% select(-Year, -Month)

# Create a new column called MovingAverage that is the moving average of MonthAnom
globalTemps$MovingAverage <- rollmean(globalTemps$MonthAnom, 12, fill = NA)

# Create a new column called decade that is the decade of the date
globalTemps$Decade <- as.numeric(format(globalTemps$Date, "%Y")) %/% 10 * 10

# Create a new column called DecadeAverage that is the average of the decade
globalTemps <- globalTemps %>% group_by(Decade) %>% mutate(DecadeAverage = mean(MonthAnom, na.rm = TRUE))

# Create new data frame that is only decades and DecadeAverage
globalTempsDecade <- globalTemps %>% select(Decade, DecadeAverage) %>% distinct()

# Add MA to globalTempsDecade
globalTempsDecade$MovingAverage <- rollmean(globalTempsDecade$DecadeAverage, 2, fill = NA)

# Add average of all decade anomalies to globalTempsDecade
globalTempsDecade$Average <- mean(globalTemps$MonthAnom, na.rm = TRUE)

# Plot the time series with moving average and uncertainty
ggplot(globalTemps, aes(x = Date, y = MonthAnom)) +
  geom_line(color = "blue") +
  geom_line(aes(y = MovingAverage), color = "red") +
  geom_ribbon(aes(ymin = MonthAnom - MonthUnc, ymax = MonthAnom + MonthUnc), fill = "dodgerblue", alpha = 0.5) +
  labs(title = "Global Temperatures", x = "Date", y = "Temperature Anomaly") +
  theme(plot.title = element_text(hjust = 0.5))

# Save plot
ggsave("./globalTemps.png")

# Plot the time series with moving average and uncertainty but only for the last 50 years
ggplot(globalTemps, aes(x = Date, y = MonthAnom)) +
  geom_line(color = "blue") +
  geom_line(aes(y = MovingAverage), color = "red") +
  geom_ribbon(aes(ymin = MonthAnom - MonthUnc, ymax = MonthAnom + MonthUnc), fill = "dodgerblue", alpha = 0.5) +
  labs(title = "Global Temperatures", x = "Date", y = "Temperature Anomaly") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlim(as.Date("1970-01-01"), as.Date("2021-01-01"))

# Save plot
ggsave("./globalTemps50.png")

# Bar chart of average temperature anomaly by decade, with MA and average of all anomalies, each bar colored by whether it is above or below the average
ggplot(globalTempsDecade, aes(x = Decade, y = DecadeAverage)) +
  geom_bar(stat = "identity", aes(fill = DecadeAverage > Average)) +
  geom_line(aes(y = MovingAverage), color = "red") +
  geom_line(aes(y = Average), color = "blue") +
  labs(title = "Global Temperatures", x = "Decade", y = "Temperature Anomaly") +
  theme(plot.title = element_text(hjust = 0.5))

# Save plot
ggsave("./globalTempsDecade.png")

