clean_scraped <- function(uncleaned){
  
  cleaned_date = clean_date(uncleaned)
  cleaned_time = clean_time(cleaned_date)
  cleaned_teams = clean_teams(cleaned_time)
  cleaned_scores = clean_scores(cleaned_teams)
  
  for(row in 1:nrow(cleaned_scores)){
    cleaned_scores$home_prob[row] = odds_to_implied_probability(cleaned_scores$home_odds[row], "american")
    cleaned_scores$away_prob[row] = odds_to_implied_probability(cleaned_scores$away_odds[row], "american")
  }
  
  cleaned_scores = cleaned_scores %>%
    mutate(pinnacle_margin = home_prob + away_prob - 1)
  return(cleaned_scores)
  
  
}