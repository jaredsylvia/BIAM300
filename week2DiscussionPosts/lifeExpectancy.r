# Load common packages
library(dplyr)
library(tidyr)
library(ggplot2)

# Load data from csv file
lifeExpectancy <- read.csv("./LifeExpectancy.csv", header = TRUE, sep = ",")

# Clean LifeExpectancy
# Keep only Country, Continent, Hemisphere, 2021
lifeExpectancy <- lifeExpectancy %>% select(Country, Continent, Hemisphere, X2021)

# Rename X2021 to LifeExpectancy
lifeExpectancy <- lifeExpectancy %>% rename(LifeExpectancy = X2021)

# Add new column called ContAvg that is the average life expectancy for the continent
lifeExpectancy <- lifeExpectancy %>% group_by(Continent) %>% mutate(ContAvg = mean(LifeExpectancy, na.rm = TRUE))

# Add new column called ContDiff that is the difference between the country and continent average
lifeExpectancy <- lifeExpectancy %>% mutate(ContDiff = LifeExpectancy - ContAvg)

# Create new data frame that is only Continent and ContAvg
lifeExpectancyContinent <- lifeExpectancy %>% select(Continent, ContAvg) %>% distinct()

# Round ContAvg to 2 decimal places
lifeExpectancyContinent$ContAvg <- round(lifeExpectancyContinent$ContAvg, 2)

# Find top country per continent
lifeExpectancyTop <- lifeExpectancy %>% group_by(Continent) %>% top_n(1, LifeExpectancy)

# Round to 2 decimal places
lifeExpectancyTop$LifeExpectancy <- round(lifeExpectancyTop$LifeExpectancy, 2)

# Bottom country per continent
lifeExpectancyBottom <- lifeExpectancy %>% group_by(Continent) %>% top_n(-1, LifeExpectancy)

# Round to 2 decimal places
lifeExpectancyBottom$LifeExpectancy <- round(lifeExpectancyBottom$LifeExpectancy, 2)

# Pie chart of average life expectancy by continent
ggplot(lifeExpectancyContinent, aes(x = "", y = ContAvg, fill = Continent)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start = 0) +
  geom_text(aes(label = paste(Continent, "\n", ContAvg, sep = "")), position = position_stack(vjust = 0.5)) +
  labs(title = "Life Expectancy by Continent", x = NULL, y = NULL) +
  theme_void()

# Save plot
ggsave("./lifeExpectancyContinent.png")

# Pie chart of top country per continent
ggplot(lifeExpectancyTop, aes(x = "", y = LifeExpectancy, fill = Continent)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start = 0) +
  geom_text(aes(label = paste(Country, "\n", LifeExpectancy, sep = "")), position = position_stack(vjust = 0.5)) +
  labs(title = "Top Country by Continent", x = NULL, y = NULL) +
  theme_void()

# Save plot
ggsave("./lifeExpectancyTop.png")

# Pie chart of bottom country per continent
ggplot(lifeExpectancyBottom, aes(x = "", y = LifeExpectancy, fill = Continent)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start = 0) +
  geom_text(aes(label = paste(Country, "\n", LifeExpectancy, sep = "")), position = position_stack(vjust = 0.5)) +
  labs(title = "Bottom Country by Continent", x = NULL, y = NULL) +
  theme_void()

# Save plot
ggsave("./lifeExpectancyBottom.png")
