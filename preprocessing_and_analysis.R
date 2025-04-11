library(dplyr)
library(tidyr)

# Load your dataset
weather_data <- read.csv("weather_data.csv")



# Check for NA values
na_summary <- weather_data %>%
  summarise(across(everything(), ~ sum(is.na(.)), .names = "na_count_{col}"))

# Calculate average daily temperature, wind speed, and humidity
daily_summary <- weather_data %>%
  group_by(date) %>%
  summarise(
    avg_temp = mean(temperature, na.rm = TRUE),
    avg_wind_speed = mean(wind_speed, na.rm = TRUE),
    avg_humidity = mean(humidity, na.rm = TRUE)
  )

# Create insights based on the averages
daily_summary <- daily_summary %>%
  mutate(insights = case_when(
    avg_temp > 30 ~ "Hot day",
    avg_temp < 15 ~ "Cold day",
    TRUE ~ "Moderate day"
  ))

# Save the updated daily summary with insights to a new CSV file
write.csv(daily_summary, "daily_weather_insights.csv", row.names = FALSE)

# Print the daily summary with insights
print(daily_summary)



