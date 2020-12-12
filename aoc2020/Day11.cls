Class aoc2020.Day11 Extends aoc2020.Base
{

// https://adventofcode.com/2020/day/11

Parameter InputFile = "Day11Input.txt";

ClassMethod Run1(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)
    set columnCount = 0
    while 'stream.AtEnd{
        set columnCount = columnCount + 1
        set line = stream.ReadLine()

        for charCount=1:1:$LENGTH(line){
            set $LIST(seatLayout,*+1)= columnCount_"-"_charCount_"|"_$E(line,charCount,charCount)
        }
        w line,!
    }

    set updatedSeatLayout = ""
    set loopCount = 0
    WHILE 1 = 1{
        set loopCount = loopCount+1
        w "loopCount: ",loopCount
        //set seatLayout = updatedSeatLayout
        
        //Populate Seat Update List
        set seatUpdates = ""
        set ptr = 0
        WHILE $LISTNEXT(seatLayout,ptr,currentSeat){
            set seatCoordinates = $P(currentSeat,"|",1,1)
            set seatColumn = $P(seatCoordinates,"-",1,1)
            set seatRow = $P(seatCoordinates,"-",2,2)
            set seatValue = $P(currentSeat,"|",2,2)
            //w "seat Coordinates: ",seatCoordinates,!
            //w "seat Column: ",seatColumn,!
            //w "seat Row: ",seatRow,!
            //w "seat Value: ",seatValue,!

            set adjacentSeatsCoordinates = ..getAdjacentCoordinates(seatCoordinates)

            w "Adajcent Count For: ",seatCoordinates,!
            set adjacentSeatOccupiedCount = ..getOccupiedCount(adjacentSeatsCoordinates,seatLayout)
            //w adjacentSeatOccupiedCount,!

            if seatValue = "L"{
                if adjacentSeatOccupiedCount = 0{
                    set $LIST(seatUpdates,*+1)=seatCoordinates_"|"_"#"
                }
            }
            if seatValue = "#"{
                if adjacentSeatOccupiedCount >= 4{
                    set $LIST(seatUpdates,*+1)=seatCoordinates_"|"_"L"
                }
            }

            //w "seat: ",currentSeat,!
        }

        //d ..printSeatLayout(seatLayout)
        //w "Seat Changes: ",!
        //w $LISTTOSTRING(seatUpdates,"$"),!

        set updatedSeatLayout = seatLayout
        //d ..printSeatLayout(updatedSeatLayout)
        w "Hit Update Phase",!
        set ptr=0
        WHILE $LISTNEXT(seatUpdates,ptr,currentSeatUpdate){
            //d ..printSeatLayout(updatedSeatLayout)
            set currentSeatCoordinates = $P(currentSeatUpdate,"|",1,1)
            set currentSeatColumn = $P(currentSeatCoordinates,"-",1,1)
            set currentSeatRow = $P(currentSeatCoordinates,"-",2,2)
            set currentSeatValue = $P(currentSeatUpdate,"|",2,2)
            #; w "seat Coordinates: ",currentSeatCoordinates,!
            #; w "seat Column: ",currentSeatColumn,!
            #; w "seat Row: ",currentSeatRow,!
            #; w "seat Value: ",currentSeatValue,!


            for seatLayoutIndex=1:1:$LISTLENGTH(seatLayout){
                set currentLayoutSeat = $LIST(seatLayout,seatLayoutIndex)
                set currentLayoutSeatCoordinates = $P(currentLayoutSeat,"|",1,1)
                if currentLayoutSeatCoordinates = currentSeatCoordinates{
                    set $LIST(updatedSeatLayout,seatLayoutIndex) = currentSeatCoordinates_"|"_currentSeatValue
                }
            }

        }

        //w "Updated: ",!
        //d ..printSeatLayout(updatedSeatLayout)
        // w "Original: ",!
        // d ..printSeatLayout(seatLayout)

        if seatLayout = updatedSeatLayout{
            quit
        }else{
            set seatLayout = updatedSeatLayout
        }

    }

    set finalCount = 0
    for seatLayoutIndex=1:1:$LISTLENGTH(seatLayout){
        set currentSeat = $LIST(seatLayout,seatLayoutIndex)
        if $P(currentSeat,"|",2,2)="#"{
            set finalCount = finalCount + 1
        }
    }

    w "Final Count: ",finalCount
    return $$$OK
}

ClassMethod getAdjacentCoordinates(seatCoordinates As %String) As %String
{
    set returnCoords = ""
    set seatColumn = $P(seatCoordinates,"-",1,1)
    set seatRow = $P(seatCoordinates,"-",2,2)
    set $LIST(returnCoords,*+1) = (seatColumn-1)_"-"_(seatRow-1)
    set $LIST(returnCoords,*+1) = (seatColumn-1)_"-"_(seatRow)
    set $LIST(returnCoords,*+1) = (seatColumn-1)_"-"_(seatRow+1)

    set $LIST(returnCoords,*+1) = (seatColumn)_"-"_(seatRow-1)
    set $LIST(returnCoords,*+1) = (seatColumn)_"-"_(seatRow+1)

    set $LIST(returnCoords,*+1) = (seatColumn+1)_"-"_(seatRow-1)
    set $LIST(returnCoords,*+1) = (seatColumn+1)_"-"_(seatRow)
    set $LIST(returnCoords,*+1) = (seatColumn+1)_"-"_(seatRow+1)

    return returnCoords
}

ClassMethod getOccupiedCount(seatListCoordinates As %String, seatLayout As %String) As %String
{
    set count = 0
    set ptr=0
    WHILE $LISTNEXT(seatLayout,ptr,currentSeat){
        set seatCoordinates = $P(currentSeat,"|",1,1)
        set seatValue = $P(currentSeat,"|",2,2)

        set ptr2=0
        WHILE $LISTNEXT(seatListCoordinates,ptr2,currentAdajcentSeatCoordinates){
            if currentAdajcentSeatCoordinates = seatCoordinates{
                if seatValue = "#"{
                    set count = count + 1
                }
            }
        }
    }

    return count
}

ClassMethod printSeatLayout(seatLayout As %String)
{
    set currentColumn = 1
    set ptr = 0
    WHILE $LISTNEXT(seatLayout,ptr,currentSeat){
        if currentColumn '= $P(currentSeat,"-",1,1){
            set currentColumn = $P(currentSeat,"-",1,1)
            w !
        }
        w $P(currentSeat,"|",2,2)
    }
    w !,!
}

}
