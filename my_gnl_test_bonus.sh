# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    my_gnl_test_bonus.sh                               :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mclam <mclam@student.21-school.ru>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/22 13:58:59 by mclam             #+#    #+#              #
#    Updated: 2021/01/06 23:15:17 by mclam            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #
#!/bin/bash

FLAGS="-Wall -Wextra -Werror -D BUFFER_SIZE"
NORM="norminette -R CheckForbiddenSourceHeader"
CFILES="../get_next_line_bonus.c ../get_next_line_utils_bonus.c"
HFILE="../get_next_line_bonus.h"
OUT="./gnl_test_bonus.out"
CTEST="./my_gnl_test.c"
LTEST="./main_by_jbelinda.c"
CMULTIFD="./my_gnl_test_bonus_multi_fd.c"
LOG="../my_gnl_test_bonus.log"
TDIR="./testexts"
RDIR="./ress"
DIFF="diff -q"

clear
rm -rf $LOG $RDIR/*.*

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
echo "####### Testing managing multiple file descriptors"
echo "####### Testing managing multiple file descriptors" >> $LOG
rm -rf $OUT $OUT.dSYM
gcc $FLAGS=$BUFSIZE $CFILES $CMULTIFD -o $OUT >> $LOG 2>> $LOG
$OUT 2>> $LOG
$OUT 2>> $LOG >> $LOG
for DIFILE in $CFILES $HFILE
do
if $DIFF $DIFILE $DIFILE.res
then
echo -e "        \033[0;32mTest OK\033[0m"
echo "        Test OK" >> $LOG
rm -rf $DIFILE.res
else
$DIFF $DIFF $DIFILE $DIFILE.res 2>> $LOG >> $LOG
echo -e "        \033[0;31mERROR\033[0m"
echo "        ERROR" >> $LOG
fi
done
echo
echo "" >> $LOG
#rm -rf $OUT $OUT.dSYM

echo "####### Norminette"
echo "####### Norminette" >> $LOG
$NORM $CFILES $HFILE
$NORM $CFILES $HFILE >> $LOG
echo
echo >> $LOG

echo -e "####### Testing STDIN"
echo "####### Testing STDIN" >> $LOG
echo -e "\033[0;32mType a long line (more than 42 char), type ENTER, type a short line, type ENTER"
echo -e "Open an other terminal page and type the command '\033[0mleaks gnl_test_bonus.out\033[0;32m'"
echo -e "The last line should say '0 leaks for 0 total leaked bytes.'"
echo -e "Come back to this terminal and type Ctrl + D\033[0m"
rm -rf $OUT $OUT.dSYM
gcc $FLAGS=42 $CFILES $CTEST -o $OUT 2>> $LOG >> $LOG
$OUT -k 2>> $LOG
echo
echo >> $LOG

for BUFSIZE in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 32 42 64 128 256 512 1024 2048 4096 9999 10000000
do
rm -rf $OUT $OUT.dSYM
gcc $FLAGS=$BUFSIZE $CTEST $CFILES -o $OUT >> $LOG 2>> $LOG
for TXTEST in $(ls $TDIR)
do
echo "####### Testing "$TXTEST" with BUFFER_SIZE="$BUFSIZE
echo "####### Testing "$TXTEST" with BUFFER_SIZE="$BUFSIZE >> $LOG
rm -rf $RDIR/$TXTEST.res
$OUT $TDIR/$TXTEST 2>> $LOG > $RDIR/$TXTEST.res
if $DIFF $TDIR/$TXTEST $RDIR/$TXTEST.res
then
echo -e "        \033[0;32mTest OK\033[0m"
echo "        Test OK" >> $LOG
else
$DIFF $TDIR/$TXTEST $RDIR/$TXTEST.res 2>> $LOG >> $LOG
echo -e "        \033[0;31mERROR\033[0m"
echo "        ERROR" >> $LOG
fi
echo
echo >> $LOG
done
done

echo -e "####### Testind with wrong file descriptor (77)"
echo -e "        \033[33mSee the test results in the file "$LOG"\033[0m"
echo "####### Testind with wrong file descriptor (77)" >> $LOG
rm -rf $OUT $OUT.dSYM
gcc $FLAGS=42 $CFILES $CTEST -o $OUT 2>> $LOG >> $LOG
$OUT -f 2>> $LOG >> $LOG
rm -rf $OUT $OUT.dSYM
echo
echo >> $LOG

for BUFSIZE in 0 -1
do
echo -e "####### Compiling the project with BUFFER_SIZE="$BUFSIZE
echo -e "        \033[33mSee the compilation results in the file "$LOG"\033[0m"
echo "####### Compiling the project with BUFFER_SIZE="$BUFSIZE >> $LOG
rm -rf $OUT $OUT.dSYM
gcc $FLAGS=$BUFSIZE $CFILES $CTEST -o $OUT >> $LOG 2>> $LOG
$OUT $HFILE 2>> $LOG >> $LOG
rm -rf $OUT $OUT.dSYM
echo
echo >> $LOG
done

echo "####### Testing the project for leaks using the program valgrind"
echo "####### Testing the project for leaks using the program valgrind"  >> $LOG
gcc $FLAGS=42 $CFILES $LTEST -o $OUT >> $LOG 2>> $LOG
valgrind $OUT $HFILE >> $LOG 2>> $LOG
echo -e "        \033[33mSee the compilation results in the file "$LOG"\033[0m"
rm -rf $OUT $OUT.dSYM
echo
echo >> $LOG

rm -rf $RDIR/*.*

echo -e "All tests completed. See the tests results in the file "$LOG
echo
echo "= All tests completed =========================================================" >> $LOG
echo "$> date">> $LOG
echo "$(date)" >> $LOG
