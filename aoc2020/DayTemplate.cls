Class aoc2020.DayTemplate Extends aoc2020.Base
{

Parameter InputFile = "Day1Input.txt";

ClassMethod Run(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)

    while 'stream.AtEnd{
        set line = stream.ReadLine()

        w line,!
    }
    return $$$OK
}

}
