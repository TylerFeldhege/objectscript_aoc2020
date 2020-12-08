Class aoc2020.Day5 Extends aoc2020.Base
{

Parameter InputFile = "Day5Input.txt";

ClassMethod Run1(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)
    set highestSeatID = 0

    while 'stream.AtEnd{
        set line = stream.ReadLine()

        set rowCode = $E(line,1,7)
        //w "rowCode: ",rowCode,!
        set lowerBound = 0
        set upperBound = 127

        for rowCodeIndex=1:1:$LENGTH(rowCode){
            set currentCode = $E(rowCode,rowCodeIndex,rowCodeIndex)
            //w "currentCode: ",currentCode,!
            set newRange = ..GetRange(lowerBound,upperBound,currentCode)
            set lowerBound = $P(newRange,"|",1,1)
            set upperBound = $P(newRange,"|",2,2)

        }
        set row = lowerBound
        //w "Row: ",row,!

        set columnCode = $E(line,8,10)
        //w "columnCode: ",columnCode,!

        set columnLowerBound = 0
        set columnUpperBound = 7

        for columnCodeIndex=1:1:$LENGTH(columnCode){
            set currentColumnCode = $E(columnCode,columnCodeIndex,columnCodeIndex)
            //w "currentColumnCode: ",currentColumnCode,!
            set newColumnRange = ..GetRange(columnLowerBound,columnUpperBound,currentColumnCode)
            set columnLowerBound = $P(newColumnRange,"|",1,1)
            set columnUpperBound = $P(newColumnRange,"|",2,2)
        }
        set column = columnLowerBound
        //w "Column: ",column,!
        
        set currentSeatID = (row * 8) + column
        //w "currentSeatID: ",currentSeatID,!
        w currentSeatID,!
        if currentSeatID > highestSeatID{
            set highestSeatID = currentSeatID
        }

        //w line,!
    }
    w "Highest Seat ID: ",highestSeatID,!
    return highestSeatID
}

ClassMethod GetRange(lowerBound As %String, upperBound As %String, direction As %String) As %String
{
    set difference = upperBound - lowerBound
    set differenceHalf = difference\2
    set lowerMiddle = lowerBound + differenceHalf
    set upperMiddle = upperBound - differenceHalf

    if ((direction = "F")||(direction = "L")){
        return lowerBound_"|"_lowerMiddle
    }
    if ((direction = "B")||(direction = "R")){
        return upperMiddle_"|"_upperBound
    }

    return 0
}

}
