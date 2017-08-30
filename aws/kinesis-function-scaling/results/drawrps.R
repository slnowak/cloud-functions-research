library("ggplot2")
library("scales")

png(filename="aws-kinesis-rps.png", width=800, height=600)

dat = read.csv("rps.csv")
dat$time = as.POSIXct(dat$time, format = "%Y-%m-%dT%H:%M:%OSZ")

ggplot(dat, aes(time, rps)) +
geom_bar(stat="identity") +
theme(plot.margin = unit(c(1,1,1,1), "cm")) + theme_bw(base_size=18) +
labs(x = "Czas wykonania testu (hh:mm)", y = "Ilość zapytań na sekunde (RPS)")
