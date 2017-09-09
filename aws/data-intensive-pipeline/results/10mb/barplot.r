library("ggplot2")
library("scales")

png(filename="aws-data-intensive-10mb-barplot.png", width=800, height=600)

dat = read.csv("barplot.csv")
dat$time = as.POSIXct(dat$time, format = "%Y-%m-%dT%H:%M:%OSZ")
dat$name= factor(dat$name,levels=c("Krok 2", "Czas oczekiwania", "Krok 1"))

ggplot(dat, aes(time, duration)) +
geom_bar(stat="identity", aes(fill=name)) +
theme(plot.margin = unit(c(1,1,1,1), "cm")) + theme_bw(base_size=18) +
scale_y_continuous(breaks=pretty_breaks(n=10)) +
labs(x = "Czas (hh:mm)", y = "Czas wykonania (ms)") +
scale_fill_manual("Etap obliczeń", values = c("Krok 1" = "#00CC00", "Krok 2" = "#0080FF", "Czas oczekiwania" = "#FF3333"))


