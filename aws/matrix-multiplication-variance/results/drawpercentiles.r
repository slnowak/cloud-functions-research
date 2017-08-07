library("ggplot2")
library("scales")

png(filename="aws-variance-percentiles.png", width=800, height=600)

dat = read.csv("percentiles_variance_aws.csv")
dat$time = as.POSIXct(dat$time, format = "%Y-%m-%dT%H:%M:%SZ")

ggplot(data=dat, aes(time)) +
theme_bw() +
scale_x_datetime(labels = date_format("%H:%M"), breaks = pretty_breaks(n=24)) +
scale_y_continuous(breaks=pretty_breaks(n=10)) +
labs(x = "Czas (hh:mm)", y = "Czas wykonania (ms)", color = "Percentyle") +
geom_line(aes(y = p50, color = "p50")) +
geom_line(aes(y = p99, color = "p99"))

