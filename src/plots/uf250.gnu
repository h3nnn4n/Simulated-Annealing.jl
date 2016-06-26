#!/usr/bin/gnuplot
#
# Colored tics with epslatex
#
# AUTHOR: Hagen Wierstorf

reset

set terminal png size 410,250 font 'Verdana,9'
set output 'out250.png'

# define axis
# remove border on top and right and set color to gray
set style line 11 lc rgb '#808080' lt 1
set border 3 back ls 11
set tics nomirror
# define grid
set style line 12 lc rgb'#808080' lt 0 lw 1
set grid back ls 12

# color definitions
set style line 1 lc rgb '#8b1a0e' pt 1 ps 1.5 lt 1 lw 2 # --- red
set style line 2 lc rgb '#5e9c36' pt 6 ps 1.5 lt 1 lw 2 # --- green

set key top right

set xtics rotate by 20 offset -0.8,-1.4

#set format '\color{tics}$%g$'
set xlabel 'Iterations'
set ylabel 'Objective function'
#set xrange [0:1]
#set yrange [0:1]

plot 'out_uf250-01_hcos.dat' using 1:2 title 'Mean of 10x uf250-01' with lines ls 1
