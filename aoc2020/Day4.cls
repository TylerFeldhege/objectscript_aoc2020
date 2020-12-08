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

ClassMethod Run2(verbose = 0) As %Integer
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

            set check1 = ..CheckPassportDataPart2(currentPassport,"byr")
            set check2 = ..CheckPassportDataPart2(currentPassport,"iyr")
            set check3 = ..CheckPassportDataPart2(currentPassport,"eyr")
            set check4 = ..CheckPassportDataPart2(currentPassport,"hgt")
            set check5 = ..CheckPassportDataPart2(currentPassport,"hcl")
            set check6 = ..CheckPassportDataPart2(currentPassport,"ecl")
            set check7 = ..CheckPassportDataPart2(currentPassport,"pid")
            set check8 = ..CheckPassportDataPart2(currentPassport,"cid")

            if (check1 && check2 && check3 && check4 && check5 && check6 && check7){
                set keyCount = keyCount + 1
            }
            
            set currentPassport = ""

        }
    }

    #; set keyCheck = 1
    w currentPassport,!

    //Check Passport
    set check1 = ..CheckPassportDataPart2(currentPassport,"byr")
    set check2 = ..CheckPassportDataPart2(currentPassport,"iyr")
    set check3 = ..CheckPassportDataPart2(currentPassport,"eyr")
    set check4 = ..CheckPassportDataPart2(currentPassport,"hgt")
    set check5 = ..CheckPassportDataPart2(currentPassport,"hcl")
    set check6 = ..CheckPassportDataPart2(currentPassport,"ecl")
    set check7 = ..CheckPassportDataPart2(currentPassport,"pid")
    set check8 = ..CheckPassportDataPart2(currentPassport,"cid")

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

ClassMethod CheckPassportDataPart2(passport As %String, keyToCheck As %String) As %String
{
    //return "Tyler"
    for fieldIndex=1:1:$LENGTH(passport," "){
        set currentField = $P(passport," ",fieldIndex,fieldIndex)
        set currentFieldKey = $P(currentField,":",1,1)
        if currentFieldKey = keyToCheck{
            set currentFieldValue = $P(currentField,":",2,2)

            if currentFieldKey = "byr"{
                if ((currentFieldValue >= "1920" )&&(currentFieldValue <= "2002")&&($LENGTH(currentFieldValue)="4")){
                    return 1
                }else{
                    return 0
                }
            }

            if currentFieldKey = "iyr"{
                if ((currentFieldValue >= "2010" )&&(currentFieldValue <= "2020")&&($LENGTH(currentFieldValue)="4")){
                    return 1
                }else{
                    return 0
                }
            }

            if currentFieldKey = "eyr"{
                if ((currentFieldValue >= "2020" )&&(currentFieldValue <= "2030")&&($LENGTH(currentFieldValue)="4")){
                    return 1
                }else{
                    return 0
                }
            }

            if currentFieldKey = "hgt"{
                set hgtUnit = $E(currentFieldValue,$LENGTH(currentFieldValue)-1,$LENGTH(currentFieldValue))
                w "hgtUnit: ",hgtUnit,!
                set hgtNum = $E(currentFieldValue,0,$LENGTH(currentFieldValue)-2)
                w "hgtNum: ",hgtNum,!

                if hgtUnit = "in"{
                    if ((hgtNum >= "59")&&(hgtNum <="76")){
                        return 1
                    }else{
                        return 0
                    }
                }

                if hgtUnit = "cm"{
                    if ((hgtNum >= "150")&&(hgtNum <="193")){
                        return 1
                    }else{
                        return 0
                    }
                }

            }

            if currentFieldKey = "hcl"{
                if (($E(currentFieldValue,1,1)="#")&&($LENGTH(currentFieldValue)=7)){
                    set stripped = $ZSTRIP(currentFieldValue,"*E",,"0123456789abcdef")
                    if $LENGTH(stripped)="6"{
                        return 1
                    }else{
                        return 0
                    }
                }else{
                    return 0
                }
            }

            if currentFieldKey = "ecl"{
                if ((currentFieldValue="amb")||(currentFieldValue="blu")||(currentFieldValue="brn")||(currentFieldValue="gry")||(currentFieldValue="grn")||(currentFieldValue="hzl")||(currentFieldValue="oth")){
                    return 1
                }else{
                    return 0
                }
            }

            if currentFieldKey = "pid"{
                if $LENGTH(currentFieldValue)="9"{
                    set stripped = $ZSTRIP(currentFieldValue,"*E",,"0123456789")
                    if $LENGTH(stripped)="9"{
                        return 1
                    }else{
                        return 0
                    }
                }
            }
            
            return 0
        }
    }
    return 0
}

}
