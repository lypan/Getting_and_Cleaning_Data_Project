library("reshape2")
dir_name <- "UCI HAR Dataset"
feature_list <- read.table(file.path(dir_name, "features.txt"), col.names = c("id", "feature"))
mean_std_idx <- grepl("std|mean", feature_list[, "feature"])
activity_list <- read.table(file.path(dir_name, "activity_labels.txt"), col.names = c("id", "activity"))
train.x <- read.table(file.path(dir_name, "train", "X_train.txt"), col.names = feature_list[, "feature"])[, mean_std_idx]
train.y <- read.table(file.path(dir_name, "train", "Y_train.txt"), col.names = "activity")
train.y$activity <- factor(train.y$activity, activity_list[, "id"], labels = activity_list[, "activity"])
train.s <- read.table(file.path(dir_name, "train", "subject_train.txt"), col.names = "subject")
test.x <- read.table(file.path(dir_name, "test", "X_test.txt"), col.names = feature_list[, "feature"])[, mean_std_idx]
test.y <- read.table(file.path(dir_name, "test", "Y_test.txt"), col.names = "activity")
test.y$activity <- factor(test.y$activity, activity_list[, "id"], labels = activity_list[, "activity"])
test.s <- read.table(file.path(dir_name, "test", "subject_test.txt"), col.names = "subject")
merge_data <- cbind(rbind(train.x, test.x), rbind(train.y, test.y), rbind(train.s, test.s))
melt_data <- melt(merge_data, id.vars = c(c("activity", "subject")))
tidy_data <- dcast(melt_data, activity + subject ~ variable, mean)
str(tidy_data)
write.table(tidy_data, file = "tidy_data.txt", col.names = FALSE, quote = FALSE)
