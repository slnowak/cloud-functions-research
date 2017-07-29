set term pngcairo size 1024,768
set output 'graph.png'
set style data linespoints
set datafile separator ","
set xdata time
set timefmt "%Y-%m-%dT%H:%M:%S"
set title "Czas wykonania funkcji po sesji warmup w języku C# (10RPS)"
set xlabel "Czas wykonania zapytania HTTP (hh:mm:ss)"
set ylabel "Czas odpowiedzi (ms)"
plot "data.csv" using 1:2 with lines title 'Czas odpowiedzi (ms)'  
