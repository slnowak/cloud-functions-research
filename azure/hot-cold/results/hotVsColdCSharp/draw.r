library("ggplot2")
library("scales")

png(filename="azure-warmup-csharp.png", width=800, height=600)

dat = read.csv("data.csv")
dat$timestamp = as.POSIXct(dat$timestamp, format = "%Y-%m-%dT%H:%M:%S")

ggplot(data=dat, aes(timestamp)) +
geom_line(aes(y = duration)) +
theme_bw() +
scale_x_datetime(labels = date_format("%H:%M"), breaks = pretty_breaks(n=10)) +
scale_y_continuous(breaks=pretty_breaks(n=10)) +
labs(x = "Czas wykonania zapytania HTTP (hh:mm:ss)", y = "Czas odpowiedzi (ms)")

