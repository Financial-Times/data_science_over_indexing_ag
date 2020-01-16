#!/usr/bin/env Rscript

# Load libraries
library(rjson)

args <- commandArgs(trailingOnly = TRUE)

# Import Json File
json_data <- fromJSON(file=args[1])

# Import All files from All input folders
for (i in 1:length(json_data$input$operators))
{

  filenames = list.files(path=json_data$input$operators[[i]]$local_path, pattern="*.csv",full.names=TRUE)
  all_files = do.call("rbind", lapply(filenames, read.csv, header = TRUE, sep=";"))
  assign(json_data$input$operators[[i]]$name,all_files)
}

# Clean up workspace from temp objects
rm(filenames,i,all_files)

#Final output save output as per the json
write.csv(operator_name_1, file = paste(json_data$output[1]$local_path, '/output.csv',sep = ''))
