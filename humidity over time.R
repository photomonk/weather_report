library(ggplot2)
library(dplyr)
library(lubridate)

# Convert date if needed and ensure proper ordering
weather_data <- weather_data %>%
  mutate(date = as.Date(date)) %>%
  arrange(date)  # Ensure chronological order

# Basic area chart
ggplot(weather_data, aes(x = date, y = humidity)) +
  geom_area(fill = "#69b3a2", alpha = 0.5) +  # Semi-transparent fill
  
  labs(title = "Humidity Over Time",
       x = "Date",
       y = "Humidity (%)") +
  theme_minimal() +
  scale_x_date(date_labels = "%b %d", date_breaks = "1 week")

