#include "../include/Tests.h"
#include "../include/ProjectTest.h"
#include <iostream>
#include <typeinfo>
#include <fstream>
#include <math.h>
#include <sstream>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <vector>

using std::vector;
using std::streambuf;
using std::istringstream;
using std::to_string;
using std::cout;
using std::sprintf;
using std::complex;
using std::ifstream;
using std::stringstream;

#define RED   "\e[38;5;196m"
#define GRN   "\e[38;5;082m"
#define YEL   "\e[38;5;226m"
#define MAG   "\e[38;5;201m"
#define RESET "\e[0m"

// Defining Global Variables
vector<string> testsInputs;
vector<string> testsExpected;
vector<vector<string>> testsUserPrograms;
vector<string> testsHints;

std::stringstream ss;
std::streambuf *old_buf;
int abortExecution = 0;
extern int timeForSmallTest;
extern int testToExecute;

// Initializing before execution of tests
void Initialize()
{ 
  //change the underlying cout buffer and save the old buffer
  old_buf = std::cout.rdbuf(ss.rdbuf());

  // Catching signal
  signal(SIGINT,sigintHandler);
}

// Finialize after execution of tests
void Finialize()
{   
    // Restoring signal behaviour
    signal(SIGINT,SIG_DFL);

    // Restoring cout buffer
    std::cout.rdbuf(old_buf);

    // Printing cout output
    std::string text_output = ss.str();
    std::cout << text_output;
}

// Initializing tests to be executed
void InitializingTests()
{
    /* ### Example of use ###

     testsFunctions.push_back();

    */

    // Initializing tests to be executed
    testsFunctions.push_back(Operating_System_Test);

    // Defining tests
    string test_0_Input = R"V0G0N(
usertests
)V0G0N";
    string test_0_Expected = "#ALL TESTS PASSED"; 
    vector<string> test_0_UserPrograms = {"usertests","quitXV6"};
    string test_0_Hint = "General problem with xv6 due to changes made to it."; 

    string test_1_Input = R"V0G0N(
forktest
    )V0G0N";
    string test_1_Expected = R"V0G0N(
$ fork test
fork test OK
$ $ Finished Yehonatan Peleg Test, quiting...
)V0G0N";
    vector<string> test_1_UserPrograms = {"quitXV6"};
    string test_1_Hint = "General problem with xv6 due to changes made to it.";

    string test_2_Input = R"V0G0N(
pathTest
helloW
pathTest1
helloW
pathTest2.1
helloW
pathTest2.2
helloW
pathTest3
helloW
    )V0G0N";
    string test_2_Expected = "+3Hello World XV6";
    vector<string> test_2_UserPrograms = {"helloW","pathTest","pathTest1","quitXV6",
                                          "pathTest2.1","pathTest2.2","pathTest3"};
    string test_2_Hint = "Problem with the implementation of task1: Path environment variable.";

    string test_3_Input = R"V0G0N(
exitWait
    )V0G0N";
    string test_3_Expected = R"V0G0N(
$ 1 child exit status is: 1
2 child exit status is: 2
3 child exit status is: 3
4 child exit status is: 4
5 child exit status is: 5
6 child exit status is: 6
7 child exit status is unknown
$ $ Finished Yehonatan Peleg Test, quiting...
    )V0G0N";;
    vector<string> test_3_UserPrograms = {"exitWait","detachTest","quitXV6"};
    string test_3_Hint = "Problem with the implementation of task2: Exit and wait do not funtion properly.";

    string test_4_Input = R"V0G0N(
detachTest
    )V0G0N";
    string test_4_Expected = R"V0G0N(
$ detach result for not my child is: -1
detach result for child 1 is: 0
detach result for child 2 is: 0
detach result for child 3 is: 0
detach result for child 4 is: 0
detach result for child 5 is: 0
detach result for child 6 is: 0
detach result for not my child is: -1
second detach result for child 1 is: -1
second detach result for child 2 is: -1
second detach result for child 3 is: -1
second detach result for child 4 is: -1
second detach result for child 5 is: -1
second detach result for child 6 is: -1
detach result for not my child is: -1
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
no child left to wait for
$ $ Finished Yehonatan Peleg Test, quiting...
    )V0G0N";;
    vector<string> test_4_UserPrograms = {"exitWait","detachTest","quitXV6"};
    string test_4_Hint = "Problem with the implementation of task2: Detach do not funtion properly.";

    string test_5_Input = R"V0G0N(
prioritySysTest
policySysTest
    )V0G0N";
    string test_5_Expected = R"V0G0N(
$ Calling priority system call with correct args
Calling priority system call with correct args
Calling priority system call with correct args
Calling priority system call with correct args
Calling priority system call with correct args
Calling priority system call with correct args
Calling priority system call with wrong args
Calling priority system call with wrong args
Calling priority system call with wrong args
$ Calling priority system call with correct args
Calling policy system call
Calling priority system call with correct args
Calling policy system call
Calling priority system call with correct args
Calling policy system call
Calling priority system call with correct args
Calling policy system call
Calling priority system call with correct args
Calling policy system call
Calling priority system call with correct args
Calling policy system call
Calling policy system call
Calling priority system call with correct args
Calling priority system call with wrong args
Calling policy system call
Calling priority system call with wrong args
Calling policy system call
Calling priority system call with wrong args
$ $ Finished Yehonatan Peleg Test, quiting...
    )V0G0N";;
    vector<string> test_5_UserPrograms = {"prioritySysTest","policySysTest","quitXV6"};
    string test_5_Hint = "Problem with the implementation of task3: Priority or policy sys calls maybe crushes.";

    string test_6_Input = R"V0G0N(
schedulingTest1
    )V0G0N";
    string test_6_Expected = R"V0G0N(
$ Initiating scheduling test, test should take approximately 30000 time quantums !!!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
$ $ Finished Yehonatan Peleg Test, quiting...
    )V0G0N";;
    vector<string> test_6_UserPrograms = {"schedulingTest1","quitXV6"};
    string test_6_Hint = "Problem with the implementation of task3: Round Robin do not function properly. "
                         " Maybe you forgot to insert a process to the queue after been killed.";

    string test_7_Input = R"V0G0N(
schedulingTest2
    )V0G0N";
    string test_7_Expected = R"V0G0N(
$ Initiating scheduling test, test should take approximately 30000 time quantums !!!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
$ $ Finished Yehonatan Peleg Test, quiting...
    )V0G0N";;
    vector<string> test_7_UserPrograms = {"schedulingTest2","quitXV6"};
    string test_7_Hint = "Problem with the implementation of task3: Priority Scheduling do not function properly. "
                         " Maybe you forgot to insert a process to the queue after been killed.";

    string test_8_Input = R"V0G0N(
schedulingTest3
    )V0G0N";
    string test_8_Expected = R"V0G0N(
$ Initiating scheduling test, test should take approximately 30000 time quantums !!!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
$ $ Finished Yehonatan Peleg Test, quiting...
    )V0G0N";;
    vector<string> test_8_UserPrograms = {"schedulingTest3","quitXV6"};
    string test_8_Hint = "Problem with the implementation of task3: Extendedn Priority Scheduling do not function properly. "
                         " Maybe you forgot to insert a process to the queue after been killed.";

    string test_9_Input = R"V0G0N(
schedulingTest4
    )V0G0N";
    string test_9_Expected = R"V0G0N(
$ Initiating scheduling test, test should take approximately 30000 time quantums !!!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
$ $ Finished Yehonatan Peleg Test, quiting...
    )V0G0N";;
    vector<string> test_9_UserPrograms = {"schedulingTest4","quitXV6"};
    string test_9_Hint = "Problem with the implementation of task3: Switching between scheduling policies do not function properly.";

    string test_10_Input = R"V0G0N(
schedulingTest5
    )V0G0N";
    string test_10_Expected = R"V0G0N(
$ Initiating scheduling test, test should take approximately 30000 time quantums !!!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
$ $ Finished Yehonatan Peleg Test, quiting...
    )V0G0N";;
    vector<string> test_10_UserPrograms = {"schedulingTest5","quitXV6"};
    string test_10_Hint = "Problem with the implementation of task3: Switching between scheduling policies do not function properly.";

    string test_11_Input = R"V0G0N(
schedulingTest6
    )V0G0N";
    string test_11_Expected = R"V0G0N(
$ Initiating scheduling test, test should take approximately 30000 time quantums !!!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
$ $ Finished Yehonatan Peleg Test, quiting...
    )V0G0N";;
    vector<string> test_11_UserPrograms = {"schedulingTest6","quitXV6"};
    string test_11_Hint = "Problem with the implementation of task3: Switching between scheduling policies do not function properly.";

    string test_12_Input = R"V0G0N(
schedulingTest7
    )V0G0N";
    string test_12_Expected = R"V0G0N(
$ 11111111119999999999
$ $ Finished Yehonatan Peleg Test, quiting...
    )V0G0N";;
    vector<string> test_12_UserPrograms = {"schedulingTest7","quitXV6"};
    string test_12_Hint = "Problem with the implementation of task3: Priorites In Priority Scheduling do not function properly.";

    string test_13_Input = R"V0G0N(
schedulingTest8
    )V0G0N";
    string test_13_Expected = R"V0G0N(
$ 11111111119999999999
$ $ Finished Yehonatan Peleg Test, quiting...
    )V0G0N";;
    vector<string> test_13_UserPrograms = {"schedulingTest8","quitXV6"};
    string test_13_Hint = "Problem with the implementation of task3: Priorites In Extended Priority Scheduling do not function properly.";

    string test_14_Input = R"V0G0N(
schedulingTest9
    )V0G0N";
    string test_14_Expected = R"V0G0N(
$ 00000000009999999999
$ $ Finished Yehonatan Peleg Test, quiting...
    )V0G0N";;
    vector<string> test_14_UserPrograms = {"schedulingTest9","quitXV6"};
    string test_14_Hint = "Problem with the implementation of task3: Priorites In Extended Priority Scheduling do not function properly.";

    string test_15_Input = R"V0G0N(
schedulingTest10
    )V0G0N";
    string test_15_Expected = R"V0G0N(
$ Initiating scheduling test, test should take approximately 15000 time quantums !!!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
$ $ Finished Yehonatan Peleg Test, quiting...
    )V0G0N";;
    vector<string> test_15_UserPrograms = {"schedulingTest10","quitXV6"};
    string test_15_Hint = "Problem with the implementation of task3: Starvation In Extended Priority Scheduling.";

    string test_16_Input = R"V0G0N(
schedulingTest11
    )V0G0N";
    string test_16_Expected = R"V0G0N(
$ Initiating scheduling test, test should take approximately 15000 time quantums !!!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
$ $ Finished Yehonatan Peleg Test, quiting...
    )V0G0N";;
    vector<string> test_16_UserPrograms = {"schedulingTest11","quitXV6"};
    string test_16_Hint = "Problem with the implementation of task3: Starvation In Priority Scheduling."
                          " Maybe you let setting priority 0 when priority 2 is selected.";

    string test_17_Input = R"V0G0N(
schedulingTest12
    )V0G0N";
    string test_17_Expected = R"V0G0N(
$ Initiating scheduling test, test should take approximately 15000 time quantums !!!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
zombie!
$ $ Finished Yehonatan Peleg Test, quiting...
    )V0G0N";;
    vector<string> test_17_UserPrograms = {"schedulingTest12","quitXV6"};
    string test_17_Hint = "Problem with the implementation of task3: Starvation In Priority Scheduling."
                          " Maybe you forgot to set priority to 1 of all priority 0 processes when switching from policy 3 to 2.";

    string test_18_Input = R"V0G0N(
schedulingTest13
    )V0G0N";
    string test_18_Expected = R"V0G0N(
$ Initiating scheduling test, test should take approximately 10000 time quantums !!!
ctime test 1 ok
ctime test 2 ok
ctime test 3 ok
ctime test 4 ok
ctime test 5 ok
stime test 1 ok
stime test 2 ok
stime test 3 ok
stime test 4 ok
stime test 5 ok
rutime test 1 ok
rutime test 2 ok
rutime test 3 ok
rutime test 4 ok
rutime test 5 ok
ttime test 1 ok
ttime test 2 ok
ttime test 3 ok
ttime test 4 ok
ttime test 5 ok
ttime test 6 ok
ttime test 7 ok
$ $ Finished Yehonatan Peleg Test, quiting...
    )V0G0N";
    vector<string> test_18_UserPrograms = {"schedulingTest13","quitXV6"};
    string test_18_Hint = "Problem with the implementation of task3: Problem with the implementation of the performance data capture.";

    string test_19_Input = R"V0G0N(
pathTest
pathTest4
echo Hello_World_XV6 | cat
pathTest5
echo Hello_World_XV6 | cat
    )V0G0N";
    string test_19_Expected = "+1Hello_World_XV6";
    vector<string> test_19_UserPrograms = {"pathTest","pathTest4","pathTest5","quitXV6"};
    string test_19_Hint = "Problem with the implementation of task1: Path environment variable with pipes.";

    string test_20_Input = R"V0G0N(
policy 1
echo "policy 1"
policy 3
echo "policy 3"
policy 2
echo "policy 2"
    )V0G0N";
    string test_20_Expected = R"V0G0N(
$ $ "policy 1"
$ $ "policy 3"
$ $ "policy 2"
$ $ Finished Yehonatan Peleg Test, quiting...
    )V0G0N";
    vector<string> test_20_UserPrograms = {"quitXV6"};
    string test_20_Hint = "Problem with the implementation of task3: User program policy dosen't work.";

    // Adding Tests inputs and expected
    testsInputs.push_back(test_0_Input);
    testsExpected.push_back(test_0_Expected);
    testsUserPrograms.push_back(test_0_UserPrograms);
    testsHints.push_back(test_0_Hint);

    testsInputs.push_back(test_1_Input);
    testsExpected.push_back(test_1_Expected);
    testsUserPrograms.push_back(test_1_UserPrograms);
    testsHints.push_back(test_1_Hint);

    testsInputs.push_back(test_2_Input);
    testsExpected.push_back(test_2_Expected);
    testsUserPrograms.push_back(test_2_UserPrograms);
    testsHints.push_back(test_2_Hint);

    testsInputs.push_back(test_3_Input);
    testsExpected.push_back(test_3_Expected);
    testsUserPrograms.push_back(test_3_UserPrograms);
    testsHints.push_back(test_3_Hint);

    testsInputs.push_back(test_4_Input);
    testsExpected.push_back(test_4_Expected);
    testsUserPrograms.push_back(test_4_UserPrograms);
    testsHints.push_back(test_4_Hint);

    testsInputs.push_back(test_5_Input);
    testsExpected.push_back(test_5_Expected);
    testsUserPrograms.push_back(test_5_UserPrograms);
    testsHints.push_back(test_5_Hint);

    testsInputs.push_back(test_6_Input);
    testsExpected.push_back(test_6_Expected);
    testsUserPrograms.push_back(test_6_UserPrograms);
    testsHints.push_back(test_6_Hint);

    testsInputs.push_back(test_7_Input);
    testsExpected.push_back(test_7_Expected);
    testsUserPrograms.push_back(test_7_UserPrograms);
    testsHints.push_back(test_7_Hint);

    testsInputs.push_back(test_8_Input);
    testsExpected.push_back(test_8_Expected);
    testsUserPrograms.push_back(test_8_UserPrograms);
    testsHints.push_back(test_8_Hint);

    testsInputs.push_back(test_9_Input);
    testsExpected.push_back(test_9_Expected);
    testsUserPrograms.push_back(test_9_UserPrograms);
    testsHints.push_back(test_9_Hint);

    testsInputs.push_back(test_10_Input);
    testsExpected.push_back(test_10_Expected);
    testsUserPrograms.push_back(test_10_UserPrograms);
    testsHints.push_back(test_10_Hint);

    testsInputs.push_back(test_11_Input);
    testsExpected.push_back(test_11_Expected);
    testsUserPrograms.push_back(test_11_UserPrograms);
    testsHints.push_back(test_11_Hint);

    testsInputs.push_back(test_12_Input);
    testsExpected.push_back(test_12_Expected);
    testsUserPrograms.push_back(test_12_UserPrograms);
    testsHints.push_back(test_12_Hint);

    testsInputs.push_back(test_13_Input);
    testsExpected.push_back(test_13_Expected);
    testsUserPrograms.push_back(test_13_UserPrograms);
    testsHints.push_back(test_13_Hint);

    testsInputs.push_back(test_14_Input);
    testsExpected.push_back(test_14_Expected);
    testsUserPrograms.push_back(test_14_UserPrograms);
    testsHints.push_back(test_14_Hint);

    testsInputs.push_back(test_15_Input);
    testsExpected.push_back(test_15_Expected);
    testsUserPrograms.push_back(test_15_UserPrograms);
    testsHints.push_back(test_15_Hint);

    testsInputs.push_back(test_16_Input);
    testsExpected.push_back(test_16_Expected);
    testsUserPrograms.push_back(test_16_UserPrograms);
    testsHints.push_back(test_16_Hint);

    testsInputs.push_back(test_17_Input);
    testsExpected.push_back(test_17_Expected);
    testsUserPrograms.push_back(test_17_UserPrograms);
    testsHints.push_back(test_17_Hint);

    testsInputs.push_back(test_18_Input);
    testsExpected.push_back(test_18_Expected);
    testsUserPrograms.push_back(test_18_UserPrograms);
    testsHints.push_back(test_18_Hint);

    testsInputs.push_back(test_19_Input);
    testsExpected.push_back(test_19_Expected);
    testsUserPrograms.push_back(test_19_UserPrograms);
    testsHints.push_back(test_19_Hint);

    testsInputs.push_back(test_20_Input);
    testsExpected.push_back(test_20_Expected);
    testsUserPrograms.push_back(test_20_UserPrograms);
    testsHints.push_back(test_20_Hint);
}

/* ### Example of use ###

// Executing DEMO_TEST
void DEMO_TEST()
{
  // Initializing
  currentTestName = DEMO_TEST

  // Testing

  test(0,"got","expected");

  try
  {
    test(1,"maybe exception will be thrwon from here,"$$$ ASSERT_THROWN_EXCEPTIONS $$$");
  }
  catch (ExceptionType exp)
  {
    test("","$$$ DECLARE GOOD TEST $$$");
  }

}
*/

// Processing test
bool procceseTest(string testName,unsigned int testNumber){
    // Initializing 
    string testBaseFolder = "Tests/" + testName;
    string testFolder = "./Project_Test/" + testBaseFolder;
    string testInputFileName = "/testInput.txt";
    string testOutputFileName = "/testOutput.txt";
    string testMakefileErrorFileName = "/makefileError.txt";
    string testMakefileCommandFileName = "/makefileCommandForDebug.txt";
    string testsExpectedFileName = "/testExpected.txt";
    int testCompletedFlag;

    // Creating XV6 Tests Folder
    createXV6_TestMakefile(testBaseFolder + "/Makefile",testsUserPrograms.at(testNumber));

    // Executing test
    string makefileCommand = "make --makefile=" + testFolder +  "/Makefile clean qemu ";
    string test_command = "cd .. && " + makefileCommand + " -s < " + testFolder + testInputFileName;
    string got_test = GetStdoutFromCommandAsync(test_command,"Finished Yehonatan Peleg Test, quiting...",timeForSmallTest,testCompletedFlag);    
    
    // Creating Test Makefile command
    std::ofstream outCommand(testBaseFolder + testMakefileCommandFileName);
    outCommand << makefileCommand;
    outCommand.close();

    // Processing test output
    got_test = processTestOutput(got_test);

    // Writing test output to file
    std::ofstream out(testBaseFolder + testOutputFileName);
    out << got_test;
    out.close();

    // Retrieving test hint 
    string test_hint = testsHints.at(testNumber);

    // Asserting test completed
    if(testCompletedFlag == 1){
        // Retrieving test expected
        string expected_test = processCompareString(testsExpected.at(testNumber));

        if(expected_test.at(0) == '#'){
          if(got_test.find(expected_test.substr(1)) != std::string::npos){
              test(testNumber,"","$$$ DECLARE GOOD TEST $$$");
          }
          else{
              test(testNumber,got_test,"Output should have contain this: \n" + expected_test,vector<string>{"String value with /n",test_hint});
          }
          
        }
        else if(expected_test.at(0) == '+'){
            if(countSubStr(got_test,expected_test.substr(2)) == (expected_test.at(1) - '0')){
                test(testNumber,"","$$$ DECLARE GOOD TEST $$$");
            }
            else{
               test(testNumber,got_test,"Output should have contain this: \n" + expected_test.substr(2) + "\n" + 
                    expected_test.at(1) + " times",vector<string>{"String value with /n",test_hint});
            }
        }
        else{
            test(testNumber,got_test,expected_test,vector<string>{"String value with /n",test_hint});
        }
    }
    else if(testCompletedFlag == 0){
      // Creating Test Expected
      std::ofstream outError(testBaseFolder + testMakefileErrorFileName);
      outError << got_test;
      outError.close();

      // Declaring Test Execution Ended With Timeout
      test(testNumber,"$$$ SMALL TEST EXECUTION TIMED OUT $$$","",vector<string>{"",test_hint});
    }
    else{
      // Declaring Test Execution Ended With Error
      test(testNumber,"$$$ TEST EXECUTION ERROR $$$","");
    }

    return 0;
}

// Running specific test
void runSpecificTest(int testToExecute){
    // Initializing
    string test_name = "test_" + std::to_string(testToExecute);
  
    // Declaring specific test is running
    printf("Running ");
    printf("test_");
    printf("%d for specific test request\n\n",testToExecute);

    // Runnig specific test
    procceseTest(test_name,testToExecute);
}

// Creating Tests
unsigned int CreateTests()
{
  // Creating Tests Folder
  string createTestFolderCommand = "rm -rf Tests && mkdir Tests";
  string got_createTestFolder = GetStdoutFromCommand(createTestFolderCommand);

   // Creating Tests
  for(unsigned int i = 0;i < testsInputs.size();i++)
  { 
    // Retrieving current test to create
    string currentTestInput = testsInputs.at(i);
    string currentTestExpected = testsExpected.at(i);

    // Defining Test Folder
    string testFolder = "./Tests/test_" + std::to_string(i);
    string testFile = testFolder + "/" + "testInput" + ".txt";
    string testExpectedFile = testFolder + "/" + "testExpected" + ".txt";

    // Creating Current Test Files  
    string createTestsFilesCommand = "mkdir " + testFolder + " && touch " + testFile;
    string got_createTestsFilesCommand  = GetStdoutFromCommand(createTestsFilesCommand );

    // Creating Test Input
    std::ofstream outInput(testFile);
    outInput << currentTestInput + "\nquitXV6\n";
    outInput.close();

    // Creating Test Expected
    std::ofstream outExpected(testExpectedFile);
    outExpected << processCompareString(currentTestExpected);
    outExpected.close();
  }

  return testsInputs.size();
}

// Signal handler for SIGINT
void sigintHandler(int num){
    abortExecution = 1;

    // Catching signal
    signal(SIGINT,sigintHandler);
}

// Processing test output
string processTestOutput(string output){
  // Serching for start of test code
  unsigned int inputStartPos = output.find("$",0);

  // Returning test code
  if(inputStartPos < output.length() && inputStartPos >= 0){
      return processCompareString(output.substr(inputStartPos,output.length())); 
  }
  else{
      return output;
  }
}

// Processing compare string, i.e removing spaces from edges
string processCompareString(string str){
    // Initializing
    int start = -1;
    int end = -1;

    // Retrieving location of first space from start
    for(unsigned int i = 0;i < str.length();i++){
      if(str.at(i) > 32){
        start = i;
        break;
      }
    }

    // Retrieving location of first space from end
    for(unsigned int i = str.length() - 1;i >= 0;i--){
      if(str.at(i) > 32){
        end = i;
        break;
      }
    }

    // Asserting there are spaces at the edegs and if so removing them
    if(start == -1 || end == -1){
      return str;
    }
    else{
      return str.substr(start,end - start + 1);
    }

}

// Creating XV6 Tests Makefile
void createXV6_TestMakefile(string makefilePath,vector<string> userspacePrograms){
    // Initializing
    string data;
    FILE * stream = fopen("../Makefile","r");
    const int max_buffer = 4000;
    char buffer[max_buffer];
    string xv6TestsBaseFolder = "XV6_Tests/";
    string xv6TestsQEMUFolder = "./Project_Test/" + xv6TestsBaseFolder;
    string userSpaceProgramMakeCode =  
  "_%: ulib.o usys.o printf.o umalloc.o\n" 
  "\tgcc -fno-pic -std=gnu99 -static -fno-builtin -fno-strict-aliasing -O2 -Wall -MD -ggdb -m32 -march=i686 -Werror -fno-omit-frame-pointer " 
  "\t-fno-stack-protector -fno-pie -no-pie -fno-pic -static " 
	"\t-fno-builtin -fno-strict-aliasing -O2 -Wall -MD -ggdb -m32 -march=i686 -Werror -fno-omit-frame-pointer -fno-stack-protector -fno-pie -no-pie  -c -o %.o #.c\n" 
 "\tld -m    elf_i386 -N -e main -Ttext 0 -o _% %.o ulib.o usys.o printf.o umalloc.o\n" 
	"\tobjdump -S _% > %.asm\n" 
	"\t$(OBJDUMP) -t _% | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > %.sym\n";

    // Reading project makefile and adding tests user space programs
    // while code is for telling the makefile to include these user space programs
    while (!feof(stream))
    { 
      // Reading line of test output
      if (fgets(buffer, max_buffer, stream) != NULL){
          if(strstr(buffer,"UPROGS=\\")){
              data.append("UPROGS=  " + processAppendMakefileUPROGS(userspacePrograms));
          }
          else{
              data.append(buffer);
          }
      }
     
    }

    // Adding build commands for each user space program
    for (vector<string>::iterator it = userspacePrograms.begin() ; it != userspacePrograms.end(); ++it){
      string temp = replaceInString(userSpaceProgramMakeCode,'%',*it) + "\n";
      data.append(replaceInString(temp,'#',xv6TestsQEMUFolder + *it));
    }
    
    // Creating Tests Makefile
    std::ofstream outMakefile(makefilePath);
    outMakefile << data;
    outMakefile.close();
}

// Processing user space programs and creating an entry for each one 
// inorder to take the makefile of the xv6 to include them
string processAppendMakefileUPROGS(vector<string> append){
    // Initializinh
    string result;

    // Creating entries
    for (vector<string>::iterator it = append.begin() ; it != append.end(); ++it){
      result.append("_" + *it + "\\\n");
    }

    return result;
}

// Replacing all occurences of toReplace char with replaceWith string in str
string replaceInString(string str,char toReplace,string replaceWith){
    // Initializing
    string result;

    // Replacing
    for (string::iterator it=str.begin(); it!=str.end(); ++it){
        if(*it == toReplace){
          result.append(replaceWith);
        }
        else{
          result.append(1,*it);
        }
    }

    return result;
}

// Finding number of occurences of substr in string
int countSubStr(string str,string findSubStr){
    // Initializing
    int occurrences = 0;
    string::size_type pos = 0;

    // Counting
    while ((pos = str.find(findSubStr, pos)) != std::string::npos) {
          ++occurrences;
          pos += findSubStr.length();
    }
   
   return occurrences;
}

// Executing Operating_System_Test
void Operating_System_Test()
{
  // Initializing
  currentTestName = "Operating_System_Test";
  char arr[50];
  memset(arr,' ',50);
  arr[50] = 0;
  int progress_index = 0;
  int progress;
  const char* no_error_progress = "\e[38;5;082m[%s]\e[38;5;226m%i%% %d/%d\r\e[0m";
  const char* yes_error_progress = "\e[38;5;082m[%s]\e[38;5;196m%i%% %d/%d\r\e[0m";

  // Creating Tests
  unsigned int numberOfTests = CreateTests();
  
  // Running specific test if demanded
  if(0 <=  testToExecute && ((unsigned int)testToExecute) < numberOfTests){
      runSpecificTest(testToExecute);
      return;
  }
  else if(testToExecute != -1){
      printf("Specific test request was out of bounds(%d)\n\n",testToExecute);
  }

  // Printing initial progress
  printf(no_error_progress,arr,0,0,numberOfTests);
  fflush(stdout);

  // Testing
  for(unsigned int i = 0;i < numberOfTests;i++)
  { 
    // Testing
    if(abortExecution == 0){
      procceseTest("test_" + std::to_string(i),i);
    }
    else{
      // Declaring test was aborted
      cout << RED << std::endl << "Operating System Test Was Aborted With " << i << " Tests Executed Out Of " << numberOfTests << " !!!" << RESET << std::endl;
      red = red + (numberOfTests - i);
      break;
    }

    float float_index = (float)(i + 1);
    progress = (float_index/numberOfTests) * 100;

    // Updating progress 
    if(progress > progress_index)
    { 
      progress_index += 1;
      memset(arr,'#',(int)((float_index/numberOfTests) * 50));
    }
    
    if(red == 0){
      printf(no_error_progress,arr,progress,i+1,numberOfTests);
    }
    else{
      printf(yes_error_progress,arr,progress,i+1,numberOfTests);
    }
    fflush(stdout);
  }
  
  // Cleaning after progress bar
  printf("%%\r                                                                          %%\r");
}
