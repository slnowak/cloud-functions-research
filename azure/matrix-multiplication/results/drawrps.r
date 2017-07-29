library("ggplot2")
library("scales")

png(filename="rpstest.png", width=1280, height=1024)

dat = read.csv("rps.csv")
dat$time = as.POSIXct(dat$time, format = "%Y-%m-%dT%H:%M:%SZ")

ggplot(data=dat, aes(time)) +
geom_line(aes(y = rps)) +
theme_bw() +
scale_x_datetime(labels = date_format("%H:%M"), breaks = pretty_breaks(n=10)) +
scale_y_continuous(breaks=pretty_breaks(n=10)) +
labs(x = "Time", y = "RPS")


