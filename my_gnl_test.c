/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   my_gnl_test.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mclam <mclam@student.21-school.ru>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/12/22 14:11:17 by mclam             #+#    #+#             */
/*   Updated: 2021/01/06 23:10:36 by mclam            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <fcntl.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define DEBAG 0 /*	"1" - for debugging in Xcode, "0" - for Terminal          */

int		get_next_line(int fd, char **line);

int		main(int argc, char **argv)
{
	char	*filename = "Shakespeare_Sonnets.txt";
	char	*flow;
	int		fd;
	char	*line;
	int 	lines;
	int		exitcode_gnl;
	
	if (DEBAG)
	{
		argc = 2;
		flow = filename;
	}
	else
		flow = argv[1];
	if (argc < 2)
	{
		printf("File name not specified for reading\nUSAGE: program_name [-k] [-f] [file_name]\n");
		return (-1);
	}
	if (argc > 2)
	{
		printf("Too many arguments\nUSAGE: program_name [-k] [-f] [file_name]\n");
		return (-1);
	}
	if (flow[0] == '-' && flow[1] == 'k')
		fd = 0;
	else if (flow[0] == '-' && flow[1] == 'f')
		fd = 77;
	else if ((fd = open(flow, O_RDONLY)) < 0)
	{
		printf("No such file or directory: '%s'\nUSAGE: program_name [-k] [-f] [file_name]\n", argv[1]);
		return (-1);
	}
	lines = 0;
	line = NULL;
	while ((exitcode_gnl = get_next_line(fd, &line)) > 0)
	{
		if (DEBAG)
			printf("%p %d %s\n", line, exitcode_gnl, line);
		else
			printf("%s\n", line);
		free(line);
		lines++;
	}
	if (exitcode_gnl < 0)
	{
		printf("WARNING! get_next_line()=%d", exitcode_gnl);
		close(fd);
		return (-1);
	}
	if (DEBAG)
		printf("%p %d %s", line, exitcode_gnl, line);
	else
		printf("%s", line);
	free(line);
	close(fd);
/*	The following line to find memory leaks                                   */
//	sleep(20);//FIXME
	return (0);
}
