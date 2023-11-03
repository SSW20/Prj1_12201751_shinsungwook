#!/bin/bash
echo "------------------------------"
echo "User Name: ShinSungWook"
echo "Student Number: 12201751"
echo "
[ MENU ]
1. Get the data of the movie identified by a specific 'movie id' from 'u.item'
2. Get the data of action genre movies from 'u.item'
3. Get the average 'rating' of the movie identified by specific 'movie id' from 'u.data'
4. Delete the 'IMDb URL' from 'u.item'
5. Get the data about users from 'u.user'
6. Modifythe format of 'release date' in 'u.item'
7. Get the data of movies rated by a specific 'user.id' from 'u.data'
8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'
9. Exit"
echo "------------------------------"
while true; do
	read -p "Enter your choice [ 1-9 ] " choice
	case $choice in
		1)
		 echo
	  	 read -p "Please enter 'movie id'(1~1682):" choice_1
			echo
			cat u.item | awk -F \| '$1 == '$choice_1' {print $0}';;
		2)
		 echo
		 read -p "Do you want to get the data of 'action' genre movies from 'u.item'? (y/n):" choice_2
			echo
			if [ "$choice_2" == "y" ]; then
				cat u.item | awk -F \| '$7 == 1' | sort -n | head -n 10 | awk -F '|' '{print $1, $2}'
			elif [ "$choice_2" == "n" ]; then
				continue
			else
                echo "Invalid input!!"
			fi;;
		3)
		 echo
	 	 read -p "Please enter 'movie id'(1~1682):" choice_3
			echo
			cat u.data | awk '$2 == '$choice_3' {count++; rating+=$3} END {printf "average rating of '$choice_3': %.5f\n" ,rating/count}';;
		4)
		 echo
		 read -p "Do you want to delete the 'IMDb URL' from 'u.item'? (y/n):" choice_4
			echo
 			if [ "$choice_4" == "y" ]; then
				cat u.item | sed 's/http:\/\/[^|]*|/|/' | sort -n | head -n 10
			elif [ "$choice_4" == "n" ]; then
				continue
			else
                echo "Invalid input!!"
			fi;;
		5)
		 echo
	 	 read -p "Do you want to get the data about users from 'u.user'? (y/n):" choice_5
		 	echo
			if [ "$choice_5" == "y" ]; then
				sed -n '1,10p' u.user | sed 's/^/user /; s/|/ is /; s/|/ years old /; s/M/male /; s/F/female /; s/|/ /; s/|.*//;'
			elif [ "$choice_5" == "n" ]; then
				continue
			else
                echo "Invalid input!!"	
			fi;;
		6)
		 echo
	 	 read -p "Do you want to Modify the format of 'release data' in 'u.item'? (y/n):" choice_6
		 	echo
		 	if [ "$choice_6" == "y" ]; then
				sed -n '1673,1682p' u.item | sed -E 's/([0-9]{2})-([A-za-z]{3})-([0-9]{4})/\3\2\1/;' | sed 's/Jan/01/; s/Feb/02/; s/Mar/03/; s/Apr/04/; s/May/05/; s/Jun/06/; s/Jul/07/; s/Aug/08/; s/Sep/09/; s/Oct/10/; s/Nov/11/; s/Dec/12/;'
			elif [ "$choice_6" == "n" ]; then
				continue
			else
                echo "Invalid input!!"
			fi;;
		7)
		 echo
	 	 read -p "Please enter the 'user id'(1~943) :" choice_7
			echo
			cat u.data | awk '$1 == '$choice_7'' | sort -k2 -n | awk '{printf "%s|", $2}'
			echo
			echo
			temp_id=$(awk '$1 == '$choice_7'' u.data | sort -k2 -n | head -n 10 | awk '{print $2}')
			for id in $temp_id
			do
			  awk -F '|' '$1 == '$id' {print $1"|"$2}' u.item
			done;;
		8)
		 echo
	 	 read -p "Do you want to get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'? (y/n):" choice_8
			echo
			if [ "$choice_8" == "y" ]; then
				program_20=$(awk -F '|' '$2 >= 20 && $2 <= 29 && $4 == "programmer" {print $1}' u.user)
			elif [ "$choice_8" == "n" ]; then
				continue
			else
                echo "Invalid input!!"
			fi;;
		9)
		 echo "Bye!"
		 exit 0;;
		*)
		 echo
		 echo "Invalid input!!";;
	esac
	echo
done

else
