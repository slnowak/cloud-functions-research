library("ggplot2")
library("scales")

png(filename="percentiles.png", width=640, height=480)

dat = read.csv("percentiles.csv")
dat$time = as.POSIXct(dat$time, format = "%Y-%m-%dT%H:%M:%S")

ggplot(data=dat, aes(time)) +
theme_bw() +
scale_x_datetime(labels = date_format("%H:%M"), breaks = pretty_breaks(n=10)) +
scale_y_continuous(breaks=pretty_breaks(n=10)) +
labs(x = "Czas (hh:mm)", y = "Czas wykonania (ms)", color = "Percentyle") +
geom_line(aes(y = p50, color = "p50")) +
geom_line(aes(y = p75, color = "p75")) +
geom_line(aes(y = p95, color = "p95")) +
geom_line(aes(y = p99, color = "p99")) +
ggtitle("p50, p75, p95, p99 czasu wykonania funkcji")


