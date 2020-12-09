Class aoc2020.Day7 Extends aoc2020.Base
{

// https://adventofcode.com/2020/day/7

Parameter InputFile = "Day7Input.txt";

ClassMethod Run1(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)

    set ruleList = ""
    while 'stream.AtEnd{
        set line = stream.ReadLine()
        set $LIST(ruleList,*+1) = line
        //w line,!
    }
    set $LIST(ruleList,*+1) = line

    set $LIST(colorsToCheck,*+1) = "shiny gold"
    set checkedColors = ""

    set ptr = 0
    set currentColorIndex = 1
    set colorCount = $LISTLENGTH(colorsToCheck)
    WHILE currentColorIndex <= colorCount{
    //WHILE $LISTNEXT(colorsToCheck,ptr,currentColorToCheck){
        set currentColorToCheck = $LIST(colorsToCheck,currentColorIndex)
        w "Checking parents of ",currentColorToCheck,!
        set parentColors = ..findBagParents(ruleList,currentColorToCheck)
        set $LIST(checkedColors,*+1) = currentColorToCheck

        set ptr2 = 0
        WHILE $LISTNEXT(parentColors,ptr2,currentParentColor){
            w "Found Parent ",currentParentColor
            if (('$LISTFIND(checkedColors,currentParentColor))&&('$LISTFIND(colorsToCheck,currentParentColor))){
                w "Added Parents To Check List: ",currentParentColor,!
                set $LIST(colorsToCheck,*+1) = currentParentColor
            }
        }

        set currentColorIndex = currentColorIndex + 1
        set colorCount = $LISTLENGTH(colorsToCheck)
    }

    w "FINAL Parent Colors: ",$LISTTOSTRING(checkedColors,"-"),!
    // You need to subtract 1 because the starting color is considered a parent.
    set finalParentCount = $LISTLENGTH(checkedColors)-1
    w "FINAL Parent Count: ",finalParentCount,!


    return $$$OK
}

ClassMethod findBagParents(ruleList As %String, colorToCheck As %String) As %String
{
    set ptr = 0
    set colorsToReturn = ""
    WHILE $LISTNEXT(ruleList,ptr,currentRule){

        //w "Rule: ",currentRule,!
        set ruleParent = $PIECE(currentRule," ",1,2)
        //w "Rule Parent: ",ruleParent,!
        set ruleChildren = $PIECE(currentRule," contain ",2,2)
        //w "Rule Children: ",ruleChildren,!
        for childrenIndex=1:1:$LENGTH(ruleChildren,","){
            set currentChild = $P(ruleChildren,",",childrenIndex,childrenIndex)
            set currentChild = $ZSTRIP(currentChild,"<>W")
            set currentChild = $P(currentChild," ",2,3)

            //w "Rule Child: ",currentChild,!

            if currentChild = colorToCheck{
                //w "Found Match: ",currentChild,"=",colorToCheck,!                
                set $LIST(colorsToReturn,*+1)=ruleParent
            }
        }

        //w "Check Rule: ",currentRule,!
    }

    return colorsToReturn
}

ClassMethod Run2(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)

    set ruleList = ""
    while 'stream.AtEnd{
        set line = stream.ReadLine()
        set $LIST(ruleList,*+1) = line
        //w line,!
    }
    set $LIST(ruleList,*+1) = line

    set $LIST(childrenToCheck,*+1) = "1 shiny gold"

    set currentChildIndex = 1
    set currentChildCount = $LISTLENGTH(childrenToCheck)
    WHILE currentChildIndex <= currentChildCount{
        set currentChildToCheck = $LIST(childrenToCheck,currentChildIndex)
        w "Checking ",currentChildToCheck,!
        set currentChildToCheckMultiplier = $P(currentChildToCheck," ",1,1)
        set currentChildToCheckColor = $P(currentChildToCheck," ",2,3)

        set currentGrandChildren = ..findBagChildren(ruleList,currentChildToCheckColor)

        set ptr = 0
        WHILE $LISTNEXT(currentGrandChildren,ptr,currentGrandChild){
            //Update Count
            w "Found Grandchild: ",currentGrandChild,!
            set $P(currentGrandChild," ",1,1) = $P(currentGrandChild," ",1,1) * currentChildToCheckMultiplier
            w "Updated Grandchild: ",currentGrandChild,!
            set $LIST(childrenToCheck,*+1) = currentGrandChild
        }
        w "Updated Checked Children: ",$LISTTOSTRING(childrenToCheck,","),!
        set currentChildCount = $LISTLENGTH(childrenToCheck)
        set currentChildIndex = currentChildIndex + 1

    }

    set sum = 0
    //Loop the children and grab the counts
    set ptr=0
    WHILE $LISTNEXT(childrenToCheck,ptr,currentChild){
        set childNum = $P(currentChild," ",1,1)
        set sum = sum + childNum
    }

    //subtract 1 from the sum to account for the starting bag.
    set sum = sum - 1
    w "Sum: ",sum,!

    return $$$OK
}

ClassMethod findBagChildren(ruleList As %String, colorToCheck As %String) As %String
{
    set ptr = 0
    set colorsToReturn = ""
    WHILE $LISTNEXT(ruleList,ptr,currentRule){

        //w "Rule: ",currentRule,!
        set ruleParent = $PIECE(currentRule," ",1,2)
        //w "Rule Parent: ",ruleParent,!
        if ruleParent = colorToCheck{
            set ruleChildren = $PIECE(currentRule," contain ",2,2)
            //w "Rule Children: ",ruleChildren,!
            for childrenIndex=1:1:$LENGTH(ruleChildren,","){
                set currentChild = $P(ruleChildren,",",childrenIndex,childrenIndex)
                set currentChild = $ZSTRIP(currentChild,"<>W")
                set currentChild = $P(currentChild," ",1,3)
                if currentChild '= "no other bags."{
                    set $LIST(colorsToReturn,*+1) = currentChild
                }
            }
        }
    }

    return colorsToReturn
}

}
