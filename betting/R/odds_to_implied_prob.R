# function for converting decimal odds to implied probabilities
odds_to_implied_probability <- function(odds){
  odds = as.numeric(odds)
  odds = convert_odds(odds)
  prob = 1 / odds
  return(prob)
}
