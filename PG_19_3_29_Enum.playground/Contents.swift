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
default:
    break
}
