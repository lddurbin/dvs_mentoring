import pandas as pd
import os
from skimpy import clean_columns
import plotnine as p9

for file in os.listdir("Code/dvs_mentoring/lines"):
    if file.endswith(".xlsx"):
        excel = os.path.join("Code/dvs_mentoring/lines", file)

df = pd.read_excel (excel, sheet_name = 'Date')

clean_df = clean_columns(df)

vaccinations = pd.melt(clean_df, id_vars='date', value_vars=['first_dose_administered', 'second_dose_administered'], var_name='dose')

my_plot = (p9.ggplot(vaccinations, p9.aes('date', 'value', color='dose'))
    + p9.geom_line(size=1.5))

my_plot.save("Code/dvs_mentoring/lines/lines.png", dpi=300)