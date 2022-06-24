library(dplyr) # A Grammar of Data Manipulation
library(ggplot2) # Create Elegant Data Visualisations Using the Grammar of Graphics
library(readxl) # Read Excel Files
library(ggtext) # Improved Text Rendering Support for 'ggplot2'

path <- here::here("line_chart")

files <- fs::dir_ls(path, glob = "*.xlsx")

data <- files |> 
  purrr::map_dfr(~read_excel(
    path = .x,
    sheet = "Date",
    .name_repair = janitor::make_clean_names,
    range = cell_cols("A:C")
  ))

vaccinations <- data |> 
  tidyr::pivot_longer(2:3, names_to = "dose") |> 
  mutate(date = as.Date(date))

