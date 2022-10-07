clean_teams <- function(cleaned_time){
  colnames(cleaned_time)[3:8] <- c("home_team","away_team","scores","home_odds","away_odds","delete")
  cleaned_time = cleaned_time[,-8]
  
  cleaned_teams = mutate(cleaned_time, home_team = gsub("^(.+) - .+","\\1", home_team))
  cleaned_teams = mutate(cleaned_teams, away_team = gsub("^.+ - (.+)", "\\1", away_team))
  
  return(cleaned_teams)
}