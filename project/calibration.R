library(tidyverse)
library(data.table)
library(skimr)
library(corrplot)
library(caret)
library(vroom)

folders = c("nba", "mlb","nfl")
for (folder in folders){
  setwd(paste0("/Users/avrahamschwalb/Documents/value_sports_betting/project/data/", folder))
  assign(folder, 
         list.files(pattern = "*.csv") %>%
           vroom())
}

nba <- nba %>%
  mutate(home_odds = as.numeric(home_odds), away_odds = as.numeric(away_odds), 
         home_score = as.numeric(home_score), away_score = as.numeric(away_score),
         home_true_prob = home_prob/ (home_prob+away_prob),away_true_prob = away_prob / (home_prob + away_prob),
         home_win = if_else(home_score > away_score, 0, 1), away_win = if_else(home_score < away_score, 0, 1)) %>%
  na.omit() %>%
  mutate(home_win = as.factor(home_win), away_win = as.factor(away_win), home_team = as.factor(home_team), away_team = as.factor(away_team))
mlb <- mlb %>%
  mutate(home_odds = as.numeric(home_odds), away_odds = as.numeric(away_odds), 
         home_score = as.numeric(home_score), away_score = as.numeric(away_score),
         home_true_prob = home_prob/ (home_prob+away_prob),away_true_prob = away_prob / (home_prob + away_prob),
         home_win = if_else(home_score > away_score, 0, 1), away_win = if_else(home_score < away_score, 0, 1)) %>%
  na.omit()%>%
  mutate(home_win = as.factor(home_win), away_win = as.factor(away_win), home_team = as.factor(home_team), away_team = as.factor(away_team))
nfl <- nfl %>%
  mutate(home_odds = as.numeric(home_odds), away_odds = as.numeric(away_odds), 
         home_score = as.numeric(home_score), away_score = as.numeric(away_score),
         home_true_prob = home_prob/ (home_prob+away_prob),away_true_prob = away_prob / (home_prob + away_prob),
         home_win = if_else(home_score > away_score, 0, 1), away_win = if_else(home_score < away_score, 0, 1)) %>%
  na.omit()%>%
  mutate(home_win = as.factor(home_win), away_win = as.factor(away_win), home_team = as.factor(home_team), away_team = as.factor(away_team))

all_games = bind_rows(nba, nfl, mlb)

skim(all_games)
skim(nba)
skim(nfl)
skim(mlb)


calibration_home = calibration(nfl$home_win ~ nfl$home_prob + nfl$home_true_prob)
ggplot(calibration_home)
calibration_home = calibration(nfl$home_win ~ nfl$home_prob + nfl$home_true_prob)
ggplot(calibration_home)
calibration_away = calibration(all_games$away_win ~ all_games$away_prob + all_games$away_true_prob)
ggplot(calibration_away)

nba %>%
  ggplot(aes(x = home_prob)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white")+
  geom_density(alpha=.2, fill="#FF6666") + theme_classic()

nfl %>%
  ggplot(aes(x = home_prob)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white")+
  geom_density(alpha=.2, fill="#FF6666") + theme_classic()

mlb %>%
  ggplot(aes(x = home_prob)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white")+
  geom_density(alpha=.2, fill="#FF6666") + theme_classic()

