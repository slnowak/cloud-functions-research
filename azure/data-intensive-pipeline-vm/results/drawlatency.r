library("ggplot2")
library("scales")

png(filename="latency.png", width=1280, height=1024)

dat = read.csv("dataintensivevm.csv")
dat$time = as.POSIXct(dat$time, format = "%Y-%m-%dT%H:%M:%SZ")

ggplot(data=dat, aes(time)) +
theme_bw() +
scale_x_datetime(labels = date_format("%H:%M"), breaks = pretty_breaks(n=10)) +
scale_y_continuous(breaks=pretty_breaks(n=10)) +
labs(x = "Time", y = "Latency [ms]", colour = "Percentiles") +
geom_line(aes(y = p50, color = "p50"))


