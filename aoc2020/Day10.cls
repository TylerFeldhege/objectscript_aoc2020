Class aoc2020.Day10 Extends aoc2020.Base
{

// https://adventofcode.com/2020/day/10

Parameter InputFile = "Day10Input.txt";

ClassMethod Run1(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)

    set joltList = "" 
    while 'stream.AtEnd{
        set line = stream.ReadLine()
        set $LIST(joltList,*+1) = line
        w line,!
    }
    
    w "joltList: ",$LISTTOSTRING(joltList,"-"),!
 
    //Sorted List should start with 0
    set $LIST(sortedList,1) = 0
    //sort List lowest to biggest
    while $LISTLENGTH(joltList) > 0{
        set lowest = ..getLowestElement(joltList)
        //w "lowest: ",..getLowestElement(joltList),!
        set $LIST(joltList,$P(lowest,"-",1,1),$P(lowest,"-",1,1)) = ""
        set $LIST(sortedList,*+1) = $P(lowest,"-",2,2)
    }

    w "sorted List :",$LISTTOSTRING(sortedList,"-"),!

    set highestElement = $LIST(sortedList,*)+3
    w "highestElement :",highestElement,!
    set $LIST(sortedList,*+1) = highestElement

    set sum1 = 0
    set sum2 = 0
    set sum3 = 0

    for listIndex=1:1:$LISTLENGTH(sortedList){
        if listIndex '= $LISTLENGTH(sortedList){
            set firstJolt = $LIST(sortedList,listIndex)
            set secondJolt = $LIST(sortedList,listIndex+1)
            set difference = secondJolt - firstJolt
            w secondJolt,"-",firstJolt,"=",difference,!
            if difference = 1{
                set sum1 = sum1 + 1
            }
            if difference = 2{
                set sum2 = sum2 + 1
            }
            if difference = 3{
                set sum3 = sum3 + 1
            }

        }
    }

    w "Final Sum1 :",sum1,!
    w "Final Sum2 :",sum2,!
    w "Final Sum3 :",sum3,!
    set answer = sum1*sum3
    w "Answer: ",answer,!

    return answer
}

ClassMethod getLowestElement(list As %String) As %String
{
    set lowest = ""

    for listIndex=1:1:$LISTLENGTH(list){
        set currentListItem = $LIST(list,listIndex)
        if lowest = ""{
            set lowest = listIndex_"-"_currentListItem
        }
        if currentListItem < $P(lowest,"-",2,2){
            set lowest = listIndex_"-"_currentListItem
        }
    }
    return lowest
}

/// First attempt was trying to brute force this and hitting a memory limit. Below as Run2Brute()
/// After thinking it through, I got to this much faster and efficient solution.
/// Pretty proud of this one.
ClassMethod Run2(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)

    set joltList = "" 
    while 'stream.AtEnd{
        set line = stream.ReadLine()
        set $LIST(joltList,*+1) = line
        //w line,!
    }
    
    //w "joltList: ",$LISTTOSTRING(joltList,"-"),!
 
    //Sorted List should start with 0
    set $LIST(sortedList,1) = 0
    //sort List lowest to biggest
    while $LISTLENGTH(joltList) > 0{
        set lowest = ..getLowestElement(joltList)
        //w "lowest: ",..getLowestElement(joltList),!
        set $LIST(joltList,$P(lowest,"-",1,1),$P(lowest,"-",1,1)) = ""
        set $LIST(sortedList,*+1) = $P(lowest,"-",2,2)
    }

    //w "sorted List :",$LISTTOSTRING(sortedList,"-"),!

    set highestElement = $LIST(sortedList,*)+3
    set $LIST(sortedList,*+1) = highestElement
    //w "highestElement :",highestElement,!

    set $LIST(joltListWithCounts,*+1) = $LIST(sortedList,1)_"-"_1

    for sortedListIndex=2:1:$LISTLENGTH(sortedList){
        set currentJolt = $LIST(sortedList,sortedListIndex)
        //w "currentJolt: ",currentJolt,!
        set currentJoltCount = ..getStepCountToJolt(currentJolt,joltListWithCounts)
        //w "currentJoltCount: ",currentJolt_"-"_currentJoltCount,!
        set $LIST(joltListWithCounts,*+1) = currentJolt_"-"_currentJoltCount
    }

    set finalJoltWithCount = $LIST(joltListWithCounts,*)
    set finalJoltCount = $P(finalJoltWithCount,"-",2,2)
    w "Count: ",finalJoltCount
    return finalJoltCount
}

ClassMethod getStepCountToJolt(jolt As %String, joltListWithCounts As %String) As %String
{
    set stepCount = 0
    set ptr=0
    WHILE $LISTNEXT(joltListWithCounts,ptr,joltWithCount){
        set difference = jolt - $P(joltWithCount,"-",1,1)
        //w jolt,"-",$P(joltListWithCounts,"-",1,1),"=",difference,!
        if ((difference >= 1) && (difference <=3)){
            set stepCount = stepCount + $P(joltWithCount,"-",2,2)
        }
    }
    return stepCount
}

/// BRUTE FORCE SOLUTION. Hits memory limit on big input
ClassMethod Run2Brute(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)

    set joltList = "" 
    while 'stream.AtEnd{
        set line = stream.ReadLine()
        set $LIST(joltList,*+1) = line
        w line,!
    }
    
    w "joltList: ",$LISTTOSTRING(joltList,"-"),!
 
    //Sorted List should start with 0
    set $LIST(sortedList,1) = 0
    //sort List lowest to biggest
    while $LISTLENGTH(joltList) > 0{
        set lowest = ..getLowestElement(joltList)
        //w "lowest: ",..getLowestElement(joltList),!
        set $LIST(joltList,$P(lowest,"-",1,1),$P(lowest,"-",1,1)) = ""
        set $LIST(sortedList,*+1) = $P(lowest,"-",2,2)
    }

    w "sorted List :",$LISTTOSTRING(sortedList,"-"),!

    set highestElement = $LIST(sortedList,*)+3
    w "highestElement :",highestElement,!
    set $LIST(sortedList,*+1) = highestElement


    set $LIST(currentSolution,1) = 0
    set $LIST(currentSolutionList,1) = currentSolution
    set solutionsAdded = 1
    While solutionsAdded > 0{
        set solutionsAdded = 0

        #; w "Current Solutions: Before",!
        #; set ptr2=0
        #; WHILE $LISTNEXT(currentSolutionList,ptr2,curSolution){
        #;     w $LISTTOSTRING(curSolution,"-"),!
        #; }

        set updatedSolutionList = currentSolutionList
        set ptr= 0
        WHILE $LISTNEXT(currentSolutionList,ptr,currentSolution){

            if $LIST(currentSolution,*) '= highestElement{

                set lastJolt = $LIST(currentSolution,*)
                set nextJolts = ..getPossibleNextJolt(lastJolt,sortedList)
                set ptr2=0
                WHILE $LISTNEXT(nextJolts,ptr2,nextJolt){
                    if $LISTFIND(updatedSolutionList,currentSolution){
                        set $LIST(updatedSolutionList,$LISTFIND(updatedSolutionList,currentSolution),$LISTFIND(updatedSolutionList,currentSolution)) = ""
                    }
                    if nextJolt '= ""{
                        set nextJoltSolution = currentSolution
                        set $LIST(nextJoltSolution,*+1) = nextJolt

                        if '$LISTFIND(updatedSolutionList,nextJoltSolution){
                            set $LIST(updatedSolutionList,*+1) = nextJoltSolution
                            set solutionsAdded = 1
                        }
                    }
                }
            }
        }

        set currentSolutionList = updatedSolutionList

        set finalSolutionCount = 0
        set ptr=0
        WHILE $LISTNEXT(currentSolutionList,ptr,curSolution){
            if $LIST(curSolution,*) = highestElement{
                set finalSolutionCount = finalSolutionCount + 1
                w $LISTTOSTRING(curSolution,"-"),!
            }
        }

        w "Solution Count: ",finalSolutionCount,!
            //Loop Current Solutions
        #; w "Current Solutions: ",!
        #; set ptr2=0
        #; WHILE $LISTNEXT(currentSolutionList,ptr2,curSolution){
        #;     w $LISTTOSTRING(curSolution,"-"),!
        #; }
    }

    w "FINAL",!,!,!
    //Loop Current Solutions
    w "Current Solutions: ",!
    set finalSolutionCount = 0
    set ptr=0
    WHILE $LISTNEXT(currentSolutionList,ptr,curSolution){
        if $LIST(curSolution,*) = highestElement{
            set finalSolutionCount = finalSolutionCount + 1
            w $LISTTOSTRING(curSolution,"-"),!
        }
    }

    w "Final Final Solution Count: ",finalSolutionCount,!
    
    quit $$$OK
}

ClassMethod getPossibleNextJolt(currentJolt As %String, joltList As %String) As %String
{
    set returnList = ""
    set ptr = 0
    WHILE $LISTNEXT(joltList,ptr,listJolt){
        set difference = listJolt - currentJolt
        //w listJolt,"-",currentJolt,"=",difference,!
        if ((difference>=1)&&(difference<=3)){
            set $LIST(returnList,*+1) = listJolt
        }
    }
    return returnList
}

}
