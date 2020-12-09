Class aoc2020.Day8 Extends aoc2020.Base
{

// https://adventofcode.com/2020/day/8

Parameter InputFile = "Day8Input.txt";

ClassMethod Run1(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)
    set commandList = ""

    while 'stream.AtEnd{
        set line = stream.ReadLine()
        set $LIST(commandList,*+1) = line
        //w line,!
    }
    set accumulator = 0
    set listOfRunCommands = ""
    //Set to 1 to start at top of list.
    set currentCommandIndex = 1

    while 1 = 1{
        set currentCommand = $LIST(commandList,currentCommandIndex)
        w "Process Command: ",currentCommandIndex,"-",currentCommand,!

        //If the command is a duplicate, exit the loop
        if $LISTFIND(listOfRunCommands,currentCommandIndex){
            w "Found Duplicate: ",currentCommandIndex,"-",currentCommand,!
            quit
        }else{
            set $LIST(listOfRunCommands,*+1) = currentCommandIndex
        }

        set currentCommandAction = $P(currentCommand," ",1,1)
        set currentCommandOffset = $P(currentCommand," ",2,2)
        set currentCommandOffsetDirection = $E(currentCommandOffset,1,1)
        set currentCommandOffsetNumber = $E(currentCommandOffset,2,$LENGTH(currentCommandOffset))
        if currentCommandAction = "nop"{
            set currentCommandIndex = currentCommandIndex + 1
        }
        if currentCommandAction = "jmp"{
            if currentCommandOffsetDirection = "+"{
                set currentCommandIndex = currentCommandIndex + currentCommandOffsetNumber
            }
            if currentCommandOffsetDirection = "-"{
                set currentCommandIndex = currentCommandIndex - currentCommandOffsetNumber
            }
        }
        if currentCommandAction = "acc"{
            if currentCommandOffsetDirection = "+"{
                set accumulator = accumulator + currentCommandOffsetNumber
            }
            if currentCommandOffsetDirection = "-"{
                set accumulator = accumulator - currentCommandOffsetNumber
            }
            set currentCommandIndex = currentCommandIndex + 1
        }

    }

    w "Final Accumulator Value :",accumulator,!
    return accumulator
}

ClassMethod Run2(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)
    set commandList = ""

    while 'stream.AtEnd{
        set line = stream.ReadLine()
        set $LIST(commandList,*+1) = line
        //w line,!
    }

    set numberOfCommands = $LISTLENGTH(commandList)
    set accumulator = 0
    set commandFlipped = 0
    set listOfRunCommands = ""
    set flippedCommands = ""
    //Set to 1 to start at top of list.
    set currentCommandIndex = 1

    while currentCommandIndex <= numberOfCommands{
        set currentCommand = $LIST(commandList,currentCommandIndex)
        //w "Process Command: ",currentCommandIndex,"-",currentCommand,!

        set $LIST(listOfRunCommands,*+1) = currentCommandIndex
        
        set currentCommandAction = $P(currentCommand," ",1,1)
        set currentCommandOffset = $P(currentCommand," ",2,2)
        set currentCommandOffsetDirection = $E(currentCommandOffset,1,1)
        set currentCommandOffsetNumber = $E(currentCommandOffset,2,$LENGTH(currentCommandOffset))
        if currentCommandAction = "nop"{
            if ((commandFlipped = 0)&&('$LISTFIND(flippedCommands,currentCommandIndex))){
                //w "Flipping Command: ",currentCommandIndex,"-",$LIST(commandList,currentCommandIndex),!
                //w "Previously Flipped Commands: ",$LISTTOSTRING(flippedCommands,"-"),!
                set commandFlipped = 1
                set commandFlippedIndex = currentCommandIndex
                set commandFlippedAccomulator = accumulator
                set commandFlippedRunCommandList = listOfRunCommands

                set $LIST(flippedCommands,*+1) = currentCommandIndex
                //JMP Logic
                if currentCommandOffsetDirection = "+"{
                    set currentCommandIndex = currentCommandIndex + currentCommandOffsetNumber
                }
                if currentCommandOffsetDirection = "-"{
                    set currentCommandIndex = currentCommandIndex - currentCommandOffsetNumber
                }
            }else{
                //Run nop Logic
                set currentCommandIndex = currentCommandIndex + 1
            }
        }
        if currentCommandAction = "jmp"{

            if ((commandFlipped = 0)&&('$LISTFIND(flippedCommands,currentCommandIndex))){
                //w "Flipping Command: ",currentCommandIndex,"-",$LIST(commandList,currentCommandIndex),!
                //w "Previously Flipped Commands: ",$LISTTOSTRING(flippedCommands,"-"),!
                set commandFlipped = 1
                set commandFlippedIndex = currentCommandIndex
                set commandFlippedAccomulator = accumulator
                set commandFlippedRunCommandList = listOfRunCommands

                set $LIST(flippedCommands,*+1) = currentCommandIndex
                //Run nop Logic
                set currentCommandIndex = currentCommandIndex + 1
            }else{
                //JMP Logic
                if currentCommandOffsetDirection = "+"{
                    set currentCommandIndex = currentCommandIndex + currentCommandOffsetNumber
                }
                if currentCommandOffsetDirection = "-"{
                    set currentCommandIndex = currentCommandIndex - currentCommandOffsetNumber
                }
            }
        }
        if currentCommandAction = "acc"{
            // ACC Logic
            if currentCommandOffsetDirection = "+"{
                set accumulator = accumulator + currentCommandOffsetNumber
            }
            if currentCommandOffsetDirection = "-"{
                set accumulator = accumulator - currentCommandOffsetNumber
            }
            set currentCommandIndex = currentCommandIndex + 1
        }

        //Check if next run is duplicate
        if $LISTFIND(listOfRunCommands,currentCommandIndex){
            //w "Reverting flipped command: ",commandFlippedIndex,"-",$LIST(commandList,commandFlippedIndex),!
            //w "Going back to : ",commandFlippedIndex,"-",$LIST(commandList,commandFlippedIndex),!,!
            set currentCommandIndex = commandFlippedIndex
            set accumulator = commandFlippedAccomulator
            set listOfRunCommands = commandFlippedRunCommandList
            set commandFlipped = 0
        }
        //w "Current Accumulator Value: ",accumulator,!
    }
    //w "Command List: ",$LISTTOSTRING(listOfRunCommands,"-"),!
    w "Final Accumulator Value :",accumulator,!
    return accumulator
}

}
