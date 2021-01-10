# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    gnl_speedtest_bonus.sh                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mclam <mclam@student.21-school.ru>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/29 01:42:15 by mclam             #+#    #+#              #
#    Updated: 2021/01/06 23:14:33 by mclam            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
#!/bin/bash

FLAGS="-Wall -Wextra -Werror -O2 -D BUFFER_SIZE"
CFILES="../get_next_line_bonus.c ../get_next_line_utils_bonus.c"
HFILE="../get_next_line_bonus.h"
OUT="./gnl_speedtest_bonus.out"
SPEEDTEST="./main_by_jbelinda_bonus.c"
TESTEXT="/Users/Shared/war_and_peace_test.txt"

clear

#for BUFSIZE in 32 42 64 128 256 512 1024 2048 4096 8192 16384 32768 65536 131072 262144 524288 1058576 2097152 4194304 8388608 16777216
for BUFSIZE in 4096
do
echo -e "####### Testing \033[0;36myour GNL_bonus BUFFER_SIZE="$BUFSIZE
echo -e "\033[0mfile: "$TESTEXT
rm -rf $OUT $OUT.dSYM
gcc $FLAGS=$BUFSIZE $CFILES $SPEEDTEST -o $OUT
time $OUT $TESTEXT
rm -rf $OUT $OUT.dSYM
echo
done

echo -e "####### Testing \033[0;36ma.out_by_jbelinda\033[0m"
echo -e "file: "$TESTEXT
time ./a.out_by_jbelinda $TESTEXT
echo
echo -e "Test completed"
echo
