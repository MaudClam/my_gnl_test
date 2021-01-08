/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   my_gnl_test_find_string.c                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mclam <mclam@student.21-school.ru>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/12/22 14:11:17 by mclam             #+#    #+#             */
/*   Updated: 2021/01/06 23:11:50 by mclam            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <string.h>
#include "../get_next_line.h"

#define DEBAG 0 /*	"1" - for debugging in Xcode, "0" - for Terminal          */

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

static void	putstr_endl(char *str, int endl)
{
	write(1, str, gnl_strlen(str));
	if (endl)
		write(1, "\n", 1);
}

static char	*gnl_strnstr(const char *haystack, const char *needle, size_t len)
{
	size_t haystack_len;
	size_t needle_len;
	size_t i;
	size_t j;
	
	haystack_len = gnl_strlen(haystack);
	needle_len = gnl_strlen(needle);
	if (0 == needle_len || NULL == needle)
		return ((char *)haystack);
	if (0 == haystack_len || NULL == haystack)
		return (NULL);
	i = 0;
	while (i + needle_len < len + 1 && i + needle_len < haystack_len + 1)
	{
		j = 0;
		while (needle[j] && haystack[i + j] == needle[j])
			j++;
		if (needle[j] == '\0')
			return ((char *)haystack + i);
		i++;
	}
	return (NULL);
	
}
int		main(int argc, char **argv)
{
	char	*debagfilename = "/Users/uru/GoogleDrive/21_Projects/get_next_line/get_next_line.c";
	char	*debagneedlestart = "stud";
	char	*debagneedleend = "ru";
	char	*flow;
	char	*needlestart;
	char	*needleend;
	int		fd;
	char	*haystack;
	int 	lines;
	int		exitcode_read;
	
	if (DEBAG)
	{
		argc = 4;
		flow = debagfilename;
		needlestart = debagneedlestart;
		needleend = debagneedleend;
	}
	else
	{
		flow = argv[1];
		needlestart = argv[2];
		needleend = argv[3];
	}
		if (argc < 4)
	{
		printf("No file name or search string specified\nUSAGE: program_name file_name search_string_start search_string_end\n");
		return (-1);
	}
	if (argc > 4)
	{
		printf("Too many arguments\nUSAGE: program_name file_name search_string_start search_string_end\n");
		return (-1);
	}
	if ((fd = open(flow, O_RDONLY)) < 0)
	{
		printf("No such file or directory: '%s'\nUSAGE: program_name file_name search_string_start search_string_end\n", argv[1]);
		return (-1);
	}
	lines = 0;
	while ((exitcode_read = get_next_line(fd, &haystack)) && haystack)
	{
		if (exitcode_read == -1)
		{
			putstr_endl("WARNING! get_next_line()=-1", 1);
			close(fd);
			return (-1);
		}
		if (gnl_strnstr(haystack, needlestart, gnl_strlen(haystack)))
		{
			if (gnl_strnstr(gnl_strnstr(haystack, needlestart, gnl_strlen(haystack)), needleend, gnl_strlen(haystack)))
				*gnl_strnstr(gnl_strnstr(haystack, needlestart, gnl_strlen(haystack)), needleend, gnl_strlen(haystack)) = '\0';
			putstr_endl(gnl_strnstr(haystack, needlestart, gnl_strlen(haystack)), 1);
		}
		free(haystack);
		lines++;
	}
	if (gnl_strnstr(haystack, needlestart, gnl_strlen(haystack)))
	{
		if (gnl_strnstr(gnl_strnstr(haystack, needlestart, gnl_strlen(haystack)), needleend, gnl_strlen(haystack)))
			*gnl_strnstr(gnl_strnstr(haystack, needlestart, gnl_strlen(haystack)), needleend, gnl_strlen(haystack)) = '\0';
		putstr_endl(gnl_strnstr(haystack, needlestart, gnl_strlen(haystack)), 1);
	}
	free(haystack);
	lines++;
	close(fd);
/*	The following line to find memory leaks                                   */
//	sleep(60);//FIXME
	return (0);
}
