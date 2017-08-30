library("ggplot2")
library("scales")

png(filename="azure-http-hosts.png", width=800, height=600)

dat = read.csv("hosts.csv")
dat$time = as.POSIXct(dat$time, format = "%Y-%m-%dT%H:%M:%SZ")

ggplot(data=dat, aes(x=time, y=count, group=1)) +
theme_bw(base_size=18) + theme(plot.margin = unit(c(1,1,1,1), "cm")) +
geom_line(colour="blue", size=0.5) +
   scale_x_datetime(labels = date_format("%H:%M"), breaks = pretty_breaks(n=10)) +
   scale_y_continuous(breaks=pretty_breaks(n=10)) +
   labs(x="Czas (hh:mm)") +
   labs(y="Liczba maszyn wirtualnych") +
   geom_area(aes(y=count))


