Class aoc2020.Day6 Extends aoc2020.Base
{

// https://adventofcode.com/2020/day/6

Parameter InputFile = "Day6Input.txt";

ClassMethod Run1(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)
    
    // Group Answers 
    set currentAnswers = ""
    while 'stream.AtEnd{
        set line = stream.ReadLine()
        if line = ""{
            set $LIST(answerList,*+1) = currentAnswers
            //w currentAnswers,!
            set currentAnswers = ""
        }else{
            set currentAnswers = currentAnswers_line
        }
        //w line,!
    }
    //Handle last line
    set $LIST(answerList,*+1) = currentAnswers

    set uniqueAnswerList = ""
    set sum = 0
    set ptr=0
    WHILE $LISTNEXT(answerList,ptr,value){
        for charIndex=1:1:$LENGTH(value){
            set currentChar = $E(value,charIndex,charIndex)
            if '$LISTFIND(uniqueAnswerList,currentChar) {
                set $LIST(uniqueAnswerList,*+1) = currentChar
            }          
        }
        //w "Answer: ",value,!
        //w "Unique : ",$LISTTOSTRING(uniqueAnswerList),!
        set sum = sum + $LISTLENGTH(uniqueAnswerList)
        //w "current Sum: ",sum,!
        set uniqueAnswerList = ""
    }
    w "Sum: ",sum,!
    return sum
}

}
