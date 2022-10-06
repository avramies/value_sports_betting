# value_sports_betting
Convert Pinnacle odds to probability, check the calibration of those probabilities, and if calibrated use these odds to identify bets in which other sportsbooks have offered "good" odds compared to the "actual" probability.
## Different Methods of Stating Odds
**_Fractional_**  
Fractional odds quote the potential **profit** should the bet succeed, relative to the stake. For example, if $10 was placed on an outcome with 2/1 fractional odds, the potential profit is $20 ($10 * 2)  
**_Decimal_**  
Decimal odds quote the potential **return** should the bet succeed, relative to the stake. For example, if $10 was placed on an outcome with decimal odds of 3, the potential return would be $30 ($10 * 3)  
**_American_**  
American odds depend on if the odds are positive or negative. If they are positive, then the odds state the potential profit on a $100 bet. For example, if the odds are +200, then on a $100 bet you will profit $200. If you bet $50 on that same bet, you will profit $100. If they are negative, then the odds state the required stake in order to receive a $100 profit. For example, if the odds are -200, then a $200 bet will profit $100. If you bet $100 on that same bet, you will profit $50.


## Functions
**_convert_odds_**  
  converts american, decimal, and fractional odds to either of the other two odds formats. The default is to convert american odds to decimal odds because that is the format on the website we will be scraping for pinnacle odds 

**_odds_to_implied_probability_**  
  converts american, decimal, and fractional odds to their implied probability. The default is decimal because we will be converting all odds that we scrape to decimal odds
