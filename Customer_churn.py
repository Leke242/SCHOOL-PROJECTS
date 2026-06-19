import pandas as pd

# load dataset (make sure file is in same folder)
df = pd.read_csv("D:\\SCHOOL PROJECTS\\Dw  capstone project\\Telecom_customer_data.csv")

print(df.head())
print(df.shape)
print(df.info())