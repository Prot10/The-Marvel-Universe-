#!/bin/sh

# Question 1: What is the most popular pair of heroes (often appearing together in the comics)?
echo "Most popular pair of heroes:"
csvcut -c "hero1","hero2" hero-network.csv | awk -F, '$1 != $2' | sort | uniq -c | sort -nr | head -n 10

# Question 2: Number of comics per hero.
echo "Number of comics per hero:"
csvcut -c "hero" edges.csv | sort | uniq -c | sort -nr | head -n 5

# Question 3: The average number of heroes in comics.
echo "Average number of heroes in comics:"
csvcut -c "hero","comic" edges.csv | awk -F, '{comic[$2]++} END {for (com in comic) \
 {sum+=comic[com]}} END {print sum/length(comic)}'

