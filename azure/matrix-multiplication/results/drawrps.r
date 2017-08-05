library("ggplot2")
library("scales")

png(filename="rps.png", width=640, height=480)

dat = read.csv("rps.csv")
dat$time = as.POSIXct(dat$time, format = "%Y-%m-%dT%H:%M:%SZ")

ggplot(data=dat, aes(time)) +
geom_line(aes(y = rps)) +
theme_bw() +
scale_x_datetime(labels = date_format("%H:%M"), breaks = pretty_breaks(n=10)) +
scale_y_continuous(breaks=pretty_breaks(n=10)) +
labs(x = "Czas (hh:mm)", y = "RPS") +
ggtitle("Liczba zapytań na sekundę")


