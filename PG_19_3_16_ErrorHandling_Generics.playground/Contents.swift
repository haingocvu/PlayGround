import UIKit

enum PrinterError: Error {
    case OutOfPaper
    case NoToner
    case OnFire
}

func send(job: Int, toPrinter printerName: String) throws -> String {
    if(printerName == "noToner") {
        throw PrinterError.NoToner
    } else if (printerName == "outOfPaper") {
        throw PrinterError.OutOfPaper
    } else if printerName == "onFire" {
        throw PrinterError.OnFire
    }
    return "Job sent"
}

do {
    let rs = try send(job: 1, toPrinter: "UyenNhi")
    print(rs)
} catch {
    print(error)
}

//multiple catch
do {
    let rs = try send(job: 2, toPrinter: "onFire")
    print(rs)
} catch PrinterError.OutOfPaper {
    print("out of paper")
} catch let printerErr as PrinterError {
    print("Err is: \(printerErr)")
} catch {
    print(error)
}

let successPrinter = try? send(job: 2, toPrinter: "Success Printer")
let failurePrinter = try? send(job: 2, toPrinter: "noToner")

if successPrinter == nil {
    print("successprinter: print error")
} else {
    print("successprinter: \(successPrinter ?? "")")
}

if let _failurePrinter = failurePrinter {
    print("failureprinter: \(_failurePrinter)")
} else {
    print("failureprinter: print error")
}

//use defer to write the code that is execiuted after all the other code in the function, before the return statement
var fridgeIsOpen = true
var fridgeContent = ["milk", "eggs", "leftovers"]
func fridgeContain(_ food: String) -> Bool {
    fridgeIsOpen = true
    defer {
        fridgeIsOpen = false
    }
    var rs = false
    if fridgeContent.contains("milk") {
        rs = true
    }
    return rs
}

var _rs1 = fridgeContain("milk")
print(_rs1)
print(fridgeIsOpen)

//Generics
//func to create an array of any type
func createArray<AnyType>(repeating item: AnyType, numberOfTimes: Int) -> [AnyType] {
    var rs = [AnyType]()
    for _ in 0..<numberOfTimes {
        rs.append(item)
    }
    return rs
}
var _arrayOfAnyType = createArray(repeating: 10, numberOfTimes: 10)
print(_arrayOfAnyType)
