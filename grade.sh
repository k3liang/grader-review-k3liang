CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

echo ""
echo "------------------------------"
submission="ListExamples.java"
file="student-submission/$submission"

if [[ -f $file ]]
then
    echo "FILE FOUND: $submission"
else
    if [[ `find student-submission -name $submission` != "" ]]
    then
        echo "FILE IN WRONG DIRECTORY: $submission"
        echo "------------------------------"
        exit 1
    else
        echo "ERROR: FILE NOT FOUND: $submission"
        echo "------------------------------"
        exit 1
    fi
fi

dir="grading-area"
cp TestListExamples.java $dir
cp $file $dir
cp -r lib $dir

cd $dir
javac -cp $CPATH *.java > out.txt 2>&1
if [[ $? != 0 ]]
then
    echo "COMPILE FAILURE: $submission"
    echo "------------------------------"
    exit 1
fi
echo "COMPILE SUCCESS: $submission"
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > out2.txt 2>&1

grep "Tests run" out2.txt > fails.txt
grep "OK" out2.txt > success.txt
grep "(TestListExamples)" out2.txt > methodfails.txt
echo "------------------------------"
echo "------------------------------"
echo "Score: "
if [[ `cat success.txt` != "" ]]
then
    echo "Passed All Tests!"
else
    cat fails.txt
    echo ""
    echo "Failed Tests: "
    cat methodfails.txt
fi
echo "------------------------------"
