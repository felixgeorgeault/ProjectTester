# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    main.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgeorgea <fgeorgea@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/03/29 18:36:34 by fgeorgea          #+#    #+#              #
#    Updated: 2023/03/29 20:43:08 by fgeorgea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash


files=$(find . \( -name "a.out" -o -name "push_swap" -o -name "fdf" -o -name "pipex" -o -name "so_long" -o -name "minitalk" -o -name "fractol" -o -name "minishell" \) | wc -l);

if [ $files -gt 0 ];
then
	echo "KO -> found file that was not suppose to be here !";
	exit 0;
fi;

norm1=$(norminette | grep ": Error\!" | wc -l);

norm2=$(norminette -R CheckDefine | grep ": Error\!" | wc -l);

norm_check=$(( $norm1 + $norm2 ))

if [ $norm_check -gt 0 ]
then
	echo "KO -> NORM ERROR !";
	exit 0;
fi;

grep -r "Created:" . >> header_check.txt;
clear;
grep -r "Updated:" . >> header_check.txt;
clear;

file="header_check.txt";
clear;
while read -r Line; do
	if [[ "$Line" == *"$USER"* ]];
	then
		:
	else
		if [[ "$Line" == *"grep"* ]];
		then
			:
		else
			echo "KO -> HEADER NAME IS WRONG !";
			exit 0;
		fi;
	fi;
done < $file

rm -rf header_check.txt
