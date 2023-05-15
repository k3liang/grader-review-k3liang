CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

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
    if [[ -f `find student-submission -name $submission` ]]
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

javac -cp $CPATH $dir/*.java > $dir/out.txt 2>&1
if [[ $? != 0 ]]
then
    echo "COMPILE FAILURE: $submission"
    echo "------------------------------"
    exit 1
fi
echo "COMPILE SUCCESS: $submission"
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
