Class aoc2020.DayThree Extends aoc2020.Base
{

Parameter InputFile = "Day3Input.txt";

ClassMethod Run1(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)
    
    set treeCount = 0
    
    set currentPos = 1

    //skip first line
    set line = stream.ReadLine()
    w line,!
    while 'stream.AtEnd{
        set line = stream.ReadLine()

        //Check Length of line. Expand if won't meet max width needed
        set currentPos = currentPos + 3
        while ($LENGTH(line) < currentPos){ 
            set line = line_line
        }

        //Check if any of next 3 positions is a tree
        set slopeSpot = $E(line,currentPos)

        if slopeSpot = "."{
            s $E(line,currentPos)="O"
        }
        if slopeSpot = "#"{
            set treeCount = treeCount + 1
            s $E(line,currentPos)="X"
        }

        w line,!
    }

    w "tree Count: ",treeCount,!
    return treeCount
}

}
