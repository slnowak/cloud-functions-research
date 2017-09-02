set term pngcairo size 800,600
set output 'azure-coldagain-csharp.png'
set datafile separator ";"
set xdata time
set boxwidth 0.75
set style fill solid
set timefmt "%Y-%m-%dT%H:%M:%S"
set format x "%H:%M"
set xlabel "Czas wykonania zapytania HTTP (hh:mm)"
set ylabel "Czas odpowiedzi (ms)"
set style line 1 linecolor rgb "black"
plot "data.csv" using 1:3 with boxes ls 1 title 'Czas odpowiedzi (ms)'  
