Class aoc2020.Base
{

Parameter Folder = "/irisdev/app/src/aoc2020/Files/";

ClassMethod GetInput(fn) As %Stream
{
   
    set fn=..#Folder_fn
    set stream = ##Class(%Stream.FileCharacter).%New()
    set sc=stream.LinkToFile(fn)
    return stream
}

}
