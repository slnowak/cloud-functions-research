library("ggplot2")
library("scales")

png(filename="hosts.png", width=640, height=480)

dat = read.csv("hosts.csv", sep=';')
dat$Time = as.POSIXct(dat$Time, format = "%Y-%m-%dT%H:%M:%S")

ggplot(data=dat, aes(x=Time, y=Value, group=1)) +
geom_line(colour="black", size=0.5) +
   scale_x_datetime(labels = date_format("%Y-%m-%dT%H:%M"), breaks = pretty_breaks(n=10)) +
   scale_y_continuous(breaks=pretty_breaks(n=10)) +
   theme(plot.margin = unit(c(1,1,1,1), "cm")) +
   labs(x="Czas (hh:mm)") +
   labs(y="Liczba instancji funkcji") +
   geom_area(aes(y=Value)) +
ggtitle("Ilość instancji funkcji w jednostce czasu")




