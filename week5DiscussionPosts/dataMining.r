#load libraries
library(ggplot2)
library(kableExtra)
library(cluster)
library(gridExtra)

#Generate sample data
set.seed(12484)  
data <- matrix(rnorm(400, mean = rep(1:4, each = 100), sd = 0.7), ncol = 2)
colnames(data) <- c("Feature1", "Feature2")
df <- data.frame(data, Feature1 = data[,1], Feature2 = data[,2])

#Visualize the data
rawPlot <- ggplot(df, aes(x = Feature1, y = Feature2)) +
  geom_point(color = "blue", alpha = 0.7) +
  labs(x = "Feature 1", y = "Feature 2", title = "Sample Data") +
  theme_minimal()

#K-means clustering
num_clusters <- 4

# Fit K-means clustering model
kmeans_result <- kmeans(data, centers = num_clusters, nstart = 25)

# Display the cluster centers
kmeans_result$centers %>% kable() %>% kable_styling()

# Add cluster assignments to the dataset
df$Cluster <- as.factor(kmeans_result$cluster)

# Visualize the K-means clusters
kMeansPlot <- ggplot(df, aes(x = Feature1, y = Feature2, color = Cluster)) +
  geom_point(alpha = 0.7) +
  geom_point(data = as.data.frame(kmeans_result$centers), aes(x = Feature1, y = Feature2), 
             color = "black", size = 3, shape = 4) +
  labs(x = "Feature 1", y = "Feature 2", title = "Clustered Data") +
  theme_minimal()

# Perform PCA
pca_result <- prcomp(data, scale. = TRUE)

# Visualize the proportion of variance explained by each principal component
pca_var_explained <- pca_result$sdev^2 / sum(pca_result$sdev^2)
cumulative_var_explained <- cumsum(pca_var_explained)

# Generate some example association rules
rules <- data.frame(
  antecedent = c("Milk", "Bread", "Milk", "Beer"),
  consequent = c("Bread", "Milk", "Beer", "Diapers"),
  support = c(0.4, 0.3, 0.2, 0.1),
  confidence = c(0.6, 0.5, 0.4, 0.7)
)

# Visualize association rules
associationPlot <- ggplot(rules, aes(x = support, y = confidence)) +
  geom_point(color = "red") +
  geom_text(aes(label = paste(antecedent, "->", consequent)), 
            hjust = 0, vjust = 0) +
  labs(x = "Support", y = "Confidence", title = "Association Rules") +
  theme_minimal()

# Arrange all plots
grid.arrange(rawPlot, kMeansPlot, associationPlot, ncol = 2)


