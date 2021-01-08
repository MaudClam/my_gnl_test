/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   gnl_testext_generator.c                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mclam <mclam@student.21-school.ru>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/12/22 12:41:59 by mclam             #+#    #+#             */
/*   Updated: 2021/01/06 23:09:57 by mclam            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
/*     Program for generating test text files for a project GET NEXT LINE     */
/*        Usage: gcc testext_generator.c && ./a.out > testexfilename          */

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

static void	ft_putchar(char c)
{
	write(1, &c, 1);
}

/*The function generates a set of pseudo-random numbers in the range          */
/*from rmin to rmax inclusive, n — is a parameter for distinguishing          */
/*the returned sets of sets                                                   */
static int	randomizer(int rmin, int rmax, int n)
{
	srand(n);
	return (rand() % (rmax - rmin + 1) + rmin);
}

/*The function returns 1 if c is included in the set of exceptions            */
/*and 0 if it is not                                                          */
static int	isexception(char c, char *exceptions)
{
	int i;
	
	i = 0;
	while (i < 3)//i < [x] in main()
	{
		if (c == exceptions[i])
			return (i + 1);
		i++;
	}
	return (0);
}

int		main(void)
{
	int		cmin = 48; //The lower bound of the range of random characters
	int		cmax = 91;  //The upper limit of the range of random characters
	int		exceptions[3] = {47, 92, 127};//Exceptions (i < [x] in isexception())
	int		lines = 1;  //Number of lines
	char	endln = 'N';//End of line, 'N' - no end of line
	int		lnmin = 10000000;   //The lower bound of the range of random line lengths
	int		lnmax = 10000000;   //The upper limit of the range of random line lengths
	int		line_ln[lines];
	char	c;
	int		i;
	int		j;
	int		n;
	
	j = 0;
	n = 100;
	while (j < lines)
	{
		line_ln[j] = randomizer(lnmin, lnmax, (n++) + j);
		j++;
	}
	j = 0;
	while (j < lines)
	{
		i = 0;
		while (i < line_ln[j])
		{
			c = randomizer(cmin, cmax, (n++) * i);
			if (!(isexception(c, (char *)exceptions)))
			{
				ft_putchar(c);
				i++;
			}
		}
		if (endln != 'N')
			ft_putchar(endln);
		j++;
	}
}
