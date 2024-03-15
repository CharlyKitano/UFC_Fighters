library(stringr)

# Example dataframe
data_new = read.csv('D:/IMT MInes Ales/S8/Visualization/Visualization Class/ProjectVisualization5/UFC_Fighters/COMBATANTS_COMPLET.csv')
data = read.csv('D:/IMT MInes Ales/S8/Visualization/Visualization Class/ProjectVisualization5/UFC_Fighters/UFC_Complet.csv')


# Add weight class and gender

tmp <- merge(data, data_new[, c("Name", "gender", "Weight.Class")], by = "Name", all.x = TRUE)
View(tmp)
write.csv(tmp, "./ProjectVisualization5/UFC_Fighters/Final_data_raw.csv")
data <- tmp

extract_before_space <- function(x) {

  if (is.numeric(x)) {
    # If x is numeric, return x as it is
    as.character(x)
  # } else if(lastchar == "%"){
  #   str_extract(x, "[0-9.]+(?=%)")
  }else {
    # If x is not numeric, use regex to extract
    str_extract(x, "[0-9.]+(?= )")
  }
}

# View(data)
# Apply the function to each cell in the dataframe
remove_percent_and_convert <- function(column) {
  # Remove the % sign using gsub and convert to numeric
  as.numeric(gsub("%", "", column))
}

data$Head...Pourcentage <- remove_percent_and_convert(data$Head...Pourcentage)
data$Body...Pourcentage <- remove_percent_and_convert(data$Body...Pourcentage)
data$Leg...Pourcentage <- remove_percent_and_convert(data$Leg...Pourcentage)
data$Sig..Str..Defense <- remove_percent_and_convert(data$Sig..Str..Defense)
data$Takedown.Defense <- remove_percent_and_convert(data$Takedown.Defense)
convert_time <- function(timestring){
  time_components <- strsplit(timestring, ":")[[1]]
  print(time_components)
  minutes <- as.numeric(time_components[1])
  seconds <- as.numeric(time_components[2])
  
  total = minutes + seconds/60
  
  return(total)
}
print(convert_time("3:11"))
data$Average.fight.time = sapply(data$Average.fight.time, convert_time)
include_columns = setdiff(names(data), c("Place of Birth","Status","Octagon Debut","Fighting style", "gender", "Weight.Class"))
data_split <- as.data.frame(lapply(data[include_columns], extract_before_space))
View(data_split)
data_split[c("Place.of.Birth","Status","Octagon.Debut","Fighting.style", "gender", "Weight.Class")] <- data[c("Place.of.Birth","Status","Octagon.Debut","Fighting.style", "gender", "Weight.Class")]

# Convert the result to a dataframe
data_split_df <- as.data.frame(data_split)
# Print the result
# summary(data)
View(data_split_df)



# for (col in include_columns) {
#   if (is.character(data_split_df[[col]])) {
#     data_split_df[[col]] <- as.numeric(data_split_df[[col]])
#   }
# }


# to check for type of column (if it is int or char or anything else)
# column_classes <- lapply(data, class)

# Print the class of each column
# print(column_classes)

data_split_df$Name <- data$Name

write.csv(data_split_df, "./UFC_webapp/Final_data.csv", row.names = FALSE)
# 
# 
# 
# 
# library(ggplot2)
# ggplot(data_split_df, aes(data_split_df$Takedown.avg, data_split_df$Win.by.Method...KO.TKO)) + geom_dotplot(data_split_df$Takedown.avg, data_split_df$Win.by.Method...KO.TKO)
# 
# ggplot(data_split_df) + aes(data_split_df$Takedown.avg, data_split_df$Win.by.Method...KO.TKO) + geom_point()
# 
# include_columns = setdiff(names(data_split_df), )
# 
# pairs(data_split_df)
# 
# 








# 
# 
# 
# 
# 
# 
# 
# data = read.csv('D:/IMT MInes Alès/S8/Visualization/Visualization Class/ProjectVisualization5/test_CSV_UFC.csv')
# View(data[, 2:(ncol(data))])
# summary(data)
# columnnames =names(data)
# 
# data$Name
# # clean percentages
# data$Sig..Str..Par.position...Permanent = strsplit(data$Sig..Str..Par.position...Permanent, " ")[[1]][1]
# data$Sig..Str..Par.position...Clinch = strsplit(data$Sig..Str..Par.position...Clinch, " ")[[1]][1]
# data$Sig..Str..Par.position...Sol = strsplit(data$Sig..Str..Par.position...Sol, " ")[[1]][1]
# data = lapply(data, as.character)
# # data <- lapply(strsplit(data, " "), function(x) x[1])
# data <- lapply(data[, 2:(ncol(data)) ], function(x) strsplit(as.character(x), " "))
# View(data)
# summary(data)
# 
# 
# # data <- lapply(data[, 2:ncol(data)], function(x) {
# #   strsplit(as.character(x), " ")
# # })
# 
# # Split the second to last column by space and select only the elements before space
# # split_data <- lapply(data[, 2:ncol(data)], function(x) {
# #   split_result <- strsplit(as.character(x), " ")[[1]]
# #   View(split_result)
# #   if(length(split_result) > 1) {
# #     split_result <- split_result[1]
# #   }
# #   return(split_result)
# # })
# # 
# # data[1,]
# # View(split_data)
# # class(split_data)
# # split_data <-data.frame(split_data)
# 
# data = read.csv('D:/IMT MInes Alès/S8/Visualization/Visualization Class/ProjectVisualization5/UFC_Fighters/test_CSV_UFC(2).csv')
# # View(data[,2:ncol(data)])
# split_data <- lapply(data[,2:ncol(data)], function(x) {
#   for(i in seq_along(x)){
#     if (is.na(x[i])){
#       
#     }else{
#       split_one_column = strsplit(as.character(x[i]), " ")[[1]]
#       split_one_column_done <- list()
#       if(length(split_one_column) > 1){
#         split_one_column_done[[i]] = split_one_column[1]
#       }else{
#         # split_one_column[[i]] = split_one_column
#         split_one_column_done[[i]] = split_one_column
#       }
#     }
#     
#   }
#   # split_one_column = strsplit(as.character(x), "%")[[1]]
#   # how do i split data in a dataframe and choose only the element that is in front of space for example in a cell, there is a value of 12 (23%), after the split of data, i want it to be just 12 after the split
#   # and the dataframe consist of 950 rows and 31 columns 
#   # for the  fiii i  
#   return(split_one_column_done)
#   
# })
# View(data.frame(split_data))
# split_data <- lapply(split_data, function(x) {
#   
#   
#   for(i in seq_along(x)){
#     if (is.na(x[i])){
#       
#     }else{
#       split_one_column = strsplit(as.character(x[i]), "%")[[1]]
#       if(length(split_one_column) > 1){
#         split_one_column[[i]] = split_one_column[1]
#       }else{
#         # split_one_column[[i]] = split_one_column
#       }
#     }
#     return(split_one_column)
#   }
#   # split_one_column = strsplit(as.character(x), "%")[[1]]
#   
# })
# View(data.frame(split_data))
# 
# # split_one_column = strsplit(as.character(split_data["Average fight time"]), ":")
# #   
# # if(length(split_one_column) > 1){
# #   minute = split_one_column[1]
# #   second = split_one_column[2]
# #   second = as.numeric(second)/60
# # }else{
# #   minute = split_one_column[1]
# #   second = 0
# # }
# # minute = as.numeric(minute) + second
# 
# View(data.frame(minute))
# split_data["Average fight time"] <- minute
# View(data.frame(split_data))
# new_data = (data.frame(split_data))
# # new_data.insert(loc=0, column = "Name", value = data$Name)
# new_data <- cbind(data$Name, new_data)
# View(new_data)
