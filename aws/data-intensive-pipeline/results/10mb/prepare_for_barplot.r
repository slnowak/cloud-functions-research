library(dplyr)

step1 = read.csv("data_intensive_step1_aws.csv")
step2 = read.csv("data_intensive_step2_aws.csv")
overall = read.csv("data_intensive_aws.csv")

inertia = setNames(data.frame(matrix(ncol = 3, nrow = 0)), c("name", "time", "duration"))

for (i in 1:nrow(step1)){
    name = "Czas oczekiwania"
    time = step1[i, c("time")]
    duration = abs(overall[i, c("duration")] - step1[i, c("duration")] - step2[i, c("duration")])
    row <- data.frame(name = name, time = time, duration = duration)
    inertia <- bind_rows(inertia, row)
}

step1$name = "Krok 1"
step2$name = "Krok 2"

data_combined = rbind(rbind(step1, step2), inertia)

write.csv(data_combined[, c("name","time","duration")], file = "barplot.csv", row.names=FALSE)