//: Playground - noun: a place where people can play

import UIKit

//an enumeration defines common type for a group of related value

//Enum Syntax

enum Gender {
    case Male
    case Female
}
//by default, các case trong enum k có giá trị mặc định
//asign a variable with an enum type
var male = Gender.Male
print(type(of: male))

//khi đã biết kiểu dữ liệu của male rồi thì ta có thể dùng shorter syntax
male = .Female
//good, righ?

//Enum with switch

switch male {
case Gender.Male:
    print("your gender is : Nam")
case .Female:
    print("your gender is : Nu")
}

//Iterating over enumeration cases
enum Color : CaseIterable {
    case red, green, blue
}
print("having : \(Color.allCases.count) Colors")
print(type(of: Color.allCases))
for item in Color.allCases {
    print(item)
}
print(Color.red)
print(type(of: Color.red))

//Associated Values
//ta định nghĩa associated value trong cặp dấu (). ngay sau tên case
//example

enum BarCode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var qrCode = BarCode.qrCode("hadahj@kjhdfkjj4742bnf")
print(qrCode)

switch qrCode {
case .upc(let a, let b, let c, let d):
    print("UPC code with : (\(a), \(b), \(c), \(d))")
case .qrCode(let str):
    print("qrCode with str: \(str)")
}

//in the above example, if a, b, c, d are exacted as constant (or variable), we can move the entire let (or var) keyword to after case for all
//example
qrCode = BarCode.upc(12, 24, 36, 8)
switch qrCode {
case let .qrCode(str):
    print("qrCode with: \(str)")
case let .upc(a, b, c, d):
    print("upc code with: (\(a), \(b), \(c), \(d))")
}

//Default (Raw) Value
//as the alternative to associated value, we use default values (raw values) which are all of the same type
//to define the type of raw value, we define the enum type, the same way we define value type
//example

enum ASCIIControlCharacters : Character {
    case tab = "\t"
    case lineFeed = "\n"
    case CarriAgeReturn = "\r"
}

//Raw value can be String, Character, or any of Interger or Floating-Point Number Type
//Đối chiếu với Associated Value thì nó bị hạn chế hơn. Associated Value có kiểu dữ liệu có thể là bất cứ gì (thậm chí là tuple như ví dụ ở trên)
//ngoài ra thì giá trị rawValue (default value) của từng case của enum rawvalue thì nó luôn là như vậy (không thay đổi). nó được tạo ra ngay khi ta định nghĩa enum
//còn đối với associated value thì giá trị associated value được tạo ra khi ta gán giá trị của case cụ thể của enum vào 1 constant or variable

//Nói chung Rawvalue (default value) không mấy tác dụng??? right?
//Nói chung thì enum đơn giản chỉ là từ khoá enum và case
//đừng làm phức tạp lên. nếu cần phức tạp ta có thể dùng struct hay class

print(ASCIIControlCharacters.tab.rawValue)
//dòng trên sẽ in ra "\t". ta không nhìn thấy được vì nó là tab

//Implicitly Assigned Raw Value
//default value ngầm định

//when we're working with enums that store integer or string rawvalue, you dont have to explicitly assign rawvalue for each case. When you dont, swift automatically assigns the values for you
//việc gì khó cứ để swift lo. khi định nghĩa enum có type là String hay Int, ta k cần thiết định nghĩa rawValue. Swift sẽ tự định nghĩa dùm ta
//example
enum Age : Int {
    case one, two, three
    case four, five, six
    case seven, eight, nine
    case ten
}
print("raw value of two is: \(Age.two.rawValue)")
//swift đánh số từ 0. do đó ta có thể gán giá trị ban đầu cho case đầu tiên là 1, như 1 trick nhỏ
//example
enum Age1 : Int {
    case one = 1
    case two
    case three
}

print("raw value of two is: \(Age1.two.rawValue)")
//amazing, right?

//when working with rawValue of String. the rawvalue of each case is the case's name.
//example
enum LapTop : String {
    case apple
    case dell
    case hp
    case asus
}
print("rawvalue of apple is: \(LapTop.apple.rawValue)")

//Initializing from the rawvalue
let elevent = Age.init(rawValue: 10)
if let elev = elevent {
    switch elev {
    case .one:
        print("one")
    default:
        print("I dont know")
    }
} else {
    print("No value")
}

//RECURSIVE ENUMERATIONS
//recursive enumeration is an enumeration that has another instance of the enumeration as the associated value for one or more of the enumeration case.
//we indicate that an enumeration case is recursive by writing indirect before it

//example
enum ErithmeticExpression {
    case number(Int)
    indirect case add(ErithmeticExpression, ErithmeticExpression)
    indirect case mul(ErithmeticExpression, ErithmeticExpression)
}

//let's try to make the expression of
// (2+8)*8

let two = ErithmeticExpression.number(2)
let eight = ErithmeticExpression.number(8)
let add = ErithmeticExpression.add(two, eight)
let product = ErithmeticExpression.mul(add, eight)

func evaluate(_ expression : ErithmeticExpression) -> Int {
    switch expression {
    case .number(let num):
        return num
    case let .mul(ex1, ex2):
        let rs = evaluate(ex1) * evaluate(ex2)
        return rs
    case let .add(ex1, ex2):
        let rs = evaluate(ex1) + evaluate(ex2)
        return rs
    }
}

//now let do it
let _result = evaluate(product)
print("kq: \(_result)")

//amazing, right?
