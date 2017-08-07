library("ggplot2")
library("scales")

png(filename="hosts.png", width=640, height=480)

dat = read.csv("hosts_aws.csv")
dat$time = as.POSIXct(dat$time, format = "%Y-%m-%dT%H:%M:%SZ")

ggplot(data=dat, aes(x=time, y=count, group=1)) +
geom_line(colour="blue", size=0.5) +
   scale_x_datetime(labels = date_format("%H:%M"), breaks = pretty_breaks(n=10)) +
   scale_y_continuous(breaks=pretty_breaks(n=10)) +
   theme(plot.margin = unit(c(1,1,1,1), "cm")) +
   labs(x="Data") +
   labs(y="Number of instances") +
   geom_area(aes(y=count))




