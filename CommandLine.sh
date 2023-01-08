#!/bin/sh

#####################################################################################################
### Question 1: What is the most popular pair of heroes (often appearing together in the comics)? ###
#####################################################################################################
echo "Most popular pair of heroes:"
# sort all the pairs in alphabetical order and save them in a new csv which has the new separator '-'
# also remove '"'
cut -f 1,2 hero-network.csv | awk -F '","' '{if ($1 > $2) {print $2 "-" $1} \
  else {print $1 "-" $2}}' | tr -d '"' > intermediate.csv
# removes any rows where the first and second fields are equal, counts how many rows are equal,
# finally sort the rows in reverse order and display the first 10
cut -f 1,2 intermediate.csv | awk -F "-" '$1 != $2' | sort | uniq -c | sort -nr | head -n 10

##############################################
### Question 2: Number of comics per hero. ###
##############################################
echo "Number of comics per hero:"
# select the 'hero' column from the file, sort alphabetically,
# count of the number of times a row occurred, sort those, display the first 5
csvcut -c "hero" edges.csv | sort | uniq -c | sort -nr | head -n 5

###########################################################
### Question 3: The average number of heroes in comics. ###
###########################################################
echo "Average number of heroes in comics:"
# select the 'hero' and 'comic' columns, count the number of times each value
# in the 'comic' column occurs, divides this sum by the total length
csvcut -c "hero","comic" edges.csv | awk -F, '{comic[$2]++} END {for (com in comic) \
 {sum+=comic[com]}} END {print sum/length(comic)}'

