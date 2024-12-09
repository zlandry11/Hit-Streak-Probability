# Define prior parameters based on career batting average
alpha_prior <- 847   # Hits
beta_prior <- 1777   # Misses
num_simulations <- 10000  # Number of simulated seasons
num_games <- 162  # Games per season

# Define the average number of at-bats per game
average_at_bats <- 2.285

# Function to simulate one season with Bayesian updating
simulate_season <- function(alpha_prior, beta_prior) {
  
  alpha <- alpha_prior
  beta <- beta_prior
  
  max_streak <- 0
  current_streak <- 0
  
  for (game in 1:num_games) {
    # Determine number of at-bats for this game
    num_at_bats <- rpois(1, average_at_bats)
    game_hit <- 0  # Tracks if he gets a hit in this game
    
    # Simulate each at-bat within the game
    for (at_bat in 1:num_at_bats) {
      # Sample a hit probability from the current Beta distribution
      hit_prob <- rbeta(1, alpha, beta)
      hit <- rbinom(1, 1, hit_prob)
      
      # If a hit occurs, mark the game as a hit and update alpha
      if (hit == 1) {
        game_hit <- 1
        alpha <- alpha + 1  # Update alpha for each hit
      } else {
        beta <- beta + 1  # Update beta for each miss
      }
    }
    
    # Update streaks based on whether he got a hit in the game
    if (game_hit == 1) {
      current_streak <- current_streak + 1
    } else {
      max_streak <- max(max_streak, current_streak)
      current_streak <- 0
    }
  }
  
  # Record the maximum streak length
  max(max_streak, current_streak)
}

# Run simulations
set.seed(42)  # For reproducibility
streaks <- replicate(num_simulations, simulate_season(alpha_prior, beta_prior))

# Calculate probability of achieving a 20-game hitting streak
streak_20_or_more <- sum(streaks >= 20)
prob_20_game_streak <- streak_20_or_more / num_simulations

cat("Probability of at least one 20-game hitting streak for Luis Arraez:", round(prob_20_game_streak*100, 2),"%\n")
