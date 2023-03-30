#!/bin/bash


# ------------------------- CHECK REMAINING FILES --------------------------
files=$(find . \( -name "a.out" -o -name "push_swap" -o -name "fdf" -o -name "pipex" -o -name "so_long" -o -name "minitalk" -o -name "fractol" -o -name "minishell" \) | wc -l);

if [ $files -gt 0 ];
then
	echo "KO -> found file that was not suppose to be here !";
	exit 0;
fi;
# ------------------------- END CHECK REMAINING FILES -----------------------------

# -------------------------- CHECK NORMINETTE -----------------------------------
norm1=$(norminette | grep ": Error\!" | wc -l);

norm2=$(norminette -R CheckDefine | grep ": Error\!" | wc -l);

norm_check=$(( $norm1 + $norm2 ))

if [ $norm_check -gt 0 ]
then
	echo "KO -> NORM ERROR !";
	exit 0;
fi;
# ---------------------------- END CHECK NORMINETTE ------------------------------

# ----------------- CHECK HEADER NAMES -------------------------------
find . \( -name "*.c" -o -name "*.h" \) -exec grep "Created:" >> header_check.txt "{}" \;
find . \( -name "*.c" -o -name "*.h" \) -exec grep "Updated:" >> header_check.txt "{}" \;

file="header_check.txt";
clear;
is_header_correct=0;

if [ $# != 0 ];
then
	OLD_USER=$USER;
	USER=$1;
fi;


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
			rm -rf header_check.txt;
			USER=$OLD_USER;
			exit 0;
		fi;
	fi;
done < $file

rm -rf header_check.txt
USER=$OLD_USER;

if [ $is_header_correct -gt 0 ];
then
	exit 0;
fi;
# ----------------- END CHECK HEADER NAMES ------------------------------------


# ----------------------- CHECK FRANCINETTE -------------------------------

	#bash -c "$(curl -fsSL https://raw.github.com/xicodomingues/francinette/master/bin/install.sh)";

# ------------------------------ END CHECK FRANCINETTE ------------------------------


# ----------------------------- CHECK BREW ------------------------------------------

	#rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew && echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc && brew update

# ------------------------------ END CHECK BREW ------------------------------------

# ------------------------------ CHECK VALGRIND -----------------------------------

	#brew install --HEAD LouisBrunner/valgrind/valgrind

# ------------------------------- END CHECK VALGRIND -----------------------------------

echo "OK !";