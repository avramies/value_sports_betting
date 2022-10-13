clean_mlb_scraped <- function(uncleaned){

  # clean date
  uncleaned = uncleaned %>%
    mutate(date = uncleaned[,1]) %>%
    select(date, everything())

  no_of_rows = nrow(uncleaned)
  row = 1

  while (row <= nrow(uncleaned)){

    date = uncleaned[row,1]
    row_plus = 1

    while((!grepl("Jun|May|Apr|Mar|Feb|Jan|Dec|Nov|Oct|Sep|Aug|Jul",uncleaned[row+row_plus,1]))&(row+row_plus)<= no_of_rows){
      uncleaned[row+row_plus,1] = date
      row_plus = row_plus + 1
    }

    row = row + row_plus
  }

  uncleaned = mutate(uncleaned, date = gsub("^(...........).*","\\1",date))

  months <- c("Jan" = "01", "Feb" = "02", "Mar" = "03", "Apr" = "04", "May" = "05",
              "Jun" = "06", "Jul" = "07", "Aug" = "08", "Sep" = "09", "Oct" = "10",
              "Nov" = "11", "Dec" = "12")
  uncleaned$month = unname(months[gsub("...(...).....","\\1",uncleaned$date)])
  uncleaned$day = gsub("(..).........","\\1",uncleaned$date)
  uncleaned$year = gsub(".......(....)","\\1",uncleaned$date)
  uncleaned$date = paste0(uncleaned$month,"/",uncleaned$day,"/",uncleaned$year)

  cleaned_date = uncleaned[,c(-9,-10,-11)]

# clean time
  colnames(cleaned_date)[2] <- "time"
  row = nrow(cleaned_date)
  while(row >= 1){
    if(!grepl(":",cleaned_date[row,2])){
      cleaned_date = cleaned_date[-row,]
    }
    row = row - 1
  }

  cleaned_time = cleaned_date

  # cleaned teams
  colnames(cleaned_time)[3:8] <- c("home_team","away_team","scores","home_odds","away_odds","delete")
  cleaned_time = cleaned_time[,-8]

  cleaned_teams = mutate(cleaned_time, home_team = gsub("^(.+) - .+","\\1", home_team))
  cleaned_teams = mutate(cleaned_teams, away_team = gsub("^.+ - (.+)", "\\1", away_team))

  # cleaned_scores

  cleaned_teams = mutate(cleaned_teams, home_score = gsub("^(..*):.+","\\1",scores))
  cleaned_teams = mutate(cleaned_teams, away_score = gsub("^..+:(.\\d*) *O*T*", "\\1",scores))
  cleaned_teams = mutate(cleaned_teams, away_score = gsub("^(\\d\\d*).*", "\\1",away_score))

  cleaned_scores = cleaned_teams[,-5]

  cleaned_scores = mutate(cleaned_scores, home_prob = odds_to_implied_probability(home_odds),
         away_prob = odds_to_implied_probability(away_odds))

  cleaned_scores = cleaned_scores %>%
    mutate(pinnacle_margin = home_prob + away_prob - 1)
  return(cleaned_scores)


}
