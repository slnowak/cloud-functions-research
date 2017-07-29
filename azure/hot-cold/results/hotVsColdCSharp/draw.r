library("ggplot2")
library("scales")

png(filename="graph.png", width=1280, height=1024)

dat = read.csv("data.csv")
dat$timestamp = as.POSIXct(dat$timestamp, format = "%Y-%m-%dT%H:%M:%S")

ggplot(data=dat, aes(timestamp)) +
geom_line(aes(y = duration)) +
theme_bw() +
scale_x_datetime(labels = date_format("%H:%M"), breaks = pretty_breaks(n=10)) +
scale_y_continuous(breaks=pretty_breaks(n=10)) +
labs(x = "Czas wykonania zapytania HTTP (hh:mm:ss)", y = "Czas odpowiedzi (ms)") + 
ggtitle("Czas wykonania funkcji cold/hot w języku C# (10RPS)")


