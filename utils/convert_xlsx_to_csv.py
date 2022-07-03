import pandas as pd


f = "carmen_sightings_20220629061307.xlsx"

xls = pd.ExcelFile(f)

for sheet_name in xls.sheet_names:
    df = pd.read_excel(xls, sheet_name)
    df["region"] = sheet_name.title()
    df.to_csv(f"where_is_carmen/seeds/carmen_sightings_{sheet_name.lower()}.csv", index=False)
