library("ggplot2")
library("scales")

png(filename="aws-http-rps.png", width=800, height=600)

dat = read.csv("rps_aws.csv")
dat$time = as.POSIXct(dat$time, format = "%Y-%m-%dT%H:%M:%SZ")

ggplot(data=dat, aes(time, rps)) +
geom_bar(stat="identity") +
theme_bw(base_size=18) + theme(plot.margin = unit(c(1,1,1,1), "cm")) +
scale_x_datetime(labels = date_format("%H:%M"), breaks = pretty_breaks(n=10)) +
scale_y_continuous(breaks=pretty_breaks(n=10)) +
labs(x = "Czas [hh: mm]", y = "Liczba zapytań na sekundę")