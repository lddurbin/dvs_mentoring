import pandas as pd
import os
from skimpy import clean_columns

for file in os.listdir("Code/dvs_mentoring/lines"):
    if file.endswith(".xlsx"):
        excel = os.path.join("Code/dvs_mentoring/lines", file)

df = pd.read_excel (excel, sheet_name = 'Date')

clean_df = clean_columns(df)

vaccinations = pd.melt(clean_df, id_vars='date', value_vars=['first_dose_administered', 'second_dose_administered'], var_name='dose')