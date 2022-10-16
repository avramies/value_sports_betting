# value_sports_betting
Convert Pinnacle odds to probability, check the calibration of those probabilities, and if calibrated use these odds to identify bets in which other sportsbooks have offered "good" odds compared to the "actual" probability.
## Steps Taken
1. Create functions for converting american odds to decimal, and getting implied probability
2. scraped and cleaned historical pinnacle odds for MLB, NBA, and NFl
3. checked the calibration of the above odds

## Steps to take
1. use api to get fanduel historical odds for nba, mlb, and nfl
2. match the odds from fanduel with the odds from pinnacle
3. find value bets
4. paper trade those bets and see if it there was value there, as opposed to a non - value based system
