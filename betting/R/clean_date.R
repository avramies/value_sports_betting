clean_date <- function(uncleaned){
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
  
  uncleaned = uncleaned[,c(-9,-10,-11)]
  
  return(uncleaned)
}