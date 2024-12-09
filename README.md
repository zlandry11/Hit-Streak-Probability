# Estimating the Probability of Luis Arraez Achieving a 20-Game Hitting Streak

To estimate the probability of Luis Arraez achieving a hitting streak of 20 or more games in the upcoming season, we implement a **Bayesian Monte Carlo simulation** in R. This approach combines Bayesian probability updating with Monte Carlo simulations, allowing us to model game outcomes with adaptive probabilities and capture variability over the course of a simulated season. The Bayesian aspect enables us to start with prior information about Arraez's hitting ability, which is then updated dynamically as we simulate each game. This leads to a model that accounts for natural streaks or slumps throughout the season.

## Setting Prior Parameters

The first step is to set up prior parameters based on Arraez's historical performance. With a substantial sample size of 2,624 career at-bats, Arraez’s career batting average provides a reliable measure of his hitting ability and serves as a solid basis for estimating his probability of getting a hit in any game. 

The **Beta distribution** is well-suited for this scenario because it models probabilities on a continuous scale between 0 and 1, with parameters **α (alpha)** and **β (beta)** representing prior “successes” and “failures,” respectively. 

- **α = 847**: Represents the number of prior hits
- **β = 1,777**: Represents the number of prior at-bats without a hit

These parameters suggest a Beta distribution centered around Arraez's career batting average with a high degree of confidence due to the large sample size.

## Defining the Simulation Function

Next, we define a function to simulate one season with Bayesian updating. This function initializes the simulated season with Arraez’s prior hit probability represented by alpha and beta. Instead of assuming a fixed hit probability for each game, we model each game as a series of individual at-bats. 

### Key Steps in the Function:

1. **Initialize Hit Probability**  
   - Sample a hit probability from the current Beta distribution using `rbeta`, which reflects our belief about his likelihood of getting a hit in that at-bat, including updates from prior results

2. **Simulate At-Bats**  
   - Use `rpois` to model the number of at-bats per game based on the average since Arraez’s rookie season (2019)
   - For each at-bat, perform a binomial trial (`rbinom`) to determine if Arraez gets a hit
     - If successful, mark the game as a “success,” increment the streak counter, and update **α**
     - If unsuccessful, update **β**
   - If no at-bats in a game result in a hit, reset the streak counter to zero and record the maximum streak length

## Running Monte Carlo Simulations

The simulation is run **10,000 times**, with each iteration representing a full season. For each simulated season, the function returns the maximum hitting streak length, stored in an array. 

- **Simulation Process:**  
  - Repeated random sampling is used to estimate probabilities under conditions of uncertainty and randomness
  - At the end of all simulations, the maximum streak lengths are analyzed

## Calculating the Probability

The empirical probability of a 20-game hitting streak is calculated by:  

Probability = $\frac{\text{Number of Seasons with a Streak ≥ 20 Games}}{\text{Total Number of Simulations}}$

This provides an estimate of Arraez's likelihood of achieving such a streak in a typical season.

## Results and Insights

The Bayesian Monte Carlo simulation approach provides a realistic and adaptive estimate by allowing Arraez’s hit probability to vary within each season based on prior knowledge and game-by-game performance. The use of Bayesian updating with the Beta distribution enables the model to be responsive to hot streaks or slumps, making it reflective of real baseball dynamics.

- **Final Output:**  
  A **0.12%** probability of Arraez achieving a hitting streak of at least 20 games in the upcoming season

### Potential Model Enhancements:
- Incorporate contextual factors for each at-bat, such as opposing pitcher or ballpark
- Place greater weight on recent performance to reflect in-season adjustments and changes in performance

This comprehensive approach offers valuable insights into the dynamics of hitting streaks and the probabilities of their occurrence in professional baseball.
