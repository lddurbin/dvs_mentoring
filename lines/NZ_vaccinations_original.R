library(dplyr) # A Grammar of Data Manipulation
library(ggplot2) # Create Elegant Data Visualisations Using the Grammar of Graphics
library(readxl) # Read Excel Files
library(ggtext) # Improved Text Rendering Support for 'ggplot2'

# Compose the chart, either line or area
build_chart <- function(data, chart_type, chart_colour, title_text) {
  ggplot(data, aes(x = date, y = value)) +
    if_else(
      chart_type == "line",
      list(geom_line(size = 1)),
      list(geom_area(fill = chart_colour) )
    ) +
    scale_x_date(limits = range, breaks = "1 month", labels = scales::label_date("%B")) +
    scale_y_continuous(labels = scales::label_comma()) +
    scale_color_manual(labels = c("1st dose", "2nd dose"), values = c("blue", "red")) +
    labs(
      title = title_text,
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
}

# Load and clean the data
vaccinations <- read_excel(
  path = fs::dir_ls(here::here("lines"), glob = "*.xlsx"),
  sheet = "Date",
  range = cell_cols("A:C"),
  .name_repair = janitor::make_clean_names) |> 
  tidyr::pivot_longer(2:3, names_to = "dose") |> 
  mutate(date = as.Date(date))

# Chart #1: a summary
build_chart(
  vaccinations,
  "line",
  "",
  "In New Zealand, most COVID-19 vaccinations were administered during 2021,<br>and here's how many were administered by day"
)

# Chart #2: first doses
build_chart(
  vaccinations |> filter(dose == "first_dose_administered"),
  "area",
  "blue",
  "In the days after New Zealand entered lockdown, the number of <span style='color:blue'><strong>first doses</strong></span> spiked"
)

# Chart #3: second doses
build_chart(
  vaccinations |> filter(dose == "second_dose_administered"),
  "area",
  "red",
  "The number of <span style='color:red'><strong>second doses</strong></span> peaked during Super Saturday"
)
