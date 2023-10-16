# Monte Carlo Simulation
import random
import matplotlib.pyplot as plt

# Card class
class Card:
    def __init__(self, suit, rank):
        self.suit = suit
        self.rank = rank

    def get_suit(self):
        return self.suit

    def get_rank(self):
        return self.rank

    def __str__(self):
        return f"{self.rank} of {self.suit}"

# Deck class
class Deck:
    def __init__(self):
        self.deck = []
        self.build()
        
    def build(self):
        suits = ['Spades', 'Hearts', 'Diamonds', 'Clubs']
        ranks = ['Ace', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King']
        for suit in suits:
            for rank in ranks:
                self.deck.append(Card(suit, rank))

    def shuffle(self):
        random.shuffle(self.deck)

    def draw_card(self):
        return self.deck.pop()
    
# Function to get a positive integer input from the user
def get_positive_integer(prompt):
    while True:
        try:
            value = int(input(prompt))
            if value <= 0:
                print("Please enter a positive integer.")
            else:
                return value
        except ValueError:
            print("Please enter a valid positive integer.")


# Get user input for drawSize and sampleSize
drawSize = get_positive_integer("Enter the number of cards to draw for each sample: ")
sampleSize = get_positive_integer("Enter the number of samples to draw: ")

sample_cards = []


# Draw sample
for i in range(sampleSize):
    deck = Deck()
    deck.shuffle()
    for _ in range(drawSize):
        sample_cards.append(deck.draw_card())

# Calculate proportions for just the suit
suit_proportions = {}
for card in sample_cards:
    suit = card.get_suit()
    suit_proportions[suit] = suit_proportions.get(suit, 0) + 1 / len(sample_cards)

# Calculate proportions for just the rank
rank_proportions = {}
for card in sample_cards:
    rank = card.get_rank()
    rank_proportions[rank] = rank_proportions.get(rank, 0) + 1 / len(sample_cards)

# Calculate proportions for both suit and rank
both_proportions = {}
for card in sample_cards:
    card_str = f"{card.get_rank()} of {card.get_suit()}"
    both_proportions[card_str] = both_proportions.get(card_str, 0) + 1 / len(sample_cards)

# Function to predict deck composition using Monte Carlo
def predict_deck_composition(proportions):
    predicted_deck_composition = {item: 0 for item in proportions.keys()}
    
    num_simulations = 1000
    for _ in range(num_simulations):
        # Simulate the rest of the deck based on the proportions
        simulated_deck = random.choices(list(proportions.keys()), k=52 - len(sample_cards), weights=list(proportions.values()))
        for item in simulated_deck:
            predicted_deck_composition[item] += 1
    
    return predicted_deck_composition

# Predict deck composition for each case
predicted_suit_deck_composition = predict_deck_composition(suit_proportions)
predicted_rank_deck_composition = predict_deck_composition(rank_proportions)
predicted_both_deck_composition = predict_deck_composition(both_proportions)

# Display the predicted deck composition for each case
print("Predicted Deck Composition for Suit:")
for suit, count in predicted_suit_deck_composition.items():
    print(f"{suit}: {count}")

print("\nPredicted Deck Composition for Rank:")
for rank, count in predicted_rank_deck_composition.items():
    print(f"{rank}: {count}")

print("\nPredicted Deck Composition for Both Suit and Rank:")
for item, count in predicted_both_deck_composition.items():
    print(f"{item}: {count}")

# Visualize the proportions for just the suit
plt.bar(suit_proportions.keys(), suit_proportions.values())
plt.xlabel('Suit')
plt.ylabel('Proportion')
plt.title('Proportions of Suits in the Sample')
plt.xticks(rotation=30, ha='right', fontsize=8)
plt.tight_layout()
plt.show()

# Visualize the proportions for just the rank
plt.bar(rank_proportions.keys(), rank_proportions.values())
plt.xlabel('Rank')
plt.ylabel('Proportion')
plt.title('Proportions of Ranks in the Sample')
plt.xticks(rotation=30, ha='right', fontsize=8)
plt.tight_layout()
plt.show()

# Visualize the proportions for both suit and rank
plt.bar(both_proportions.keys(), both_proportions.values())
plt.xlabel('Card')
plt.ylabel('Proportion')
plt.title('Proportions of Cards (Suit and Rank) in the Sample')
plt.xticks(rotation=30, ha='right', fontsize=6)
plt.tight_layout()
plt.show()
