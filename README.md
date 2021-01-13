# my_gnl_test
By: mclam <mclam@student.21-school.ru>

This is a complete tester for the Get Next Line project of 21-School 2020 version.
Memory leaks are checked by the mac os leaks utility and the valgrind utility, which should be installed on your computer.

Not an advanced developer (I'm just learning), I made this test for myself. Any comments will be greatly appreciated.

1. cd to the folder with your fonctions
2. git clone https://github.com/MaudClam/my_gnl_test
3. cd my_gnl_test
4. bash my_gnl_test.sh or my_gnl_test_bonus.sh

See the test results in the files 'my_gnl_test.log' and 'my_gnl_test_bonus.log', which will be created in the folder with your functions.

For an extended test for memory leaks:

5. bash my_gnl_test_valgrind.sh or my_gnl_test_bonus_valgrind.sh

See the test results in the files 'my_gnl_test_valgrind.log' and 'my_gnl_test_valgrind_bonus.log', which will be created in the folder with your functions.

You can test the speed of your function using the speed test by jbelinda <jbelinda@student.21-school.ru>:

6. bash gnl_speedtest.sh or gnl_speedtest_bonus.sh

ATTENTION! The 'gnl_speedtest.sh' and 'gnl_speedtest_bonus.sh' tests require a large text file of ~500 megabytes, which is not included. Open the files 'gnl_speedtest.sh' and 'gnl_speedtest_bonus.sh' and specify the full path to such a file on the 19th line.

For testing, the test uses files from the 'testexts' folder. Additional cases are in the 'testexts.cases' folder.

You can create your own file for testing:

7. gcc gnl_testext_generator.c && ./a.out > textest_file_name

The comments inside 'gnl_testext_generator.c' will help you set the desired parameters for such a file.
