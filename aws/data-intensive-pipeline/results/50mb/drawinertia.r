library("ggplot2")
library("scales")

png(filename="innertia.png", width=640, height=480)

dat = read.csv("combined.csv")
dat$time = as.POSIXct(dat$time_step1, format = "%Y-%m-%dT%H:%M:%OSZ")
dat$inertia =  abs((dat$duration_overall - dat$duration_step1 - dat$duration_step2))

ggplot(data=dat, aes(time)) +
theme_bw() +
scale_x_datetime(labels = date_format("%H:%M"), breaks = pretty_breaks(n=10)) +
scale_y_continuous(breaks=pretty_breaks(n=10)) +
labs(x = "Czas (hh:mm)", y = "Czas wykonania (ms)", color = "Legenda") +
geom_line(aes(y = inertia, color = "Czas oczekiwania"))