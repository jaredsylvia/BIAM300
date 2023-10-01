# Load packages
library(rpart)
library(rpart.plot)

# Load data
data(iris)

# Train classification tree model
tree_class <- rpart(Species ~ ., data = iris, method = "class", control = rpart.control(minsplit = 5, cp = 0.01))

# Train regression tree model
tree_reg <- rpart(Sepal.Length ~ ., data = iris, method = "anova", control = rpart.control(minsplit = 5, cp = 0.01))

# Plot classification tree
p_class <- prp(tree_class, extra = 1, box.col = c("#999999", "#E69F00", "#56B4E9"), branch.lty = 3, branch.lwd = 2, cex = 1.2, varlen = 0, faclen = 0, tweak = 1.2)

# Plot regression tree
p_reg <- prp(tree_reg, extra = 1, box.col = c("#999999", "#E69F00", "#56B4E9"), branch.lty = 3, branch.lwd = 2, cex = 1.2, varlen = 0, faclen = 0, tweak = 1.2)

# Prune trees
tree_class_pruned <- prune(tree_class, cp = 0.05)
tree_reg_pruned <- prune(tree_reg, cp = 0.05)

# Plot pruned classification tree
p_class_pruned <- prp(tree_class_pruned, extra = 1, box.col = c("#999999", "#E69F00", "#56B4E9"), branch.lty = 3, branch.lwd = 2, cex = 1.2, varlen = 0, faclen = 0, tweak = 1.2)

# Plot pruned regression tree
p_reg_pruned <- prp(tree_reg_pruned, extra = 1, box.col = c("#999999", "#E69F00", "#56B4E9"), branch.lty = 3, branch.lwd = 2, cex = 1.2, varlen = 0, faclen = 0, tweak = 1.2)

# Partition data into training and test sets
set.seed(12484)
train <- sample(1:nrow(iris), 0.7 * nrow(iris))
test <- setdiff(1:nrow(iris), train)

# Train classification tree model from training data
tree_class_train <- rpart(Species ~ ., data = iris[train,], method = "class", control = rpart.control(minsplit = 5, cp = 0.01))

# Train regression tree model from training data
tree_reg_train <- rpart(Sepal.Length ~ ., data = iris[train,], method = "anova", control = rpart.control(minsplit = 5, cp = 0.01))

# Predict classification tree model on test data
pred_class <- predict(tree_class_train, iris[test,], type = "class")

# Predict regression tree model on test data
pred_reg <- predict(tree_reg_train, iris[test,])

# Calculate classification accuracy
accuracy <- sum(pred_class == iris[test, "Species"]) / length(pred_class)

# Calculate mean squared error
mse <- mean((pred_reg - iris[test, "Sepal.Length"])^2)

# Display classification accuracy and mean squared error
print(paste("Classification accuracy:", round(accuracy, 2)))
print(paste("Mean squared error:", round(mse, 2)))