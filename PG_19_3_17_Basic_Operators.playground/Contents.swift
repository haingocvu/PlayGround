import UIKit

//Terminology
//Unary Operator: toán tử đơn phương. 1 mình.
//example for unary operator
var a: Int? = 10
print(a!)
//trong hàm print(a!) thì ! khi này là unary operator

//tương tự cho binary operator
var _sum = 10 + 2
//in the above case, the operator of (+) is binary operator

//the same for Ternary Operator
//having only one ternary operator in swift
let _temp = 10
_temp > 8 ? print("lon hon 8") : print("be hon 8")

//Assignment Operator
var _v1 = 10
var _v2 = 12
_v2 = _v1
print(_v2)
//assignment with tuple
let (c, d) = (2, 4)
print("c is: \(c). d is \(d)")

//Arithmetic Operators (toan tu so hoc)
//+ - * /
print(2 + 8)
// + operator can use to add 2 string
print("hi " + "how are you today")

//Remainder Operator: nó là modulo trong các ngôn ngữ khác
print(8 % 3)

//Unary Minus Operator: use to taggle the sign (dấu) of the variable
let ex1 = 10
let ex2 = -ex1
print(ex2)

//Unary Plus Operator
//Do nothing :))
let ex3 = +ex1
print(ex3)

//Compound Assignment Operators. += -= *= /=
var ex4 = 10
ex4 += 8
print(ex4)

//Comparation Operators
// == != > < >= <=
let ex5 = 10
if ex5 == 10 {
    print("ex5 = 10")
}

//Compare 2 tuple
if (2, "a") < (2, "b") {
    print("left tuple < right tuple")
} else {
    print("left tuple > right tuple")
}

//Ternary Conditional Operator: Toán tử 3 ngôi
//example
var age = 30
var _ex6 = "you are: " + ((age <= 30) ? "young" : "old")
print(_ex6)
//Nil-Coalescing Operator. (??) use to unwrapped the optional value
let ex7: Int? = 10
let ex8 = ex7 ?? 9
print(ex8)
//the above code is the same as
let ex9 = ex7 != nil ? ex7! : 9
print(ex9)

//Range Operators
//Closed Range Operator a...b
//include both a and b
for item in 1...8 {
    print(item)
}

//Half-Open Range Operator
// a..<b
//not including b
var _myArr = ["a", "b", "c"]
for item in 0..<_myArr.count {
    print(_myArr[item])
}

//One-Sided Ranges
for item in _myArr[...1] {
    print(item)
}
for item in _myArr[1...] {
    print(item)
}
for item in _myArr[..<3] {
    print(item)
}

//Logical Operators
// !a a && b a != b

//Logical Not Operator
let allowEntry = false
if !allowEntry {
    print("not allowed to entry")
}

//Logical AND Operator
var agexx = 18
var isHocGiaoLy = true
if agexx >= 18 && isHocGiaoLy == true {
    print("co the lay vo roi")
} else {
    print("chua the lay vo dau")
}
