#! /bin/bash

echo "
--------------------------

User Name: 정재홍

Student Number: 12191673

[ MENU ]

1. Get the data of the movie identified by a specific 'movie id' from 'u.item'

2. Get the data of action genre movies from 'u.item’

3. Get the average 'rating’ of the movie identified by specific 'movie id' from 'u.data’

4. Delete the ‘IMDb URL’ from ‘u.item

5. Get the data about users from 'u.user’

6. Modify the format of 'release date' in 'u.item’

7. Get the data of movies rated by a specific 'user id' from 'u.data'

8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'

9. Exit

--------------------------
"

item=$1
data=$2
user=$3

while :
do
	read -p "Enter your choice [ 1-9 ] " choice
	echo

	case $choice in 
		1)
			read -p "Please enter 'movie id' (1~1682) : " movie_id
			echo
			cat $item | awk -F\| -v mid=$movie_id '$1==mid {print $0}'
			echo
			
			;;
		2)

			;;
		3)

			;;
		4)

			;;
		5)

			;;
		6)

			;;
		7)

			;;
		8)

			;;
		9)
			echo "Bye!"
			exit 0
			;;
	esac
done
			
