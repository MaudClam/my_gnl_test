/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   my_gnl_test_bonus_multi_fd.c                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mclam <mclam@student.21-school.ru>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/01/04 18:32:20 by mclam             #+#    #+#             */
/*   Updated: 2021/01/06 23:11:04 by mclam            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include "../get_next_line_bonus.h"

static int	gnl_strlen(const char *s)
{
	int len;
	
	len = 0;
	if (s)
	{
		while (s[len] != '\0')
			len++;
	}
	return (len);
}

static void	putstr_fd_endl(int fd, char *str, int endl)
{
	write(fd, str, gnl_strlen(str));
	if (endl)
		write(fd, "\n", 1);
}

int		main(void)
{
	char	*file_in[4] = {	"not_exist",
							"../get_next_line_bonus.h",
							"../get_next_line_bonus.c",
							"../get_next_line_utils_bonus.c"};
	char	*file_out[4] = {"ress/not_exist.res",
							"../get_next_line_bonus.h.res",
							"../get_next_line_bonus.c.res",
							"../get_next_line_utils_bonus.c.res"};
	int		fd_in[4];
	int		fd_out[4];
	int		i;
	int		j;
	char	*line;
	
	i = 0;
	line = NULL;
	while (i < 4)
	{
		fd_in[i] = open(file_in[i], O_RDONLY);
 		open(file_out[i], O_CREAT, 0644);
		fd_out[i] = open(file_out[i], O_TRUNC|O_WRONLY);
		i++;
	}
	j = 0;
	while (j < 11)
	{
		i = 0;
		while (i < 4)
		{
			if (i == 0)
			{
				get_next_line(fd_in[1], NULL);
				line = NULL;
			}
			if (get_next_line(fd_in[i], &line) > 0)
			{
				putstr_fd_endl(fd_out[i], line, 1);
				putstr_fd_endl(1, line, 1);
				free(line);
			}
			i++;
		}
		j++;
	}
	i = 0;
	while (i < 4)
	{
		while (get_next_line(fd_in[i], &line) > 0)
		{
			putstr_fd_endl(fd_out[i], line, 1);
			free(line);
		}
		putstr_fd_endl(fd_out[i], line, 0);
		free(line);
		i++;
	}
	i = 0;
	while (i < 4)
	{
		close(fd_in[i]);
		close(fd_out[i]);
		i++;
	}
	return (0);
}
