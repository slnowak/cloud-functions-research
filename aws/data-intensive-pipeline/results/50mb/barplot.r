library("ggplot2")
library("scales")

png(filename="aws-data-intensive-barplot.png", width=640, height=480)

dat = read.csv("barplot.csv")
dat$time = as.POSIXct(dat$time, format = "%Y-%m-%dT%H:%M:%OSZ")

ggplot(dat, aes(time, duration)) +
geom_bar(stat="identity", aes(fill=name)) +
theme(plot.margin = unit(c(1,1,1,1), "cm")) + theme_bw() +
labs(x = "Czas (hh:mm)", y = "Czas wykonania (ms)", fill = "Etap obliczeń")

