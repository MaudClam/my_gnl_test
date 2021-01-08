# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    gnl_speedtest.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mclam <mclam@student.21-school.ru>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/29 01:42:15 by mclam             #+#    #+#              #
#    Updated: 2021/01/06 23:14:04 by mclam            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
#!/bin/bash

FLAGS="-Wall -Wextra -Werror -O2 -D BUFFER_SIZE"
CFILES="../get_next_line.c ../get_next_line_utils.c"
HFILE="../get_next_line.h"
OUT="./gnl_speedtest.out"
SPEEDTEST="./main_by_jbelinda.c"
TESTEXT="/Users/Shared/war_and_peace_test.txt"

clear

#for BUFSIZE in 32 42 64 128 256 512 1024 2048 4096 8192 16384 32768 65536 131072 262144 524288 1058576 2097152 4194304 8388608 16777216
for BUFSIZE in 4096
do
echo "####### Testing "$TESTEXT" with BUFFER_SIZE="$BUFSIZE
rm -rf $OUT $OUT.dSYM
gcc $FLAGS=$BUFSIZE $CFILES $SPEEDTEST -o $OUT
time $OUT $TESTEXT
rm -rf $OUT $OUT.dSYM
echo
done

echo -e "\033[0;36m####### Testing\033[0m "$TESTEXT" \033[0;36mwhith a.out_by_jbelinda"
time ./a.out_by_jbelinda $TESTEXT
echo
echo -e "\033[0mTest completed"
echo
