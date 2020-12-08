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
    //w line,!
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

        //w line,!
    }

    w "tree Count: ",treeCount,!
    return treeCount
}

ClassMethod Run2(verbose = 0) As %Integer
{
    
    set treeproduct = 1

    set scenario1 = "1,1"
    set scenario2 = "3,1"
    set scenario3 = "5,1"
    set scenario4 = "7,1"
    set scenario5 = "1,2"
    set scenarioList = scenario1_"|"_scenario2_"|"_scenario3_"|"_scenario4_"|"_scenario5

    for scenarioIndex=1:1:$LENGTH(scenarioList,"|"){
        //clear stream
        set stream = ""
        set currentScenario = $P(scenarioList,"|",scenarioIndex,scenarioIndex)
        set rightBound = $P(currentScenario,",",1,1)
        set downBound = $P(currentScenario,",",2,2)

        //w "Scenario "_scenarioIndex_": R"_rightBound_"D"_downBound,!
        set treeCount = 0
    
        set currentPos = 1

        //skip first line
        set stream=..GetInput(..#InputFile)

        set currentDownCount = downBound

        set line = stream.ReadLine()
        // w line,!
        while 'stream.AtEnd{
            
            if (currentDownCount > 1){
                set currentDownCount = currentDownCount - 1
                set line = stream.ReadLine()
                //w line,!
            }else{
                set line = stream.ReadLine()

                //Check Length of line. Expand if won't meet max width needed
                set currentPos = currentPos + rightBound
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

                //w line,!
                set currentDownCount = downBound
            }
            
    }

    //w "tree Count: ",treeCount,!
    set treeproduct = treeproduct * treeCount
   
    }
     w "tree Product: ",treeproduct,!
    return treeproduct
}

}
