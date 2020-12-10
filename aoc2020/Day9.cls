Class aoc2020.Day9 Extends aoc2020.Base
{

// https://adventofcode.com/2020/day/9

Parameter InputFile = "Day9Input.txt";

ClassMethod Run1(verbose = 0) As %String
{
    set stream=..GetInput(..#InputFile)

    set preamble = 25

    set numList = ""
    while 'stream.AtEnd{
        set line = stream.ReadLine()
        set $LIST(numList,*+1) = line
        //w line,!
    }

    //set ptr = 0
    //WHILE $LISTNEXT(numList,ptr,currentNum){
    for numIndex=preamble+1:1:$LISTLENGTH(numList){
        set currentNum = $LIST(numList,numIndex)
        //w "Checking : ",numIndex,"-",currentNum,!

        set pastNumbers = ..GetPastXNumbers(numList,numIndex,preamble)
        //w "Past Numbers: ",$LISTTOSTRING(pastNumbers,"-"),!
        if '(..CheckSum(pastNumbers,currentNum)){
            //w "num not found: ",currentNum,!
            return currentNum
        }
        //w "current Num: ",currentNum,!
    }

    #; set startingIndex = 9
    #; set returned = ..GetPastXNumbers(numList,startingIndex,preamble)
    #; w "returned List: ",$LISTTOSTRING(returned,"-"),!
    #; w "CheckSum: ",..CheckSum(returned,"87"),!
    return $$$OK
}

ClassMethod GetPastXNumbers(numList As %String, lastIndex As %String, preamble As %String) As %String
{
    set returnList = ""

    for i=lastIndex-preamble:1:lastIndex-1{
        //w "i: ",i,!
        set $LIST(returnList,*+1) = $LIST(numList,i)
    }
    return returnList
}

ClassMethod CheckSum(numbersToCheck As %String, sum As %String) As %String
{
    
    for x=1:1:$LISTLENGTH(numbersToCheck){
        //w "x: ",x,!
        set currentXNumber = $LIST(numbersToCheck,x)
        //w "currentXNumber: ",currentXNumber,!
        
        for y=1:1:$LISTLENGTH(numbersToCheck){
            if y '= x{
                set currentYNumber = $LIST(numbersToCheck,y)
                //w "Current Sum: ",currentXNumber,"+",currentYNumber,"=",currentXNumber+currentYNumber,!
                if (currentXNumber+currentYNumber)=sum{
                    return 1
                }
            }
        }
    }
 

    return 0
}

ClassMethod Run2(verbose = 0) As %String
{
    set stream=..GetInput(..#InputFile)

    set sumToLookFor = ..Run1()
    w "SumToLookFor: ",sumToLookFor,!


    set numList = ""
    while 'stream.AtEnd{
        set line = stream.ReadLine()
        set $LIST(numList,*+1) = line
        //w line,!
    }

    for numIndex=1+1:1:$LISTLENGTH(numList){
        set sum = $LIST(numList,numIndex)
        set sumCheck = sum
        set sumCheckList = ""
        set $LIST(sumCheckList,*+1) = sum
        for numIndex2=numIndex+1:1:$LISTLENGTH(numList){
            set sum = sum + $LIST(numList,numIndex2)
            set sumCheck = sumCheck_"+"_$LIST(numList,numIndex2)
            set $LIST(sumCheckList,*+1) = $LIST(numList,numIndex2)

            if sum = sumToLookFor{
                //w "sumCheck: :",sumCheck,!
                //w "sumCheckList : ",$LISTTOSTRING(sumCheckList,"-"),!

                //Find Smallest
                set smallest = ""
                set biggest = ""
                set ptr=0
                WHILE $LISTNEXT(sumCheckList,ptr,currentNum){
                    if smallest=""{
                        set smallest = currentNum
                    }else{
                        if currentNum < smallest{
                            set smallest = currentNum
                        }
                    }

                    if biggest=""{
                        set biggest = currentNum
                    }else{
                        if currentNum > biggest{
                            set biggest = currentNum
                        }
                    }
                }
                //w "smallest: ",smallest,!
                //w "biggest: ",biggest,!
                w "Sum: ",smallest+biggest,!

                return smallest+biggest
            }
        }
    }

    return "NOT FOUND"
}

}
