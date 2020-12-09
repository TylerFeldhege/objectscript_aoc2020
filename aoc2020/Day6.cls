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

ClassMethod Run2(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)
    
    // Group Answers 
    set currentAnswers = ""
    while 'stream.AtEnd{
        set line = stream.ReadLine()
        if line = ""{
            //w "single answer List: ",$LISTTOSTRING(singleAnswerList,"$"),!
            set $LIST(groupAnswerList,*+1) = singleAnswerList
            set singleAnswerList = ""
            //w currentAnswers,!
        }else{
            set $LIST(singleAnswerList,*+1) = line

            #; if currentAnswers = ""{
            #;     set currentAnswers = line
            #; }else{
            #;     set currentAnswers = currentAnswers_"|"_line
            #; }
        }
        //w line,!
    }
    //Handle last line
    set $LIST(groupAnswerList,*+1) = singleAnswerList
    

    //For Each Group
    //  For Each Answer
    //    For Each Character
    //      For Each Answer
    //        Check if Character is contained.

    set groupCheckedAnswers = ""
    set sum = 0
    set uniqueAnswerList = ""

    //For Each Answer Group
    set ptr=0
    while $LISTNEXT(groupAnswerList,ptr,groupAnswer){
        //w "Checking Group: ",$LISTTOSTRING(groupAnswer,"$"),!
        //For Each Answer in the Answer Group
        set ptr2=0
        while $LISTNEXT(groupAnswer,ptr2,singleAnswer){
            //w "Single Answer: ",singleAnswer,!
            //For Each Char in the Answer in the Answer Group
            for ansCharIndex=1:1:$LENGTH(singleAnswer){
                set ansChar = $E(singleAnswer,ansCharIndex,ansCharIndex)
                //w "Single Char: ",ansChar,!

                set singleCharFound = 1
                //Loop each Answer in the Group
                set ptr3=0
                while $LISTNEXT(groupAnswer,ptr3,singleAnswerToCheck){
                    //w "Checking Answer :",singleAnswerToCheck," FOR: ",ansChar,!
                    if '##class(Ens.Util.FunctionSet).Contains(singleAnswerToCheck,ansChar){
                        set singleCharFound = 0
                        //w "Did Not Find Characer : ",ansChar, " in ",singleAnswerToCheck,!
                    }else{
                        //w "Found Char : ",ansChar," in ",singleAnswerToCheck,!
                    }
                }

                if singleCharFound{
                    if '$LISTFIND(uniqueAnswerList,ansChar){
                        //w "Adding to Unique List: ",ansChar,!
                        set $LIST(uniqueAnswerList,*+1) = ansChar
                    }   
                }
                //For each char.  Verify each answer in the group contains the Char.

            }
        }

        //w "Found Unique Answers :",$LISTTOSTRING(uniqueAnswerList,""),!
        set sum = sum + $LISTLENGTH(uniqueAnswerList)
        //w "Current Sum: ",sum,!
        set uniqueAnswerList = ""
    }
    w "Final Sum: ",sum,!
    return sum
}

}
