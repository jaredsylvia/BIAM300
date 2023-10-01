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
