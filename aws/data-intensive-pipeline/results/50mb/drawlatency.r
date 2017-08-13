library("ggplot2")
library("scales")

png(filename="summary.png", width=640, height=480)

dat = read.csv("combined.csv")
dat$time = as.POSIXct(dat$time_step1, format = "%Y-%m-%dT%H:%M:%OSZ")

ggplot(data=dat, aes(time)) +
theme_bw() +
scale_x_datetime(labels = date_format("%H:%M"), breaks = pretty_breaks(n=10)) +
scale_y_continuous(breaks=pretty_breaks(n=10)) +
labs(x = "Czas (hh:mm)", y = "Czas wykonania (ms)", color = "Legenda") +
geom_line(aes(y = duration_step1, color = "Czas wykonania 1 kroku")) +
geom_line(aes(y = duration_step2, color = "Czas wykonania 2 kroku")) +
geom_line(aes(y = duration_overall, color = "Całkowity czas wykonania"))