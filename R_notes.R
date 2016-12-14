# most of these notes are pretty simplistic, but I'm just adding what I've already got for now.

Intensities <- read.table("C:/ch2.data", header=TRUE)

pdf("boxplot4.pdf")
boxplot(Intensities[,1] ~Intensities[,3], 
	ylab="max GFP intensity", xlab="well#", 
	main="Total Cellular Intensity of Arsenite Stressed Cells")
dev.off()

# you can specify w and h (7 is default) for plot but points and labels do not scale, it is easier to scale vectors in illustrator

# All components in a data frame can be extracted as vectors with corresponding names:
attach(measrs)
wt # [1] 91 99 74
detach(measr

save(top. 5. salaries, file="~/top. 5. salaries. RData")

# how to recast a vector
class(dow30$Date)
# [ 1] "factor"
dow30$Date <- as. Date(dow30$Date)
class(dow30$Date)
# [ 1] "Date"

# to make a new data.frame from vectors
intensities.new <- data.frame(list$column1, list$column2)

# join data frames together, requires similar named columns
colnames(data) <- c("distance", "intensity")
rbind(table1,table2)

# how to add a new column to a data frame
# all with the same number
data$well <- 9

data.frame "results$factories" has some wierd data where the value is -1 instead of 0, update it by using this sequence
attach(results)
wrong <- which(factories == -1)  # get a vector of all the offending values
wrong                            # print this list to make sure you're good
	[1] 3 15 19 25 26 33 40 42
results$factories[wrong] <- 0    //make the changes, cannot use shorthand notation "factories[wrong] <- 0" as this will only change the pointers and not the actual "results" table data

** this is essentially saying
results$factories[3] <-0
results$factories[15] <-0
results$factories[19] <- 0
...etc

# show me just the mean and max for the forst cell's granules
onecell <- subset(granules_defined, as.integer(cell) == 1, select=c(cell,granule,mean,max))