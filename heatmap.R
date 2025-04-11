library(ggplot2)
library(reshape2)
library(dplyr)

# Calculate correlation matrix (including only numeric columns)
correlation_matrix <- weather_data %>%
  select(where(is.numeric)) %>%
  cor(use = "complete.obs")

# Melt for ggplot
correlation_melted <- melt(correlation_matrix) %>%
  mutate(Var1 = factor(Var1, levels = unique(Var1)),
         Var2 = factor(Var2, levels = rev(unique(Var2))))

# Create heatmap with classic red-blue diverging colors
ggplot(correlation_melted, aes(Var1, Var2, fill = value)) +
  geom_tile(color = "white", linewidth = 0.4) +  # Clean white borders
  geom_text(aes(label = round(value, 2)),  # Display correlation values
            color = ifelse(abs(correlation_melted$value) > 0.5, "white", "black"),
            size = 3.8) +
  scale_fill_gradient2(low = "#2b83ba", mid = "white", high = "#d7191c",
                       midpoint = 0, limit = c(-1,1), space = "Lab",
                       name = "Correlation") +
  labs(title = "Weather Variables Correlation Matrix",
       x = NULL, y = NULL) +
  theme_minimal(base_size = 12) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
    panel.grid = element_blank(),
    plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
    legend.position = "right",
    legend.key.height = unit(1.5, "cm")
  ) +
  coord_fixed()  # Perfect square tiles

