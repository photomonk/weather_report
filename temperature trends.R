library(dplyr)
library(ggplot2)
library(lubridate)  # For date handling

# Load your dataset
weather_data <- read.csv("weather_data.csv") %>%
  mutate(date = as.Date(date))  # Ensure date column is proper Date type

# Prepare data for daily average temperature
daily_avg_temp <- weather_data %>%
  group_by(date) %>%
  summarise(avg_temp = mean(temperature, na.rm = TRUE))

# Create a line plot for temperature with daily average
ggplot() +
  # Individual temperature readings (if you have multiple readings per day)
  geom_line(data = weather_data, 
            aes(x = date, y = temperature, group = date), 
            alpha = 0.3, color = "gray") +
  # Daily average line
  geom_line(data = daily_avg_temp, 
            aes(x = date, y = avg_temp), 
            color = "red", size = 1) +
  labs(title = "Temperature Trends Over the Month",
       x = "Date",
       y = "Temperature (°C)") +
  theme_minimal() +
  scale_x_date(date_labels = "%b %d", date_breaks = "1 week")













