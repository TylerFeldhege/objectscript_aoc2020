Class aoc2020.Day4 Extends aoc2020.Base
{

Parameter InputFile = "Day4Input.txt";

ClassMethod Run1(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)

    set currentPassport = ""
    
    set keyCount = 0
    while 'stream.AtEnd{
        set line = stream.ReadLine()

        set currentPassport = currentPassport_" "_line
        set keyCheck = 1
        if line = ""{
            w currentPassport,!

            set check1 = ..CheckPassportData(currentPassport,"byr")
            set check2 = ..CheckPassportData(currentPassport,"iyr")
            set check3 = ..CheckPassportData(currentPassport,"eyr")
            set check4 = ..CheckPassportData(currentPassport,"hgt")
            set check5 = ..CheckPassportData(currentPassport,"hcl")
            set check6 = ..CheckPassportData(currentPassport,"ecl")
            set check7 = ..CheckPassportData(currentPassport,"pid")
            set check8 = ..CheckPassportData(currentPassport,"cid")

            if (check1 && check2 && check3 && check4 && check5 && check6 && check7){
                set keyCount = keyCount + 1
            }
            
            set currentPassport = ""

        }
    }

    #; set keyCheck = 1
    w currentPassport,!

    //Check Passport
    set check1 = ..CheckPassportData(currentPassport,"byr")
    set check2 = ..CheckPassportData(currentPassport,"iyr")
    set check3 = ..CheckPassportData(currentPassport,"eyr")
    set check4 = ..CheckPassportData(currentPassport,"hgt")
    set check5 = ..CheckPassportData(currentPassport,"hcl")
    set check6 = ..CheckPassportData(currentPassport,"ecl")
    set check7 = ..CheckPassportData(currentPassport,"pid")
    set check8 = ..CheckPassportData(currentPassport,"cid")

    if (check1 && check2 && check3 && check4 && check5 && check6 && check7){
        set keyCount = keyCount + 1
    }
            
    w "Key Count: ",keyCount,!

    return $$$OK
}

ClassMethod CheckPassportData(passport As %String, keyToCheck As %String) As %String
{
    //return "Tyler"
    for fieldIndex=1:1:$LENGTH(passport," "){
        set currentField = $P(passport," ",fieldIndex,fieldIndex)
        set currentFieldKey = $P(currentField,":",1,1)
        if currentFieldKey = keyToCheck{
            return 1
        }
    }
    return 0
}

ClassMethod Run1test(verbose = 0) As %Integer
{
    set stream=..GetInput(..#InputFile)

    set currentPassport = ""
    
    set keyCount = 0
    while 'stream.AtEnd{
        set line = stream.ReadLine()

        set currentPassport = currentPassport_" "_line
        set keyCheck = 1
        if line = ""{
            w currentPassport,!

            //Check Passport
            set keysToCheck = "byr,iyr,eyr,hgt,hcl,ecl,pid"
            for keyIndex=1:1:$LENGTH(keysToCheck,","){
                set currentKey = $P(keysToCheck,",",keyIndex,keyIndex)
                w "Current Key: ",currentKey,!
                set check = ..CheckPassportData(currentPassport,currentKey)
                w "Check Value: ",check,!
                if check = 1{
                    set keyCheck = 0
                }
            }
            
            if keyCheck = 0{
                set keyCount = keyCount + 1
            }
            
            set currentPassport = ""

        }
    }

    #; set keyCheck = 1
    w currentPassport,!

    //Check Passport
    set keysToCheck = "byr,iyr,eyr,hgt,hcl,ecl,pid"
    for keyIndex=1:1:$LENGTH(keysToCheck,","){
        set currentKey = $P(keysToCheck,",",keyIndex,keyIndex)
        w "Current Key: ",currentKey,!
        set check = ..CheckPassportData(currentPassport,currentKey)
        w "Check Value: ",check,!
        if check = 0{
            set keyCheck = 0
        }
    }
            
    if keyCheck = 1{
        set keyCount = keyCount + 1
    }

    w "Key Count: ",keyCount,!

    return $$$OK
}

}
