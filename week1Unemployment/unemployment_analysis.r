# Load dplyr and tidyr package
library(dplyr)
library(tidyr)
library(ggplot2)
library(zoo)

# import unemployment data
unemployment <- read.csv("./unemployment_analysis.csv", header = TRUE, sep = ",")

# CSV file is structured as follows:
# 1. Country Name
# 2. Country Code
# 3. 1991
# 4. 1992
# Repeat until 2021

# We want to reshape the data so that it is in the following format:
# 1. Country Name
# 2. Country Code
# 3. Year
# 4. Unemployment Rate

# Gather function to reshape the data
unemployment_reshaped <- gather(unemployment, Year, Unemployment_Rate, 3:ncol(unemployment))

# Remove the Country Code column
unemployment_reshaped <- select(unemployment_reshaped, -Country.Code)

# Remove preceding X from Year column
unemployment_reshaped$Year <- substr(unemployment_reshaped$Year, 2, nchar(unemployment_reshaped$Year))

# Convert Year column to numeric
unemployment_reshaped$Year <- as.numeric(unemployment_reshaped$Year)

# Plot 10 countries with highest unemployment rate in 2021
unemployment_reshaped %>%
  filter(Year == 2021) %>%
  arrange(desc(Unemployment_Rate)) %>%
  head(10) %>%
  ggplot(aes(x = reorder(Country.Name, Unemployment_Rate), y = Unemployment_Rate)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Top 10 Countries with Highest Unemployment Rate in 2021",
       x = "Country Name",
       y = "Unemployment Rate (%)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#Save plot as png
ggsave("high_rates.png")


# Plot 10 countries with lowest unemployment rate in 2021
unemployment_reshaped %>%
  filter(Year == 2021) %>%
  arrange(Unemployment_Rate) %>%
  head(10) %>%
  ggplot(aes(x = reorder(Country.Name, Unemployment_Rate), y = Unemployment_Rate)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Top 10 Countries with Lowest Unemployment Rate in 2021",
       x = "Country Name",
       y = "Unemployment Rate (%)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#Save plot as png
ggsave("low_rates.png")

# Calculate moving average of unemployment rate for each country and add to dataframe
unemployment_reshaped <- unemployment_reshaped %>%
  group_by(Country.Name) %>%
  mutate(MA = rollmean(Unemployment_Rate, 5, fill = NA, align = "right"))

# Plot United States unemployment rate from 1991 to 2021, 
unemployment_reshaped %>%
  filter(Country.Name == "United States") %>%
  ggplot(aes(x = Year, y = Unemployment_Rate)) +
  geom_bar(stat = "identity", fill = "steelblue", alpha = 0.7) + # Bars for actual data
  geom_line(aes(y = MA), color = "red", size = 1.2) + # Line for moving average
  labs(title = "United States Unemployment Rate from 1991 to 2021",
       x = "Year",
       y = "Unemployment Rate (%)")


#Save plot as png
ggsave("us_unemployment.png")












  




