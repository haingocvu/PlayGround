import UIKit

//very simple example
func sayHi(name: String) -> String {
    return "hi \(name), good morning!"
}

print(sayHi(name: "Uyen Nhi"))

//Function without parameters
func hiAnonymous() -> String {
    return "hi, Anonymous"
}

print(hiAnonymous())

//Function with multiple parameters
func greet(name: String, isAnonymous: Bool) -> String {
    if isAnonymous {
        return hiAnonymous()
    }
    return sayHi(name: name)
}

print(greet(name: "Nguyen Thuy Uyen Nhi", isAnonymous: false))

//function does not return value
func doesntReturnValue() {
    print("I dont return value. just printing the result in the screen!")
}
doesntReturnValue()

//ignore the return value of the function
//use (_) to ingnore the return value of the function if you dont need it
func printAndReturn(name: String) -> String {
    print("hi \(name). have a nice day!")
    return name
}

let _ = printAndReturn(name: "Nhi")
//or simple call the function
printAndReturn(name: "Uyen Nhi")

//multiple return value
//using a tuple
func calMinMax(intArr: [Int]) -> (min: Int, max: Int) {
    var _min = Int.max
    var _max = Int.min
    for num in intArr {
        mySwitch : switch num {
        case let x where x > _max:
            _max = x
        case let x where x <= _min:
            _min = x
        default:
            break mySwitch
        }
    }
    return (min : _min, max : _max)
}

let rs = calMinMax(intArr: [1, 8, 4, 2, 10, 9])
print("min is: \(rs.min). max is: \(rs.max)")

//return an optional tuple
//the above example dont check if the array is empty caused a runtime errror.
//let's modify it
func calMinMaxOptional(intArr: [Int]) -> (min: Int, max: Int)? {
    guard !intArr.isEmpty else {
        return nil
    }
    var _min = Int.max
    var _max = Int.min
    for num in intArr {
        mySwitch : switch num {
        case let x where x > _max:
            _max = x
        case let x where x <= _min:
            _min = x
        default:
            break mySwitch
        }
    }
    return (_min, _max)
}

if let rs = calMinMaxOptional(intArr: []) {
    print("min: \(rs.min). max: \(rs.max)")
} else {
    print("please input a valid array of Int")
}

//parameter name is used in the function body
//Argument Label is used when calling a function
//by default, the function use their name as label
//define parameter name
func demo1(name1: String) {
    //name1 is the function's parameter name as well as argument name.
    print("hello \(name1)")
}
demo1(name1: "Nhiiii")
//define the argument label
func demo2(nameLabel name2 : String) {
    //nameLabel is the argument label
    //name2 is the parameter name
    print("hello \(name2)")
}
demo2(nameLabel: "Uyen Nhiiiii")

//Omitting Argument label
//use underscore (_) to omit the argument label
func printANumber(_ numberA : Int, numberB : Int) {
    print("number 1: \(numberA). number 2: \(numberB)")
}
printANumber(10, numberB: 12)

//default parameter value
//you can define the default value for any parameter in a function by assigning a value to the parameter after the parameter's type.
//if the default value is defined, you can ommit that parameter when calling the function
//example
func sayHiDefault(name: String, isAnonymous: Bool = false) -> String? {
    //return nil if the isAnonymous is true
    guard !isAnonymous else {
        return nil
    }
    return "Hi \(name). have a nice day. hihi"
}

if let _rs10 = sayHiDefault(name: "Uyen Nhi") {
    print(_rs10)
} else {
    print("Chao Anonymous")
}

//Variadic Parameter
func calSum(_ numbers : Int ...) -> Int {
    var total = 0
    for num in numbers {
        total += num
    }
    return total
}
print("total is :\(calSum(1, 2, 3, 8))")
//each function has ONLY ONE variadic parameter

//In-Out Parameters

//change the function's parameter value
func addThree(num: inout Int) {
    num += 3
}
var _a = 8
print(_a)
addThree(num: &_a)
print(_a)
//only use inout parameter with var (not let or literal value)
//the below line will cause a error when compiling the code
//addThree(num: 8)
//in-out parameters cannot have a default values and variadic parameter (...) cannot be marked as inout parameter
