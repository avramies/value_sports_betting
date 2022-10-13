# function for converting odds
convert_american_to_decimal <- function(odds){
  odds = as.numeric(odds)
    ifelse(odds > 0,
           decimal = 1 + (odds / 100),
           decimal = 1 - (100 / odds))
    return(decimal)
}
