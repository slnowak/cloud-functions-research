library("ggplot2")
library("scales")

png(filename="azure-dataintensive-latency.png", width=640, height=480)

dat = read.csv("combined.csv")
dat$time_2 = as.POSIXct(dat$time_2, format = "%Y-%m-%dT%H:%M:%SZ")

ggplot(data=dat, aes(time_2)) +
theme_bw() +
scale_x_datetime(labels = date_format("%H:%M"), breaks = pretty_breaks(n=10)) +
scale_y_continuous(breaks=pretty_breaks(n=10)) +
labs(x = "Czas [hh:mm]", y = "Czas wykonania [ms]", colour = "Data intensive") +
geom_line(aes(y = p50_1, color = "Azure Functions")) +
geom_line(aes(y = p50_2, color = "Maszyna wirtualna"))


