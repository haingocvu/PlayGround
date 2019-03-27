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
let names = ["Nhi", "Giang", "Anh", "Ngoc", "Nga"]
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
//used in inline-closure (closure that is passed as an argument of the function)
//ommit all. use shorthand arguments name in the closure body
//example
let reverseName5 = names.sorted(by: { $0 > $1 })
print(reverseName5)
