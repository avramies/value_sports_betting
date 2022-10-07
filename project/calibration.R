library(tidyverse)
library(data.table)
library(skimr)
library(corrplot)
setwd("/Users/avrahamschwalb/Documents/value_sports_betting/project/data/nba")



nba <- 
  list.files(pattern = "*.csv") %>% 
  map_df(~fread(.))

attach(nba)

skim(nba)

nba = nba %>%
  mutate(home_win = if_else(home_score > away_score, 0, 1)) %>%
  mutate(away_win = if_else(home_win == 0, 1, 0)) %>%
  mutate(home_win = as.factor(home_win),away_win = as.factor(away_win), home_team = as.factor(home_team), away_team = as.factor(away_team))

calibration = calibration(nba$home_win ~ nba$home_prob)
ggplot(calibration)
  

nba %>%
  ggplot(aes(x = home_prob)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white")+
  geom_density(alpha=.2, fill="#FF6666") + theme_classic()

corrplot(cor(select(nba, -date, -time, -home_team, -away_team)), method = "number")



