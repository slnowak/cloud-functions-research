library("ggplot2")
library("scales")

png(filename="test.png", width=1280, height=1024)

dat = read.csv("hosts.csv")
dat$time = as.POSIXct(dat$time, format = "%Y-%m-%dT%H:%M:%SZ")

ggplot(data=dat, aes(x=time, y=count, group=1)) +
geom_line(colour="blue", size=0.5) +
   scale_x_datetime(labels = date_format("%Y-%m-%dT%H:%M"), breaks = pretty_breaks(n=10)) +
   scale_y_continuous(breaks=pretty_breaks(n=10)) +
   theme(plot.margin = unit(c(1,1,1,1), "cm")) +
   labs(x="Data") +
   labs(y="Liczba instancji funkcji") +
   geom_area(aes(y=count))



