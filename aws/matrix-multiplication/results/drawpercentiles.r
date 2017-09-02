library("ggplot2")
library("scales")

png(filename="aws-http-percentiles.png", width=800, height=600)

dat = read.csv("percentiles_aws.csv")
dat$time = as.POSIXct(dat$time, format = "%Y-%m-%dT%H:%M:%SZ")

ggplot(data=dat, aes(time)) +
scale_x_datetime(labels = date_format("%H:%M"), breaks = pretty_breaks(n=10)) +
scale_y_continuous(breaks=pretty_breaks(n=10)) +
theme_bw(base_size=18) + theme(plot.margin = unit(c(1,1,1,1), "cm")) +
labs(x = "Czas [hh:mm]", y = "Czas wykonania [ms]", color = "Percentyle") +
geom_line(aes(y = p50, color = "p50")) +
geom_line(aes(y = p99, color = "p99"))


