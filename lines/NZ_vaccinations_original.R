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

