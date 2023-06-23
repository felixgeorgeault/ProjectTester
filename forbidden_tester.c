/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: fgeorgea <fgeorgea@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/06/23 13:09:03 by fgeorgea          #+#    #+#             */
/*   Updated: 2023/06/23 14:59:11 by fgeorgea         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <sys/stat.h>
#include <string.h>
#include <unistd.h>
#include "main.h"
#include <fcntl.h>

char	**args;
char	**files;

#define MAX_FILES 1000
#define MAX_PATH_LENGTH 256

void traverseDirectory(const char *dirPath, char fileNames[MAX_FILES][MAX_PATH_LENGTH], int *count) {
    DIR *dir;
    struct dirent *entry;
    struct stat fileStat;
    char filePath[MAX_PATH_LENGTH];

    dir = opendir(dirPath);
    if (dir == NULL) {
        perror("Error opening directory");
        return;
    }

    while ((entry = readdir(dir)) != NULL) {
        // Ignore . and ..
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0)
            continue;

        snprintf(filePath, sizeof(filePath), "%s/%s", dirPath, entry->d_name);

        if (stat(filePath, &fileStat) == -1) {
            perror("Error getting file stat");
            continue;
        }

        if (S_ISDIR(fileStat.st_mode)) {
            // Recursive call for subdirectories
            traverseDirectory(filePath, fileNames, count);
        } else if (S_ISREG(fileStat.st_mode)) {
            // Regular file
            strncpy(fileNames[*count], filePath, MAX_PATH_LENGTH);
            (*count)++;
            if (*count >= MAX_FILES) {
                printf("Maximum number of files reached. Exiting.\n");
                closedir(dir);
                return;
            }
        }
    }
    closedir(dir);
}

void	free_array(char **array)
{
	int	i;

	i = 0;
	if (!array)
		return ;
	while (array[i])
	{
		free(array[i]);
		i++;
	}
	free(array);
}

static char	**ft_create_array_files(int size, char src[MAX_FILES][MAX_PATH_LENGTH])
{
	int		i;
	char	**array;

	i = 0;
	array = malloc(sizeof(char *) * (size + 1));
	if (!array)
		return (NULL);
	while (i < size)
	{
		ft_strlen(src[i]);
		array[i] = ft_strdup(src[i]);
		i++;
	}
	array[i] = NULL;
	return (array);
}

static int	correct_file(char *file)
{
	int	len;

	len = ft_strlen(file);
	if (file[len - 1] == 'c' && file[len - 2] == '.')
		return (1);
	return (0);
}

int	compare_strs(char *haystack, char *needle)
{
	int	len_hay;
	int	len_needle;

	len_hay = ft_strlen(haystack);
	len_needle = ft_strlen(needle);
	if (ft_strncmp(haystack, needle, len_hay) == 0 && (len_hay == len_needle))
		return (1);
	return (0);
}

int	is_forbidden(char *str)
{
	int	i;
	int	start;
	int	end;
	char	*function;
	char	*tmp;

	i = 0;
	while (str[i] && str[i] != '(')
		i++;
	if (!str[i])
		return (0);
	end = i;
	if (ft_isspace(str[i - 1]))
		return (0);
	while (str[i] && !ft_isspace(str[i]))
		i--;
	if (!str[i])
		return (0);
	start = i;
	tmp = ft_substr(str, start, end - start);
	if (!tmp)
	{
		free_array(files);
		exit(2);
	}
	function = ft_strtrim(tmp, " \t\r\v");
	i = 0;
	while (args[i])
	{
		if (compare_strs(function, args[i]))
		{
			dprintf(2, "%s: FORBIDDEN FUNCTION USED !\n", function);
			free(function);
			exit(3);
		}
		i++;
	}
	return (0);
}

static int	check_file(char *file)
{
	char	*str;
	int		fd;
	
	fd = open(file, O_RDONLY);
	if (fd < 0)
	{
		free_array(files);
		exit(1);
	}
	while (1)
	{
		str = get_next_line(fd);
		if (!str)
			break ;
		is_forbidden(str);
		free(str);
	}
	return (1);
	close(fd);
}

static int	loop_all_files(void)
{
	int	i;

	i = 0;
	while (files[i])
	{
		if (correct_file(files[i]))
			check_file(files[i]);
		i++;
	}
	return (1);
}

char	**create_args_array(char **src, int size)
{
	int		i;
	char	**args;

	args = malloc(sizeof(char *) * (size));
	i = 0;
	while (i < size)
	{
		args[i] = src[i + 1];
		i++;
	}
	args[i] = NULL;
	return (args);
}

int main(int argc, char **argv) {
    char 	fileNames[MAX_FILES][MAX_PATH_LENGTH];
    int 	count = 0;
    char 	*currentDir;

	if (argc < 2)
	{
		dprintf(2, "Please insert forbidden functions as program params\n");
		return (1);
	}
	currentDir = getcwd(NULL, 0);
	if (!currentDir)
	{
		perror("Error getting current directory");
        return (1);
	}
    traverseDirectory(currentDir, fileNames, &count);
	files = ft_create_array_files(count, fileNames);
	if (!files)
	{
		dprintf(2, "MALLOC FAILED\n");
		return (2);
	}
	args = create_args_array(argv, argc);
	loop_all_files();
	free_array(files);
	free(args);
	printf("There are no forbidden functions\n");
    return (0);
}
