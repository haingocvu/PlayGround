//: Playground - noun: a place where people can play

import UIKit

//Extensions add new functionality to an existing class, structure, enumeration, or protocol type. This includes the ability to extend types for which you do not have access to the original source code

//Extensions in swift can:
//Add computed instance properties and computed type properties
//define instance methods and type methods
//provide new initializers
//define subscript
//define and use new nested types
//make an existing type conform to a protocol


//COMPUTED PROPERTIES
//EXTENSION chỉ có thể add new COMPUTED properties
//không thể add new STORED properties hay OBSERVERS

//example for computed properties
//dưới đây ta extend kiểu Double bằng cách thêm các đơn vị đo lường vào nó
//các đơn vị này cung cấp 1 getter sẽ trả về kết quả việc convert đơn vị đo lường này sang mét
extension Double {
    var m: Double {
        return self
    }
    var km: Double {
        return self * 1_000.0
    }
    var cm: Double {
        return self / 1_00.0
    }
    var mm: Double {
        return self / 1_000.0
    }
    var ft: Double {
        return self / 3.28084
    }
}

let threeFeet = 3.ft
print("three feet is: \(threeFeet) meters")

let aMarathon = 42.km + 195.m
print("A marathon is: \(aMarathon) meters long")


//INITIALIZERS
//extension can add new initializers to existing types
//extension chỉ có thể add convenience init đến 1 class (còn struct hay gì thì bình thường)
//mà không thể add designated init hay deinit đến class đó

//example

struct Size {
    var width = 0.0
    var height = 0.0
}
struct Point {
    var x = 0.0
    var y = 0.0
}

struct Rect {
    var origin : Point = Point()
    var size : Size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

//add new init to Rect

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width/2)
        let originY = center.y - (size.height/2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
//vì Rect là struct nên ta có thể thêm init extension thoả mái. k quan tâm nó là designated hay convenience init
//class thì chỉ có thể có extension init là convenience thôi.
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
print("rect with origin is: (\(centerRect.origin.x), \(centerRect.origin.y))")


//METHODS
//Extensions can add new instance methods and type methods to existing types

extension Int {
    func competitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

10.competitions {
    print("Nhii")
}


//MUATING INSTANCE METHODS
//Instance methods added with an extension can also modify (or mutate) the instance itself.
//giống như rule của mutating function của struct hay enum ta đã biết trước đây
//vì value type không thể tự biến đổi chính nó nên mới sản sinh ra khái niệm mutating function này

//very simple example

extension Int {
    mutating func square() {
        self = self * self
    }
}

//dùng
var someInt = 8
someInt.square()
print("someInt now has value: \(someInt)")



//SUBSCRIPT
//Extensions can add new subscripts to an existing type

//bây giờ ta viết 1 subscript để lấy phần tử thứ index ra từ 1 int value (lấy từ phải sang trái)

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<decimalBase {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

//ý tưởng là ta sẽ xây dựng phần nguyên rồi chia dư cho 10
//phần nguyên được xây dựng từ hàm for ở trên

print(123456789[0])
//print 9

//NESTED TYPES
//extensions can add new nested types to existing classes, structs and enumerations

extension Int {
    //Kind is a nested type of Int
    enum Kind {
        case negative, zero, positive
    }
    var kind : Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

func printItegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .zero:
            print("0 ", terminator: "")
        case .negative:
            print("+ ", terminator: "")
        case .positive:
            print("- ", terminator: "")
        }
    }
    print("")
}

printItegerKinds([1, 4, 0, 2, 6, 8])

//OK?
//EASY?
//GO AHEAD!
