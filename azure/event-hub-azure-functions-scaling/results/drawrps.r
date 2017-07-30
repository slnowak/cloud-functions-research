library("ggplot2")
library("scales")

png(filename="rps.png", width=640, height=480)

dat = read.csv("rps.csv", sep=";")
dat$Time = as.POSIXct(dat$Time, format = "%Y-%m-%dT%H:%M:%S")

ggplot(data=dat, aes(Time)) +
geom_line(aes(y = Value)) +
theme_bw() +
scale_x_datetime(labels = date_format("%H:%M"), breaks = pretty_breaks(n=10)) +
scale_y_continuous(breaks=pretty_breaks(n=10)) +
labs(x = "Czas (hh:mm)", y = "RPS") +
ggtitle("Ilość zapytań na sekunde")


