library(dplyr) # A Grammar of Data Manipulation
library(ggplot2) # Create Elegant Data Visualisations Using the Grammar of Graphics
library(readxl) # Read Excel Files
library(ggtext)

vaccinations <- read_excel(
  path = fs::dir_ls(here::here("lines"), glob = "*.xlsx"),
  sheet = "Date",
  range = cell_cols("A:C"),
  .name_repair = janitor::make_clean_names) |> 
  tidyr::pivot_longer(2:3, names_to = "dose") |> 
  mutate(date = as.Date(date))

# ggplot(vaccinations, aes(x = date, y = value, colour = dose)) +
#   geom_smooth(se = FALSE, size = 2) +
#   scale_x_date(limits = range, breaks = "1 month", labels = scales::label_date("%B")) +
#   scale_y_continuous(labels = scales::label_comma()) +
#   scale_color_manual(labels = c("1st dose", "2nd dose"), values = c("blue", "red")) +
#   labs(
#     title = "Number of <span style='color:blue'><strong>first doses</strong></span> and number of <span style='color:red'><strong>second doses<strong></span> of the COVID-19 vaccine<br>administered by day in 2021",
#     caption = "Data: NZ Ministry of Health"
#   ) +
#   theme_minimal() +
#   theme(
#     plot.title.position = "plot",
#     title = element_text(size = 20),
#     legend.position = "none",
#     plot.title = element_markdown(lineheight = 1.1),
#     plot.caption = element_text(size=10),
#     axis.title = element_blank(),
#     panel.grid.major.x = element_blank(),
#     panel.grid.minor.x = element_blank(),
#     panel.grid.minor.y = element_blank(),
#     axis.text = element_text(size=12)
#   )

ggplot(vaccinations, aes(x = date, y = value)) +
  geom_line(size = 1) +
  scale_x_date(limits = range, breaks = "1 month", labels = scales::label_date("%B")) +
  scale_y_continuous(labels = scales::label_comma()) +
  scale_color_manual(labels = c("1st dose", "2nd dose"), values = c("blue", "red")) +
  labs(
    title = "In New Zealand, most COVID-19 vaccinations were administered during 2021,<br>and here's how many were administered by day",
    caption = "Data: NZ Ministry of Health"
  ) +
  theme_minimal() +
  theme(
    plot.title.position = "plot",
    title = element_text(size = 20),
    legend.position = "none",
    plot.title = element_markdown(lineheight = 1.1),
    plot.caption = element_text(size=10),
    axis.title = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    axis.text = element_text(size=12)
  )

ggplot(vaccinations |> filter(dose == "first_dose_administered"), aes(x = date, y = value)) +
  geom_area(fill = "blue") +
  scale_x_date(limits = range, breaks = "1 month", labels = scales::label_date("%B")) +
  scale_y_continuous(labels = scales::label_comma()) +
  scale_color_manual(labels = c("1st dose", "2nd dose"), values = c("blue", "red")) +
  labs(
    title = "In the days after New Zealand entered lockdown, the number of <span style='color:blue'><strong>first doses</strong></span> spiked",
    caption = "Data: NZ Ministry of Health"
  ) +
  theme_minimal() +
  theme(
    plot.title.position = "plot",
    title = element_text(size = 20),
    legend.position = "none",
    plot.title = element_markdown(lineheight = 1.1),
    plot.caption = element_text(size=10),
    axis.title = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    axis.text = element_text(size=12)
  )

ggplot(vaccinations |> filter(dose == "second_dose_administered"), aes(x = date, y = value)) +
  geom_area(fill = "red") +
  scale_x_date(limits = range, breaks = "1 month", labels = scales::label_date("%B")) +
  scale_y_continuous(labels = scales::label_comma()) +
  scale_color_manual(labels = c("1st dose", "2nd dose"), values = c("blue", "red")) +
  labs(
    title = "The number of <span style='color:red'><strong>second doses</strong></span> peaked during Super Saturday",
    caption = "Data: NZ Ministry of Health"
  ) +
  theme_minimal() +
  theme(
    plot.title.position = "plot",
    title = element_text(size = 20),
    legend.position = "none",
    plot.title = element_markdown(lineheight = 1.1),
    plot.caption = element_text(size=10),
    axis.title = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    axis.text = element_text(size=12)
  )
