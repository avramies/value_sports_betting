clean_scores <- function(cleaned_teams){
  cleaned_teams = mutate(cleaned_teams, home_score = gsub("^(..+):.+","\\1",scores))
  cleaned_teams = mutate(cleaned_teams, away_score = gsub("^..+:(..\\d*) *O*T*", "\\1",scores))
  cleaned_teams = mutate(cleaned_teams, away_score = gsub("^(\\d\\d+).*", "\\1",away_score))
  
  cleaned_teams = cleaned_teams[,-5]
  
  return(cleaned_teams)
}