import UIKit

//Closure is a self-contained blocks of functionality that can be passed around and use in your code

//Closures can capture and store references to any variables and constant from the context in which they are defined

//Global and Nested function are actually a special cases of the closure
//Closures take one of three forms
//F1: Global functions are closures that have name and dont capture any values
//F2: Nested functions are closures that have a name and can capture any values from their enclosing function (function bao ngoài hay là function cha)
//F3: Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context

//Closure expressions are clean and clear with optimizations including:
//inferring parameter and return value type from the context
//Implicit returns from the single-expression closures
//Shorthand argument names
//Trailing Closure syntax

//Now we will learn Closure expression
//Example

//use normal function
let names = ["N", "G", "A", "N", "T"]
func backWard(_ s1: String,_ s2: String) -> Bool {
    return s1 >= s2
}
var reverseNames = names.sorted(by: backWard)
print(reverseNames)

//use closure expression
//the PARAMETERS IN THE CLOSURE EXPRESSION CAN NOT HAVE THE DEFAULT VALUE
let reverseNames2 = names.sorted(by: {(s1 : String, s2 : String) -> Bool in
    return s1 > s2
})
print(reverseNames2)
//as you can see, we got the same result when using closure expression to sort.

//Inferring Type from the context
//Because Sorting Closure is passed as an argument to a method, Swift can infer the types of its parameters and the type of the value it returns
//As the result, you never need the write an inline closure in fullest form when the closure is used as function argument
//example
let reverseName3 = names.sorted(by: { s1, s2 in return s1 > s2 })
print(reverseName3)

//Implicit returns from single-expression closure (closure that have one line in the body)
//in this case no need to write return in closure body
//this the same as arrow function in javascript
let reverseName4 = names.sorted(by: {s1, s2 in s1 > s2})
print(reverseName4)

//Shorthand Argument names
//used in inline-closure (closure that is passed as an argument of the function ?? hoặc là closure chỉ có 1 dòng, tức là closure chỉ cần return thui chứa
//1 dòng return thui)
//ommit all. use shorthand arguments name in the closure body
//example
let reverseName5 = names.sorted(by: { $0 > $1 })
print(reverseName5)

//Operator Methods
let reversename6 = names.sorted(by: > )
print(reversename6)

//Trailing Closures
//if you need to pass a closure expresstion to a function as the last function's arguments
//and the closure expresstion is too long, it can be useful to write it as a trailing closure instead
//trailing closure is written after function call's parentheses
//when using trailing function, you dont need to write the argument label for the closure as a part of the function call
//example
func doAction(num1 : Int, num2 : Int, action : (Int, Int) -> Int) -> Int {
    return action(num1, num2)
}
//dont use trailing closure
let _add = doAction(num1: 2, num2: 8, action: { num1, num2 in num1 + num2 })
print("total is: \(_add)")
let _sub = doAction(num1: 8, num2: 2, action: {num1, num2 in num1 - num2})
print("sub is: \(_sub)")
//using trailing closure

let _mul = doAction(num1: 2, num2: 8) { num1, num2 in num1 * num2 }
print("Mul is: \(_mul)")
//nói 1 cách đơn giản: trailing closure là 1 closure expression mà là tham số cuối cùng của 1 function. khi đó ta bỏ cái label parameter của nó trong cặp dấu ngoặc đơn của lời gọi hàm đi, đem nguyên closure đó để sau cặp dấu parentheses "()"
//của lời gọi function.
//các quy tắc khác thì y như các viết closure expression

let _divide = doAction(num1: 16, num2: 2) { _num1, _num2 in _num1/_num2 }
print("divide is : \(_divide)")

//using trailing closure for sorted function
//shorthand argument names
let reverseName7 = names.sorted() { $0 > $1 }
print(reverseName7)
//without shorthand argument names
let reverseName8 = names.sorted() { n1, n2 in n1 > n2 }
print(reverseName8)

//nếu 1 function chỉ nhận duy nhất 1 argument là closure thì khi viết trailing closure, ta không cần phải viết cặp dấu "()" nữa.
//example
let reverseName9 = names.sorted { $0 > $1 }
print(reverseName9)
//because the sorted method take only one argument so we can ommit the pair of parentheses

func mymap(_ arr: [Any], _ mappedFunc : (Any) -> Any) -> [Any] {
    var newArr = [Any]()
    for item in arr {
       let newItem = mappedFunc(item)
        newArr.append(newItem)
    }
    return newArr
}
let myArr1 = [1, 2, 3, 4, 5, 6]
let newArr1 = mymap(myArr1) { item in "số \(item)" }
print(newArr1)

//another example for trailing closure
let arrayOfNumbers = [18, 9, 128]
let dictionaryForMappy : [Int : String] = [
    0 : "Zero",
    1 : "One",
    2 : "Two",
    3 : "Three",
    4 : "Four",
    5 : "Five",
    6 : "Six",
    7 : "Seven",
    8 : "Eight",
    9 : "Nine"
]
let newArrayOfNumberAfterMapped = arrayOfNumbers.map { item -> String in
    var num = item
    var newItem = ""
    repeat {
        newItem = dictionaryForMappy[num%10]! + newItem
        num /= 10
    } while num > 0
    return newItem
}
print(newArrayOfNumberAfterMapped)

//Capturing Values
//a closure can capturing the constans and variables from the surrounding context in which it is defined
//the closure can then refer to or modify the value of those constants and variable from within its body,
//even if, the original scope that defined the constants and variables no longers exists
//khái niệm này tương tự như là closure bên javascript

//simple form of closure that can capture the values is nested function
//nested function can capture any of its outer function's arguments and can also capture the variables and constants within its outer function's body

//example
func makeIncrementer(forIncrement amount : Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
let incrementerby2 = makeIncrementer(forIncrement: 2)
print("lan 1: \(incrementerby2())")
print("lan 2: \(incrementerby2())")
print("lan 3: \(incrementerby2())")
print("lan 4: \(incrementerby2())")
print("lan 5: \(incrementerby2())")
print("lan 6: \(incrementerby2())")

//amazing, right?
//make increamenter by 10
let incrementerByTen = makeIncrementer(forIncrement: 10)
print("by ten 1: \(incrementerByTen())")
print("by ten 2: \(incrementerByTen())")
print("by ten 3: \(incrementerByTen())")
print("by ten 4: \(incrementerByTen())")
print("by ten 5: \(incrementerByTen())")
print("by ten 6: \(incrementerByTen())")

//2 thằng incrementer 2 và ten ở trên capturing reference đến outer function variable của riêng nó. k ảnh hưởng gì nhau.
//tức là 2 reference khác nhau

//CLOSURES ARE REFERENCE TYPE
//EXAMPLE
let incrementBy8 = makeIncrementer(forIncrement: 8)
let alsoIncrementBy8 = incrementBy8
print("inc by 8 s 1 : \(incrementBy8())")
print("inc by 8 s 2 : \(incrementBy8())")
print("inc by 8 s 3 : \(alsoIncrementBy8())")
print("inc by 8 s 4 : \(alsoIncrementBy8())")
//amazing, right?

//Escaping Closures

var completionhandlers : [() -> Void] = []

func someFunctionWithEscapingClosure(closure : @escaping () -> Void) -> Void {
    completionhandlers.append(closure)
}

//khi sử dụng @escaping closure thì khi sử dụng bên trong 1 class. để truy xuất đến property của class thì ta phải dùng self.
//example
func someFunctionWithNonEscapingClosure(closure: () -> Void) -> Void {
    closure()
}

class SomeClass {
    var x = 10
    func doSomeThing() {
        someFunctionWithEscapingClosure {
            self.x = 100
        }
        someFunctionWithNonEscapingClosure {
            x = 200
        }
    }
}

var _ca = SomeClass()
_ca.doSomeThing()
print("x before using escaping closure: \(_ca.x)")
completionhandlers.first?()
print("x after using escaping closure: \(_ca.x)")

//amazing, right?

//Auto Closure
//AutoClosure is a closure automatically created to wrap an expression that being passed as an argument to a function. It doesn't take any arguments, and when it's call, it return the value of the expression that is wrapped inside it
//khi gọi hàm chứa autoclosure thì ta không cần phải sủ dụng dấu ngoặc nhọn bao cái closure lại
//an expression có nghĩa là closure chỉ chứa duy nhất 1 dòng lệnh. k tham số.

//it's common to call a fucntion that takes autolosure, but it's not common to implement that kind of function

//An Autoclosure lets you delay evaluation, because the code inside isn't run until you call the closure
//Delaying evaluation is useful for code that has side effects

//this code below show how a closure delays evaluation

var customerInline = ["Nhi", "Giang", "Anh"]
print("length: \(customerInline.count)")

let customerProvider = { customerInline.remove(at: 0) }
print("leghth: \(customerInline.count)")

print("Now serving \(customerProvider())")
print("length: \(customerInline.count)")

//delaying evaluation when passing a closure as an arguments to a function
func serve(customer customerProvider : () -> String) {
    print("Now serving \(customerProvider())")
}
serve(customer: { customerInline.remove(at: 0) })

//Now we use autoclosure
//ok, let's go

//rewrite the function above with autoclosure @autoclosure

func serveAutoClosure(customer customerProvider : @autoclosure () -> String) {
    print("Now Serving \(customerProvider())")
}
//we need to pass an expression to the right of customer that when execute the expression, we got the return value of string
//ok, do it
serveAutoClosure(customer: customerInline.remove(at: 0))

//ok, đơn giản là 1 closure mà ở dạng đơn giản nhất (tức là closure k có tham số, chỉ bao gồm 1 dòng lệnh) thì
//khi đó ta có thể make closure đó như là autoclosure (thêm @autoclosure trước kiểu của closure khi khai báo closue đó là tham số của function
//khi 1 function chứa autoclosure thì đơn giản là khi gọi function đó, ở bước truyền tham số là autoclosure cho function đó...
//ta chỉ cần bỏ luôn cái cặp dấu "{}" (cặp dấu "{}" được dùng chứa closure)
//như ta thấy ở trên khi gọi hàm serveAutoClosure. ta đã truyền vào customer 1 autoclosure
//nhìn thì có vẻ như ta đang truyền vào 1 kiểu string cho tham số customer của hàm serveAutoClosure
//nói chung autoclosure rất dễ gây hiểu nhầm

//AutoClosure and Escaping

var myCrushs = ["Nhi", "Giang", "Anh"]
var customerProviders : [() -> String] = []

func collectCustomerProvider(_ closure : @escaping @autoclosure () -> String) {
    customerProviders.append(closure)
}

collectCustomerProvider(myCrushs.remove(at: 0))
collectCustomerProvider(myCrushs.remove(at: 0))

print("Collected \(customerProviders.count) closures")

for closure in customerProviders {
    print("Now serving: \(closure())")
}

//amazing, right?
//but very hard to understand?
