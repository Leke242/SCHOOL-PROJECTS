# load the dataset
import pandas as pd
data= pd.read_excel("D:\SCHOOL PROJECTS\Dataset for Data Analytics.xlsx")
# drop the unnamed column 
data.drop(columns=['Unnamed: 14','Unnamed: 15','Unnamed: 16'], inplace=True)
print(data.head())

# data cleaning and preprocessing
# check for missing values
print(data.isnull().sum())

# handling missing values in couponcode column by filling with no coupon
data['CouponCode'].fillna('no coupon', inplace=True)
print(data.isnull().sum())

# data format correction
data['Date'] = pd.to_datetime(data['Date'], format='%Y-%m-%d')
print(data.dtypes)

#checking for duplicates on each column of the dataset
duplicates = data.duplicated().sum()
print(duplicates)

# checking for duplicate in customerid column
duplicate_customerid = data['CustomerID'].duplicated().sum()
print( duplicate_customerid)

# checking for duplicate in orderid column
duplicate_orderid = data['OrderID'].duplicated().sum()
print(duplicate_orderid)

# confirming the numeric column are in the correct format
data[['Quantity','UnitPrice','ItemsInCart','TotalPrice']] = data[['Quantity','UnitPrice','ItemsInCart','TotalPrice']].apply(pd.to_numeric, errors='coerce')
print(data.dtypes)

# checking for outliers in the numeric columns using boxplot
import matplotlib.pyplot as plt

for col in ['Quantity', 'UnitPrice', 'ItemsInCart', 'TotalPrice']:
    plt.figure(figsize=(10, 6))
    plt.boxplot(data[col].dropna())
    plt.title(f'Boxplot of {col}')
    plt.ylabel(col)
    plt.show()

    # handling outliers in totalprice column using IQR method
    Q1 = data['TotalPrice'].quantile(0.25)
    Q3 = data['TotalPrice'].quantile(0.75)
    IQR = Q3 - Q1
    lower_bound = Q1 - 1.5 * IQR
    upper_bound = Q3 + 1.5 * IQR
    data = data[(data['TotalPrice'] >= lower_bound) & (data['TotalPrice'] <= upper_bound)]

    # saving the cleaned dataset to a new excel file
    data.to_excel("D:\SCHOOL PROJECTS\Internship projects\Cleaned_Dataset.xlsx", index=False)
    print("cleaned dataset saved successfully")