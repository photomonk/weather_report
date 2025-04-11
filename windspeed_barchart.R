# for bar chart of windspeed for different time

# Prepare data for average wind speed
avg_wind_speed_by_time <- weather_data %>%
  group_by(date) %>%
  summarise(avg_wind_speed = mean(wind_speed, na.rm = TRUE))

# Create a bar chart for wind speed
ggplot(avg_wind_speed_by_time, aes(x = date, y = avg_wind_speed)) +
  geom_bar(stat = "identity", fill = "steelblue") +

  labs(title = "Average Wind Speed by date",
       x = "Date",
       y = "Average Wind Speed (m/s)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
