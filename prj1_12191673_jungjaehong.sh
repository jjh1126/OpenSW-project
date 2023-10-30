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
			# awk를 사용하여 u.item 파일에서 해당하는 열 읽어오기
			read -p "Please enter 'movie id' (1~1682) : " movie_id
			echo
			cat $item | awk -F\| -v mid=$movie_id '$1==mid {print $0}'
			echo
			
			;;
		2)
			# awk를 사용하여 u.item 파일에서 해당하는 열 읽어오기
			read -p "Do you want to get the data of ‘action’ genre movies from 'u.item’?(y/n): " answer
			echo
			
			if [ "$answer" == "y" ]
			then
				cat $item | awk -F\| '$7==1 {print $1, $2}' | head -n 10
				echo
			fi

			;;
		3)
			# movie id에 해당하는 평점 정보를 u.data에서 읽어와서 for문의 리스트로 넘겨주기
			read -p "Please enter 'movie id' (1~1682) : " movie_id
                        echo

			sum=0
			cnt=0

			for i in $(cat $data | awk -v mid=$movie_id '$2==mid {print $3}')
			do
				sum=$((sum+i))
				cnt=$((cnt+1))
			done
			
			echo $movie_id $sum $cnt | awk '{printf("average rating of %s: %.5f\n",$1,$2/$3)}'
			echo

			;;
		4)
			read -p "Do you want to delete the ‘IMDb URL’ from ‘u.item’?(y/n): " answer
			echo
			
			# http로 시작하여 '|'가 포함되지 않은 문자열을 삭제
			if [ "$answer" == "y" ]
                        then
				cat $item | sed -E 's/http[^|]*//' | head -n 10
                                echo
                        fi


			;;
		5)
			read -p "Do you want to get the data about users from ‘u.user’?(y/n) : " answer
                        echo
			
			# 한 줄씩 읽으면서 성별 문자를 변환하고 양식에 맞게 출력
                        if [ "$answer" == "y" ]
                        then
				cat $user | awk -F\| '{printf("%s %s %s %s\n",$1, $2, $3, $4)}' | \
				sed -E -e 's/M/male/' -e 's/F/female/' -e  's/([0-9]+) ([0-9]+) (.*) (.*)/user \1 is \2 years old \3 \4/' | head -n 10
                                echo
                        fi

			;;
		6)
			read -p "Do you want to Modify the format of ‘release data’ in ‘u.item’?(y/n) : " answer
			echo
			
			# 한 줄씩 읽으면서 month를 먼저 변환하고 형식 바꿔주기
			if [ "$answer" == "y" ]
			then
				cat $item | \
				sed -E -e 's/-Jan-/-01-/' -e 's/-Feb-/-02-/' -e 's/-Mar-/-03-/' -e 's/-Apr-/-04-/' -e 's/-May-/-05-/' -e 's/-Jun-/-06-/' \
			       	-e 's/-Jul-/-07-/' -e 's/-Aug-/-08-/' -e 's/-Sep-/-09-/' -e 's/-Oct-/-10-/' -e 's/-Nov-/-11-/' -e 's/-Dec-/-12-/' \
			       	-e 's/([0-9]+)-([0-9]+)-([0-9]+)/\3\2\1/' | head -n 10  
				echo
			fi

			;;
		7)
			read -p "Please enter the ‘user id’(1~943) : " user_id
			echo
			
			touch tmp.txt

			cat $data | awk -v i=$user_id '$1==i {print $2}' | sort -n > tmp.txt

			cat tmp.txt | tr '\n' '|' | sed -E 's/\|$/\n\n/'
			
			for i in $(cat tmp.txt | head -n 10)
			do
				cat $item | awk -F\| -v k=$i '$1==k {printf("%s|%s\n",$1,$2)}'
			done
			echo

			rm tmp.txt

			;;
		8)

			;;
		9)
			echo "Bye!"
			break

			;;
	esac
done
			
