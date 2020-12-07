Class aoc2020.DayOne Extends aoc2020.Base
{

Parameter InputFile = "Day1Input.txt";

ClassMethod Run(verbose = 0) As %Integer
{
    //Part 1
    set stream=..GetInput(..#InputFile)

    set $LIST(inputList,1) = stream.ReadLine()
    while 'stream.AtEnd{
        set currentLine = stream.ReadLine()
        set $LIST(inputList,$LISTLENGTH(inputList)+1) = currentLine
    }

    for firstNumIndex=1:1:$LISTLENGTH(inputList){
        set firstNum = $LISTGET(inputList,firstNumIndex)
        //w "firstNum: ",firstNum,!
        for secondNumIndex=1:1:$LISTLENGTH(inputList){
            set secondNum = $LISTGET(inputList,secondNumIndex)
            set sum = firstNum + secondNum
            if (firstNum+secondNum = 2020){
                set product = firstNum*secondNum
                    w "First Num: ",firstNum,!
                    w "Second Num: ",secondNum,!
                    w "Sum: ",sum,!
                    w "Product: ",product,!
                return product
            }
        }
    }
    return $$$OK
}

ClassMethod Run2(verbose = 0) As %Integer
{
    //Part 2
    set stream=..GetInput(..#InputFile)

    set $LIST(inputList,1) = stream.ReadLine()
     while 'stream.AtEnd{
         set currentLine = stream.ReadLine()
         set $LIST(inputList,$LISTLENGTH(inputList)+1) = currentLine
      }

    for firstNumIndex=1:1:$LISTLENGTH(inputList){
        set firstNum = $LISTGET(inputList,firstNumIndex)
        for secondNumIndex=1:1:$LISTLENGTH(inputList){
            set secondNum = $LISTGET(inputList,secondNumIndex)
            for thirdNumIndex=1:1:$LISTLENGTH(inputList){
                set thirdNum = $LISTGET(inputList,thirdNumIndex)
                set sum = firstNum + secondNum + thirdNum
                if (sum = 2020){
                    set product = firstNum*secondNum*thirdNum
                    w "First Num: ",firstNum,!
                    w "Second Num: ",secondNum,!
                    w "Third Num: ",thirdNum,!
                    w "Sum: ",sum,!
                    w "Product: ",product,!
                    return product
                }
            }
            
            
        }
    }
    return $$$OK
}

}
