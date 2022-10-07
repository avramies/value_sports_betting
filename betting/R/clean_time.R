clean_time <- function(cleaned_date){
  colnames(cleaned_date)[2] <- "time"
  row = nrow(cleaned_date)
  while(row >= 1){
    if(!grepl(":",cleaned_date[row,2])){
      cleaned_date = cleaned_date[-row,]
    }
    row = row - 1
  }
  return(cleaned_date)
}