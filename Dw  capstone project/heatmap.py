
import pandas as pd
data = pd.read_csv('Telecom_customer_data.csv')
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

import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.metrics import accuracy_score, confusion_matrix

cm = confusion_matrix(y_test, y_pred)

plt.figure()
sns.heatmap(cm, annot=True, fmt='d')
plt.title("Confusion Matrix")
plt.xlabel("Predicted")
plt.ylabel("Actual")
plt.show(block=True)


# Improving churn detection using Random Forest
from sklearn.metrics import accuracy_score, confusion_matrix, classification_report
from sklearn.ensemble import RandomForestClassifier
rf_model = RandomForestClassifier(random_state=42)
rf_model.fit(X_train, y_train)
rf_y_pred = rf_model.predict(X_test)
rf_accuracy = accuracy_score(y_test, rf_y_pred)
print(f'Random Forest Accuracy: {rf_accuracy}')
print(f'Random Forest Classification Report:\n{classification_report(y_test, rf_y_pred)}')
print(f'Random Forest Confusion Matrix:\n{confusion_matrix(y_test, rf_y_pred)}')
