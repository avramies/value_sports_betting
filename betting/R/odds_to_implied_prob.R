# function for converting decimal odds to implied probabilities
odds_to_implied_probability <- function(odds){
  odds = as.numeric(odds)
  odds = convert_american_to_decimal(odds)
  prob = 1 / odds
  return(prob)
}
