
#create a data frame of colours
colours_data<-data.frame(
colors =c("red", "green", "blue"),
frequency = c(3,4,5)
)print(colours_data)



# Numbers data
numbers <- c(20, 13, 6, 4, 2, 8, 10, 26, 23, 33, 46, 54, 40, 32, 26, 28, 27,10, 6, 4, 8, 9, 11, 18, 23, 30, 44, 50, 51, 52)
# Define the intervals (bins)
bins <- seq(0, 60, by = 10)
# Cut the numbers into intervals
grouped_freq <- cut(numbers, bins, right = FALSE)
# Create the frequency table
grouped_freq_table <- table(grouped_freq)
print(grouped_freq_table)
# Create the frequency table without intervals
numbers_freq_table <- table(numbers)
# Print the frequency table
print(numbers_freq_table)
# Numbers data
numbers <- c(20, 13, 6, 4, 2, 8, 10, 26, 23, 33, 46, 54, 40, 32, 26, 28, 27,
10, 6, 4, 8, 9, 11, 18, 23, 30, 44, 50, 51, 52)
# Define the intervals (bins)
bins <- seq(0, 60, by = 10)
# Create the grouped frequency table
grouped_freq <- cut(numbers, bins, right = FALSE)
# Frequency table
freq_table <- table(grouped_freq)
# Convert to a data frame
df <- as.data.frame(freq_table)
# Total observations
total_freq <- sum(df$Freq)
# a. Relative Frequency
df$Relative_Frequency <- df$Freq / total_freq
# b. Percentage Relative Frequency
df$Percentage_Relative_Frequency <- df$Relative_Frequency * 100
# c. Class Boundaries
df$Lower_Boundary <- as.numeric(sub("\\((.+),.*", "\\1", levels(grouped_freq))) - 0.5
df$Upper_Boundary <- as.numeric(sub(".*,(.+)\\]", "\\1", levels(grouped_freq))) + 0.5
# d. Class Limits
df$Lower_Limit <- as.numeric(sub("\\((.+),.*", "\\1", levels(grouped_freq)))
df$Upper_Limit <- as.numeric(sub(".*,(.+)\\]", "\\1", levels(grouped_freq)))
# e. Cumulative Frequencies
df$Less_than_Cumulative_Frequency <- cumsum(df$Freq)
df$More_than_Cumulative_Frequency <- rev(cumsum(rev(df$Freq)))
# Print the final data frame
print(df)
# Load libraries
library(ggplot2)
# Data
colors <- c("Red", "Green", "Blue")
frequencies <- c(3, 4, 5)
numbers <- c(20, 13, 6, 4, 2, 8, 10, 26, 23, 33, 46, 54, 40, 32, 26, 28, 27,
10, 6, 4, 8, 9, 11, 18, 23, 30, 44, 50, 51, 52)
# Grouped Data
bins <- seq(0, 60, by = 10)
grouped_freq <- cut(numbers, bins, right = FALSE)
grouped_table <- table(grouped_freq)
# 1. Pie Chart
pie(frequencies, labels = colors, main = "Pie Chart of Colors")
# 2. Bar Graph
barplot(frequencies, names.arg = colors, col = c("black", "darkred", "darkgreen"), main = "Bar Graph of Colors")
# 3. Histogram
hist(numbers, breaks = bins, col = "blue", main = "Histogram of Numbers", xlab = "Number Range", ylab = "Frequency")
# 4. Frequency Polygon
plot(midpoints <- (bins[-1] + bins[-length(bins)])/2, grouped_table, type = "o", col = "blue",
xlab = "Class Midpoint", ylab = "Frequency", main = "Frequency Polygon")
# 5. Less Than Ogive
less_than_cum <- cumsum(grouped_table)
plot(bins[-1], less_than_cum, type = "o", col = "green", xlab = "Upper Class Limit", ylab = "Cumulative Frequency",
main = "Less Than Ogive")
# 6. More Than Ogive
more_than_cum <- rev(cumsum(rev(grouped_table)))
plot(bins[-length(bins)], more_than_cum, type = "o", col = "red", xlab = "Lower Class Limit", ylab = "Cumulative Frequency",
main = "More Than Ogive")
# 7. Stem and Leaf Plot
stem(numbers)
# 8. Box Plot
boxplot(numbers, main = "Box Plot of Numbers")
# 9. Scatter Plot
plot(numbers, main = "Scatter Plot of Numbers", xlab = "Index", ylab = "Numbers", pch = 16)





