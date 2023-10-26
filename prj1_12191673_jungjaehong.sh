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
			read -p "Do you want to get the data of ‘action’ genre movies from 'u.item’?(y/n): " answer
			echo
			
			if [ "$answer" == "y" ]
			then
				cat $item | awk -F\| '$7==1 {print $1, $2}' | head -n 10
				echo
			fi

			;;
		3)
			read -p "Please enter 'movie id' (1~1682) : " movie_id
                        echo

			sum=0
			cnt=0

			for i in $(cat $data | awk -v mid=$movie_id '$2==mid {print $3}')
			do
				sum=$((sum+i))
				cnt=$((cnt+1))
			done
			
			echo $movie_id $sum $cnt | awk '{printf("average rating of %s: %.5f",$1,$2/$3)}'
			echo
			echo

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
			break

			;;
	esac
done
			
