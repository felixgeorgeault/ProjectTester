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
grep -r "Updated:" . >> header_check.txt;

file="header_check.txt";
clear;
is_header_correct=0;
while read -r Line; do
	if [[ "$Line" == *"$USER"* || "$Line" == *"Marvin42"* ]];
	then
		:
	else
		if [[ "$Line" == *"grep"* ]];
		then
			:
		else
			is_header_correct=1;
			echo "KO -> HEADER NAME MIGHT BE WRONG !";
			echo $Line;
		fi;
	fi;
done < $file

rm -rf header_check.txt

if [ $is_header_correct -gt 0 ];
then
	exit 0;
fi;
needs_francinette=$(find . \( -name "*libft*" -o -name "*get_next_line*" -o -name "*ft_printf*" \) | wc -l);

if [ $needs_francinette -gt 0 ];
then
	
	is_francinette=$(command -v francinette | wc -l);
	if [ $is_francinette == 0 ];
	then
		bash -c "$(curl -fsSL https://raw.github.com/xicodomingues/francinette/master/bin/install.sh)";
	else
		/Users/$USER/francinette/tester.sh;
	fi;
fi;

has_valgrind=$(command -v valgrind | wc -l);

if [ $has_valgrind == 0 ];
then
	brew install --HEAD LouisBrunner/valgrind/valgrind;
fi;

echo "Looks good to me!";

