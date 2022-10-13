devtools::install_github("avramies/value_sports_betting/betting")
library(betting)
library(tidyverse)
library(RSelenium)
library(rvest)
library(netstat)
library(data.table)


remDr <- rsDriver(browser = "firefox",
                  port=4445L)

clean_nba <- function(){
  season = "2011-2012"
  pages = 1:23
  allData = NA
  for(page in pages){
    remDr$client$navigate(paste0("https://www.oddsportal.com/basketball/usa/nba-",season,"/results/#/page/",page,"/"))
    nba <- remDr$client$findElement(using = "id", "tournamentTable")
    nba_html <- nba$getPageSource()
    the_full_html <- read_html(nba_html %>% unlist())
    data_frame = html_table(the_full_html)
    colnames(data_frame[[1]]) <- c(1,2,3,4,5,6,7)
    data_frame[[1]]$'5' = na_if(data_frame[[1]]$'5', "-")
    data_frame[[1]]$'6' = na_if(data_frame[[1]]$'6', "-")
    
    cleaned_dataframe = clean_scraped(as.data.frame(data_frame[[1]]))
    
    if(!is.data.frame(allData)){
      allData = cleaned_dataframe
    }else{
      allData = rbind(allData, cleaned_dataframe)
    }
    
  }
  write.csv(allData, file = paste0("/Users/avrahamschwalb/Documents/value_sports_betting/project/data/nba/",season,".csv"), row.names = F)
}
debugonce(clean_nba)
cleaned = clean_nba()


clean_mlb <- function(pages,season){

  allData = NA
  for(page in pages){
    remDr$client$navigate(paste0("https://www.oddsportal.com/baseball/usa/mlb-",season,"/results/#/page/",page,"/"))
    mlb <- remDr$client$findElement(using = "id", "tournamentTable")
    mlb_html <- mlb$getPageSource()
    the_full_html <- read_html(mlb_html %>% unlist())
    data_frame = html_table(the_full_html)
    colnames(data_frame[[1]]) <- c(1,2,3,4,5,6,7)
    data_frame[[1]]$'5' = na_if(data_frame[[1]]$'5', "-")
    data_frame[[1]]$'6' = na_if(data_frame[[1]]$'6', "-")
    
    cleaned_dataframe = clean_mlb_scraped(as.data.frame(data_frame[[1]]))
    
    if(!is.data.frame(allData)){
      allData = cleaned_dataframe
    }else{
      allData = rbind(allData, cleaned_dataframe)
    }
    
  }
  write.csv(allData, file = paste0("/Users/avrahamschwalb/Documents/value_sports_betting/project/data/mlb/",season,".csv"), row.names = F)
}

debugonce(clean_mlb)
clean_mlb(1:58, "2020")

seasons = c("2019","2018","2017","2016","2015","2014","2013","2012")

for (season in seasons){
  clean_mlb(1:58, season)
}

clean_nfl <- function(pages,season){
  
  allData = NA
  for(page in pages){
    remDr$client$navigate(paste0("https://www.oddsportal.com/american-football/usa/nfl-",season,"/results/#/page/",page,"/"))
    mlb <- remDr$client$findElement(using = "id", "tournamentTable")
    mlb_html <- mlb$getPageSource()
    the_full_html <- read_html(mlb_html %>% unlist())
    data_frame = html_table(the_full_html)
    colnames(data_frame[[1]]) <- c(1,2,3,4,5,6,7)
    data_frame[[1]]$'5' = na_if(data_frame[[1]]$'5', "-")
    data_frame[[1]]$'6' = na_if(data_frame[[1]]$'6', "-")
    
    cleaned_dataframe = clean_mlb_scraped(as.data.frame(data_frame[[1]]))
    
    if(!is.data.frame(allData)){
      allData = cleaned_dataframe
    }else{
      allData = rbind(allData, cleaned_dataframe)
    }
    
  }
  write.csv(allData, file = paste0("/Users/avrahamschwalb/Documents/value_sports_betting/project/data/nfl/",season,".csv"), row.names = F)
}

debugonce(clean_nfl)
clean_nfl(1:7, "2009-2010")
