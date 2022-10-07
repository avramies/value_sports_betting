# function for converting decimal odds to implied probabilities
odds_to_implied_probability <- function(odds, odds_type = "decimal"){
  odds = as.numeric(odds)
  if (odds_type == "fractional"){
    odds = convert_odds(odds, initial_odds_type = "fractional")
    prob = 1 / odds
    return(prob)
  } else if (odds_type == "american"){
    odds = convert_odds(odds, initial_odds_type = "american")
    prob = 1 / odds
    return(prob)
  }else if(odds_type == "decimal"){
    prob = 1 / odds
    return(prob)
  }
}
