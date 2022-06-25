library(dplyr) # A Grammar of Data Manipulation
library(ggplot2) # Create Elegant Data Visualisations Using the Grammar of Graphics
library(readxl) # Read Excel Files

vaccinations <- read_excel(
  path = fs::dir_ls(here::here("lines"), glob = "*.xlsx"),
  sheet = "Date",
  range = cell_cols("A:C"),
  .name_repair = janitor::make_clean_names) |> 
  tidyr::pivot_longer(2:3, names_to = "dose") |> 
  mutate(date = as.Date(date))

ggplot(vaccinations, aes(x = date, y = value, colour = dose)) +
  geom_line(size = 1.5) +
  scale_x_date(limits = range, breaks = "1 month", labels = scales::label_date("%B")) +
  scale_y_continuous(labels = scales::label_comma()) +
  scale_color_manual(labels = c("1st dose", "2nd dose"), values = c("blue", "red")) +
  labs(
    y = "Number of doses administered",
    title = "Number of doses of the COVID-19 vaccine administered by day in 2021",
    colour = "Vaccine dosages"
  ) +
  theme(
    plot.title.position = "plot",
    title = element_text(size = 18)
  )

# daily average as well as 1st and 2nd doses