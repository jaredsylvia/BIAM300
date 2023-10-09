library(rpart.plot)

# Set seed for reproducibility
set.seed(12484)

# Generate 1000 semi-random loan applicants
n_applicants <- 1000

# Generate random ages with higher values likely to have higher incomes
ages <- mvrnorm(n_applicants, mu = c(40, 60),
                Sigma = matrix(c(100, 30, 30, 100), nrow = 2))
age1 <- pmax(18, pmin(ages[, 1], 100))  # Ensure ages are within a reasonable range
age2 <- pmax(18, pmin(ages[, 2], 100))  # Ensure ages are within a reasonable range

# Generate random incomes based on age
incomes <- 2000 + 30 * as.vector(age1) +
           rnorm(n_applicants, mean = 0, sd = 5000)

# Generate binary variable for house ownership (higher for older applicants)
house_ownership <- ifelse(age2 > 50, "yes",
                          ifelse(age2 <= 50, "no",
                                 ifelse(rbinom(n_applicants, 1, 0.3) == 1, "yes", "no")))

# Generate random credit scores
credit_scores <- rnorm(n_applicants, mean = 700, sd = 100)

# Create a data frame for the loan applicants
loan_applicants <- data.frame(Age = age1, Income = incomes,
                              HouseOwnership = house_ownership,
                              CreditScore = credit_scores)

# Print summary of generated data
summary(loan_applicants)

# Perform a linear regression
regression_model <- lm(Income ~ Age + HouseOwnership + CreditScore,
                       data = loan_applicants)

# Print summary of regression results
summary(regression_model)

# Perform classification using a decision tree
tree_model <- rpart(factor(HouseOwnership) ~ Age + Income + CreditScore,
                    data = loan_applicants, method = "class")

# Plot the classification tree with colored leaves and yes/no decisions
rpart.plot(tree_model, type = 3, extra = 1, fallen.leaves = TRUE, yesno = TRUE)