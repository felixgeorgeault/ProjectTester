# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgeorgea <fgeorgea@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/06/23 13:12:59 by fgeorgea          #+#    #+#              #
#    Updated: 2023/06/23 15:00:20 by fgeorgea         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = forbidden_ft_checker

DEPENDS = make -C libft

SRC = forbidden_tester.c \

OBJ = ${SRC:.c=.o}

CFLAGS = -Wall -Wextra -Werror

REMOVE = rm -f

COMPILE = gcc $(CFLAGS) -o $(NAME)

all: $(NAME)

$(NAME): $(OBJ)
	make -C libft
	$(COMPILE) $(OBJ) -Iinclude -Llibft -lft

clean:
	$(REMOVE) $(OBJ)
	make -C libft clean

fclean:	clean
	$(REMOVE) $(NAME)
	make -C libft fclean
	
re: fclean all

.PHONY: all clean fclean re