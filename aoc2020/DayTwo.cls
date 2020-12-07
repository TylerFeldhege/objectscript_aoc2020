Class aoc2020.DayTwo Extends aoc2020.Base
{

// https://adventofcode.com/2020/day/2

Parameter InputFile = "Day2Input.txt";

ClassMethod Run1(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)
    set validCount = 0
    while 'stream.AtEnd{
        set line = stream.ReadLine()

        //Pull Variables
        set bounds = $P(line," ",1,1)
        set lowerBound = $P(bounds,"-",1,1)
        set upperBound = $P(bounds,"-",2,2)
        set ruleChar = $E($P(line," ",2,2),1,1)
        set passwordToCheck = $P(line," ",3,3)

        //Count Char
        set charCount = 0
        set numOfCharInPassword = $LENGTH(passwordToCheck)
        for charIndex=1:1:numOfCharInPassword{
            set currentChar = $E(passwordToCheck,charIndex,charIndex)
            if currentChar = ruleChar{
                set charCount = charCount + 1
            }
        }

        //Check Rule
        if ((charCount >= lowerBound)&&(charCount <= upperBound)){
            set validCount = validCount + 1
        }
    }
    w "Valid Count: ",validCount,!
    return validCount
}

ClassMethod Run2(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)
    set validCount = 0
    while 'stream.AtEnd{
        set line = stream.ReadLine()

        //Pull Variables
        set positions = $P(line," ",1,1)
        set firstPosition = $P(positions,"-",1,1)
        set secondPosition = $P(positions,"-",2,2)
        set ruleChar = $E($P(line," ",2,2),1,1)
        set passwordToCheck = $P(line," ",3,3)

        //Get Char's
        set firstChar = $E(passwordToCheck,firstPosition,firstPosition)
        set secondChar = $E(passwordToCheck,secondPosition,secondPosition)

        //Check Rules
        if ((firstChar = ruleChar) || (secondChar = ruleChar)){
            if (firstChar '= secondChar){
                set validCount = validCount + 1
            }
        }

    }

    w "Valid Count: ",validCount,!
    return validCount
}

}
