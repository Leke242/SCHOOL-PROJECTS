import pandas as pd

# Load the dataset
data = pd.read_csv('Telecom_customer_data.csv')

# Display the first few rows of the dataset
print(data.head())
print(data.shape)
print(data.info())

#converting totalcharges to numeric
data['TotalCharges'] = pd.to_numeric(data['TotalCharges'], errors='coerce')

# Check for missing values
print(data.isnull().sum())

# Handling missing values by removing rows with missing values
data = data.dropna()

#converting the tarfget variable to binary
data['Churn'] = data['Churn'].map({'Yes': 1, 'No': 0})


# Display the first few rows of the cleaned dataset
print(data.head())


# selecting the important columns
selected_columns = ['tenure', 'MonthlyCharges', 'TotalCharges', 'Churn']
data = data[selected_columns]

# splitting the dataset
from sklearn.model_selection import train_test_split
X = data[['tenure', 'MonthlyCharges', 'TotalCharges']]
y = data['Churn']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# training the model
from sklearn.linear_model import LogisticRegression
model = LogisticRegression()
model.fit(X_train, y_train)

# making predictions
y_pred = model.predict(X_test)

# evaluating the model
from sklearn.metrics import accuracy_score, confusion_matrix, classification_report 
accuracy = accuracy_score(y_test, y_pred)
conf_matrix = confusion_matrix(y_test, y_pred)
class_report = classification_report(y_test, y_pred)
print(f'Accuracy: {accuracy}')
print(f'Confusion Matrix:\n{conf_matrix}')
print(f'Classification Report:\n{class_report}')

# Connecting pgAdmin to python
import psycopg2

connection = psycopg2.connect(
        user="postgres",
        password="Lekhes",
        host="localhost",
        port="2222",
        database="Telecom_dw"
    )
cursor = connection.cursor()
print("Connected to PostgreSQL database successfully!")


# Inserting data into the fact_customer_usage table



print(data.columns)

#Change insert loop to use original dataset
for i, row in data.iterrows():
    cursor.execute("""
        INSERT INTO fact_customer_usage 
        (tenure, monthly_charges, total_charges, churn)
        VALUES (%s, %s, %s, %s)
    """, (
        int(row['tenure']),
        float(row['MonthlyCharges']),
        float(row['TotalCharges']),
        int(row['Churn'])
    ))

connection.commit()
print("Data inserted successfully!")

#  grouping customers(clustering)
from sklearn.cluster import KMeans

X = data[["tenure", "MonthlyCharges", "TotalCharges"]]
kmeans = KMeans(n_clusters=3, random_state=42)
data['Cluster'] = kmeans.fit_predict(X)
print(data['Cluster'].value_counts())

# Visualizing the clusters
import matplotlib.pyplot as plt
plt.scatter(data['tenure'], data['MonthlyCharges'], c=data['Cluster'], cmap='viridis')
plt.xlabel('Tenure')
plt.ylabel('Monthly Charges')
plt.title('Customer segmentation')
plt.show()


# Improving churn detection using Random Forest
from sklearn.ensemble import RandomForestClassifier
rf_model = RandomForestClassifier(random_state=42)
rf_model.fit(X_train, y_train)
rf_y_pred = rf_model.predict(X_test)
rf_accuracy = accuracy_score(y_test, rf_y_pred)
print(f'Random Forest Accuracy: {rf_accuracy}')
print(f'Random Forest Classification Report:\n{classification_report(y_test, rf_y_pred)}')
print(f'Random Forest Confusion Matrix:\n{confusion_matrix(y_test, rf_y_pred)}')





# 