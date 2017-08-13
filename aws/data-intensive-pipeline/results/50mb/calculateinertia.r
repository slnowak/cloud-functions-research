library("ggplot2")
library("scales")

dat = read.csv("combined.csv")
dat$duration =  abs((dat$duration_overall - dat$duration_step1 - dat$duration_step2))
dat$type =  "data_intensive_inertia"
dat$time =  dat$time_step1

write.csv(dat[, c("type","time","duration")], file = "inertia.csv", row.names=FALSE)