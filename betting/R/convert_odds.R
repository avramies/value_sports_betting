# function for converting odds
convert_odds <- function(odds, initial_odds_type = "american"){
  odds = as.numeric(odds)
  if(initial_odds_type == "american"){
    if(odds > 0){
      decimal = 1 + (odds / 100)
    }else{
      decimal = 1 - (100 / odds)
    }
    return(decimal)
  }else if (initial_odds_type == "fractional"){
    decimal = odds + 1
    return (decimal)
  }
}
