library("ggplot2")
library("scales")

png(filename="data-intensive-vm-50mb.png", width=800, height=600)

dat = read.csv("dataintensivevm_50mb.csv")
dat$time = as.POSIXct(dat$time, format = "%Y-%m-%dT%H:%M:%SZ")

ggplot(data=dat, aes(time, p95)) +
geom_bar(stat = "identity") +
theme_bw(base_size=18) + theme(plot.margin = unit(c(1,1,1,1), "cm")) +
scale_x_datetime(labels = date_format("%H:%M"), breaks = pretty_breaks(n=10)) +
scale_y_continuous(breaks=pretty_breaks(n=10)) +
labs(x = "Czas rozpoczęcia wykonywania pipeline'u (hh:mm)", y = "p95 czasu odpowiedzi (ms)")

