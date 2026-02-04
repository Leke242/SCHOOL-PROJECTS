
customer_data <- data.frame(
  CustomerID = 1:100,  # 100 customers
  Age = sample(18:70, 100, replace = TRUE),
  Income = sample(20000:120000, 100, replace = TRUE),
  SpendingScore = sample(1:100, 100, replace = TRUE)
)

# View the first few rows of the data
head(customer_data)
