#File
1. `run_analysis.R`: R script to get tidy dataset from [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
2. `CodeBook.md`: reference for columns in tidy dataset.
3. `run_analysis.html`: generated by `run_analysis.RMD`, you can see the code result with text explanation.
4. `run_analysis.Rmd`: Rmarkdown to generate html by `knitr` package.
5. `features.txt`: Full list of features except `activity` and `subject`. 
6. `ReadMe.md`: instruction for how to use.

#Usage
1. Download the data from [here](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/)
2. Unzip data then put `UCI HAR Dataset` folder, `run_analysis.R` R script and set work directory to the same location.
3. Run the `run_analysis.R` R script.
4. The tidy data's filename is `tidy_data.txt`.(default ouput col names, you can change it by set `col.names = FALSE` in the last line)
