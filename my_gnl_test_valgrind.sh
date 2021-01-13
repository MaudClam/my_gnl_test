# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    my_gnl_test.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mclam <mclam@student.21-school.ru>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/22 13:58:59 by mclam             #+#    #+#              #
#    Updated: 2021/01/06 23:15:00 by mclam            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
#!/bin/bash

FLAGS="-Wall -Wextra -Werror -D BUFFER_SIZE"
NORM="norminette -R CheckForbiddenSourceHeader"
CFILES="../get_next_line.c ../get_next_line_utils.c"
HFILE="../get_next_line.h"
OUT="./gnl_test.out"
CTEST="./my_gnl_test.c"
LTEST="./main_by_jbelinda.c"
CFNDSTR="./my_gnl_test_find_string.c"
LOG="../my_gnl_test_valgrind.log"
TDIR="./testexts"
RDIR="./ress"
DIFF="diff -q"

clear
rm -rf $LOG $RDIR/*.res

echo "= Host-specific information ====================================================" >> $LOG
echo "$> hostname; uname -msr" >> $LOG
hostname >>$LOG 2>&1
echo "$(uname -msr)" >> $LOG
echo "$> date">> $LOG
echo "$(date)" >> $LOG
echo "$> gcc --version">> $LOG
echo "$(gcc --version 2>&1)" >> $LOG
echo "$> clang --version">> $LOG
echo "$(clang --version)" >> $LOG
echo "===============================================================================" >> $LOG
echo >> $LOG

BUFSIZE=32
for FILE in $HFILE $CFILES
do
echo "####### "$FILE
echo "####### "$FILE >> $LOG
rm -rf $OUT $OUT.dSYM $RDIR/$TXTEST.res
gcc $FLAGS=$BUFSIZE $CFILES $CFNDSTR -o $OUT >> $LOG 2>> $LOG
for NEEDLE in "By" "Created:" "Updated:"
do
$OUT $FILE $NEEDLE "  "
$OUT $FILE $NEEDLE "  " >> $LOG 2>> $LOG
done
echo
echo "" >> $LOG
rm -rf $OUT $OUT.dSYM
done

for BUFSIZE in 1 2 3 5 32 64 512 2048 4096
do
rm -rf $OUT $OUT.dSYM
gcc $FLAGS=$BUFSIZE $CTEST $CFILES -o $OUT >> $LOG 2>> $LOG
for TXTEST in $(ls $TDIR)
do
echo "####### Testing the project for leaks using the program valgrind "$TXTEST" with BUFFER_SIZE="$BUFSIZE
echo "####### Testing the project for leaks using the program valgrind "$TXTEST" with BUFFER_SIZE="$BUFSIZE  >> $LOG
gcc $FLAGS=42 $CFILES $LTEST -o $OUT >> $LOG 2>> $LOG
valgrind $OUT $TDIR/$TXTEST >> $LOG 2>> $LOG
echo -e "        \033[33mSee the compilation results in the file "$LOG"\033[0m"
rm -rf $OUT $OUT.dSYM
echo
echo >> $LOG
done
done

rm -rf $RDIR/*.res

echo -e "All tests completed. See the tests results in the file "$LOG
echo
echo "= All tests completed =========================================================" >> $LOG
echo "$> date" >> $LOG
echo "$(date)" >> $LOG
