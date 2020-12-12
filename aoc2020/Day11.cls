Class aoc2020.Day11 Extends aoc2020.Base
{

// https://adventofcode.com/2020/day/11

Parameter InputFile = "Day11Input.txt";

ClassMethod Run1(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)
    set rowCount = 0
    while 'stream.AtEnd{
        set rowCount = rowCount + 1
        set line = stream.ReadLine()
        set currentRowList = ""

        for charCount=1:1:$LENGTH(line){
            set $LIST(currentRowList,charCount)= $E(line,charCount,charCount)
        }

        set $LIST(seatLayout,rowCount) = currentRowList
        //w line,!
    }
    w "Starting Layout: ",!
    d ..printSeatLayout(seatLayout)


    While 1=1{
        set updateList = ""
        //Loop through each seat, and find updates
        for rowIndex=1:1:$LISTLENGTH(seatLayout){
            set currentRowList = $LIST(seatLayout,rowIndex)
            for columnIndex=1:1:$LISTLENGTH(currentRowList){
                set currentSeatValue = $LIST(currentRowList,columnIndex)
                set adajcentSeats = ..getAdjacentCoordinates(rowIndex,columnIndex)
                set occCount = ..getOccupiedCount(adajcentSeats,seatLayout)

                if ((currentSeatValue = "L")&&(occCount = "0")){
                    set $LIST(updateList,*+1) = rowIndex_"-"_columnIndex_"|"_"#"
                }
                if ((currentSeatValue = "#")&&(occCount >= 4)){
                    set $LIST(updateList,*+1) = rowIndex_"-"_columnIndex_"|"_"L"
                }
            }
        }

        w "Updates: ",!
        w $LISTTOSTRING(updateList," "),!
        set updatedSeatLayout = seatLayout
        //Apply Updates
        set ptr=0
        WHILE $LISTNEXT(updateList,ptr,currentUpdate){
            set updateCoord = $P(currentUpdate,"|",1,1)
            set updateRow = $P(updateCoord,"-",1,1)
            set updateColumn = $P(updateCoord,"-",2,2)
            set updateValue = $P(currentUpdate,"|",2,2)
            set updateRowList = $LIST(updatedSeatLayout,updateRow)
            set $LIST(updateRowList,updateColumn) = updateValue
            set $LIST(updatedSeatLayout,updateRow) = updateRowList
        }

        w "Updated Layout:",!
        d ..printSeatLayout(updatedSeatLayout)


        if updatedSeatLayout = seatLayout{
            quit
        }else{
            set seatLayout = updatedSeatLayout
        }

    }

    //Count Occupied Seats
    set sum = 0
    for ptr=0
    WHILE $LISTNEXT(seatLayout,ptr,currentRowList){
        set ptr2=0
        WHILE $LISTNEXT(currentRowList,ptr2,currentSeat){
            if currentSeat = "#"{
                set sum = sum + 1
            }
        }
    }

    w "Final Sum: ",sum,!
    quit sum
}

ClassMethod getAdjacentCoordinates(seatRow As %String, seatColumn As %String) As %String
{
    set returnCoords = ""
    set $LIST(returnCoords,*+1) = (seatRow-1)_"-"_(seatColumn-1)
    set $LIST(returnCoords,*+1) = (seatRow-1)_"-"_(seatColumn)
    set $LIST(returnCoords,*+1) = (seatRow-1)_"-"_(seatColumn+1)

    set $LIST(returnCoords,*+1) = (seatRow)_"-"_(seatColumn-1)
    set $LIST(returnCoords,*+1) = (seatRow)_"-"_(seatColumn+1)

    set $LIST(returnCoords,*+1) = (seatRow+1)_"-"_(seatColumn-1)
    set $LIST(returnCoords,*+1) = (seatRow+1)_"-"_(seatColumn)
    set $LIST(returnCoords,*+1) = (seatRow+1)_"-"_(seatColumn+1)

    return returnCoords
}

ClassMethod getOccupiedCount(seatListCoordinates As %String, seatLayout As %String) As %String
{
    set count = 0
    set ptr=0
    WHILE $LISTNEXT(seatListCoordinates,ptr,currentCoordinate){
        set seatRow = $P(currentCoordinate,"-",1,1)
        set seatColumn = $P(currentCoordinate,"-",2,2)
        //w "Occupied Check Coord: ",seatRow,"-",seatColumn,!

        if ((1<=seatRow)&&($LISTLENGTH(seatLayout)>=seatRow)){
            set layoutRow = $LIST(seatLayout,seatRow)
            if ((1<=seatColumn)&&($LISTLENGTH(layoutRow)>=seatColumn)){
                set layoutValue = $LIST(layoutRow,seatColumn)
                //w "Layout Value: ",layoutValue,!
                if layoutValue = "#"{
                    set count = count + 1
                }
            }
        }
    }

    return count
}

ClassMethod printSeatLayout(seatLayout As %String)
{
    for rowIndex=1:1:$LISTLENGTH(seatLayout){
        set currentRowList = $LIST(seatLayout,rowIndex)
        w $LISTTOSTRING(currentRowList,"")
        #; for columnIndex=1:1:currentRowList{
        #;     w $LIST(currentRowList,columnIndex)
        #; }
        w !
    }
    w !
}

}
