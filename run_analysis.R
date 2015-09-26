  ##### 1.Read feature and activity list then get mean and std index.
  library("reshape2")
  dir_name <- "UCI HAR Dataset"
  # read feature file
  feature_list <- read.table(file.path(dir_name, "features.txt"), col.names = c("id", "feature"))
  # get mean and std index 
  mean_std_idx <- grepl("std|mean", feature_list[, "feature"])
  # read activity file
  activity_list <- read.table(file.path(dir_name, "activity_labels.txt"), col.names = c("id", "activity"))
  
  ##### 2.Read train and test dataset then filter by mean and std index. After, map activity number to label.
  # read data set and filter by index
  train.x <- read.table(file.path(dir_name, "train", "X_train.txt"), col.names = feature_list[, "feature"])[, mean_std_idx]
  # read activity number
  train.y <- read.table(file.path(dir_name, "train", "Y_train.txt"), col.names = "activity")
  # map activity number to label 
  train.y$activity <- factor(train.y$activity, activity_list[, "id"], labels = activity_list[, "activity"])
  # read data subject
  train.s <- read.table(file.path(dir_name, "train", "subject_train.txt"), col.names = "subject")
  # read data set and filter by index
  test.x <- read.table(file.path(dir_name, "test", "X_test.txt"), col.names = feature_list[, "feature"])[, mean_std_idx]
  test.y <- read.table(file.path(dir_name, "test", "Y_test.txt"), col.names = "activity")
  # map activity number to label 
  test.y$activity <- factor(test.y$activity, activity_list[, "id"], labels = activity_list[, "activity"])
  # read data subject
  test.s <- read.table(file.path(dir_name, "test", "subject_test.txt"), col.names = "subject")
  
  ##### 3.Merge data then melt and dcast by group and calculate mean. After, write to the file.
  merge_data <- cbind(rbind(train.x, test.x), rbind(train.y, test.y), rbind(train.s, test.s))
  melt_data <- melt(merge_data, id.vars = c(c("activity", "subject")))
  tidy_data <- dcast(melt_data, activity + subject ~ variable, mean)
  str(tidy_data)
  write.table(tidy_data, file = "tidy_data.txt", col.names = FALSE, quote = FALSE)