CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

echo ""
echo "------------------------------"
file=`find student-submission -name "ListExamples.java"`
if [[ -f $file ]]
then
    echo "FILE FOUND: ListExamples.java"
else
    echo "ERROR: FILE NOT FOUND: ListExamples.java"
    echo "------------------------------"
    exit 1
fi

cp TestListExamples.java grading-area
cp $file grading-area

# cd grading-area
dir="grading-area"
javac -cp $CPATH $dir/*.java > $dir/out.txt 2>&1
if [[ $? != 0 ]]
then
    echo "COMPILE FAILURE: ListExamples.java"
    cat $dir/out.txt
    echo "------------------------------"
    exit 1
fi
echo "COMPILE SUCCESS: ListExamples.java"
java -cp "$dir;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" org.junit.runner.JUnitCore TestListExamples > $dir/out2.txt 2>&1

grep "Tests run" $dir/out2.txt > $dir/fails.txt
grep "OK" $dir/out2.txt > $dir/success.txt
grep "(TestListExamples)" $dir/out2.txt > $dir/methodfails.txt
echo "------------------------------"
echo "------------------------------"
echo "Score: "
cat $dir/success.txt
cat $dir/fails.txt
echo ""
echo "Failed Tests: "
cat $dir/methodfails.txt
echo "------------------------------"

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
