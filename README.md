---
title: "Getting And Cleaning Data Project"
author: LiangYu Pan
date: September 23, 2015
output: html_document
---
# Getting_and_Cleaning_Data_Project
```{r global_options, include = FALSE}
  library("knitr")
  library("reshape2")
  opts_chunk$set(echo = TRUE)
```
1. Read feature and activity list then get mean and std index.
```{r}
  dir_name <- "UCI HAR Dataset"
  # read feature file
  feature_list <- read.table(file.path(dir_name, "features.txt"), col.names = c("id", "feature"))
  # head(feature_list)
  # get mean and std index 
  mean_std_idx <- grepl("std|mean", feature_list[, "feature"])
  # head(mean_std_idx)
  # read activity file
  activity_list <- read.table(file.path(dir_name, "activity_labels.txt"), col.names = c("id", "activity"))
  # head(activity_list)
```
2.Read train and test dataset then filter by mean and std index. After, map activity number to label.
```{r}
  # read data set and filter by index
  train.x <- read.table(file.path(dir_name, "train", "X_train.txt"), col.names = feature_list[, "feature"])[, mean_std_idx]
  # head(train.x)
  # read activity number
  train.y <- read.table(file.path(dir_name, "train", "Y_train.txt"), col.names = "activity")
  # head(train.y)
  # map activity number to label 
  train.y$activity <- factor(train.y$activity, activity_list[, "id"], labels = activity_list[, "activity"])
  # head(train.y$activity)
  # read data subject
  train.s <- read.table(file.path(dir_name, "train", "subject_train.txt"), col.names = "subject")
  # head(train.s)
  # read data set and filter by index
  test.x <- read.table(file.path(dir_name, "test", "X_test.txt"), col.names = feature_list[, "feature"])[, mean_std_idx]
  # head(test.x)
  test.y <- read.table(file.path(dir_name, "test", "Y_test.txt"), col.names = "activity")
  # head(test.y)
  # map activity number to label 
  test.y$activity <- factor(test.y$activity, activity_list[, "id"], labels = activity_list[, "activity"])
  # head(test.y$activity)
  # read data subject
  test.s <- read.table(file.path(dir_name, "test", "subject_test.txt"), col.names = "subject")
  # head(test.s)
``` 
3.Merge data then melt and dcast by group and calculate mean. After, write to the file.
```{r}
  merge_data <- cbind(rbind(train.x, test.x), rbind(train.y, test.y), rbind(train.s, test.s))
  # str(merge_data)
  melt_data <- melt(merge_data, id.vars = c(c("activity", "subject")))
  tidy_data <- dcast(melt_data, activity + subject ~ variable, mean)
  # head(tidy_data)
  str(tidy_data)
  write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE, quote = FALSE)
```
