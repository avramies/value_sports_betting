# function for converting odds
convert_american_to_decimal <- function(odds){
  odds = as.numeric(odds)
    decimal = ifelse(odds > 0,
                     1 + (odds / 100),
                     1 - (100 / odds))
    return(decimal)
}
