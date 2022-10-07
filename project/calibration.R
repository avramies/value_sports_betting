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
  mutate(home_win = if_else(home_score > away_score, 1, 0)) %>%
  mutate(away_win = if_else(home_win == 0, 1, 0))

nba %>%
  ggplot(aes(x = home_prob)) +
  geom_histogram(aes(y=..density..), colour="black", fill="white")+
  geom_density(alpha=.2, fill="#FF6666") + theme_classic()

corrplot(cor(select(nba, -date, -time, -home_team, -away_team)), method = "number")

case_when()

