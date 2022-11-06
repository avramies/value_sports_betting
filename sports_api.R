install.packages(c("httr", "jsonlite"))
library(httr)
library(jsonlite)

sports = GET("https://api.the-odds-api.com/v4/sports/?apiKey=60526278ac106d102d093ce926ffafc8")



fromJSON(rawToChar(sports$content))

sports2 = GET("https://api.the-odds-api.com/v4/sports/upcoming/odds/?regions=us&markets=h2h&apiKey=60526278ac106d102d093ce926ffafc8")

x = fromJSON(rawToChar(sports2$content))
