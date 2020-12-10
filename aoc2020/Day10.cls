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


    return $$$OK


    for listIndex=1:1:$LISTLENGTH(joltList){

    }

    w "joltList: ",$LISTTOSTRING(joltList,"-"),!
    set lowest = ..getLowestElement(joltList)
    w "lowest: ",..getLowestElement(joltList),!
    set $LIST(joltList,$P(lowest,"-",1,1),$P(lowest,"-",1,1)) = ""
    set lowest = ..getLowestElement(joltList)
    w "lowest: ",..getLowestElement(joltList),!
    
    return $$$OK
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

}
