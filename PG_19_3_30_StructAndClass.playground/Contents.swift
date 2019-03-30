import UIKit

//Structure and Class
//Ta chỉ cần định nghĩa ra class và struct. k cần import. good

//Comparing Structures and Classes
//Structure and Class have many things in common. Both can:
//Define properties to store value
//Define methods to provide functionality
//Define subscripts to provide access to their value using subscript syntax
//Define Initializer to setup their initial state
//Be Extended to expand their functionality beyond the default inplementation
//Comform to Protocol to privde standard functionality of the certain kind
//Properties
//Methods
//Subscripts
//Initialization
//Extensions
//Protocols

//But
//Classes have additional Capabilities that Structures dont have
//Inheritance
//Type Casting
//Deinitializer
//Reference Counting (Automatic reference counting)


//Best Practice
//Most of the custom data types you define will be structures and enums (not classes)

//Defining Syntax
//Struct and class have the same defination syntax. struct for struct and class keyword for class.
//example
struct StructName {
    //body here
}
class ClassName {
    //body here
}

struct Resolution {
    var width : Double
    var height : Double
    init(_ _width : Double = 0,_ _height : Double = 0) {
        self.width = _width
        self.height = _height
    }
}

class VideoMode {
    var resolution : Resolution
    var interlaced : Bool
    var frameRate : Double
    var name : String?
    init(resolution : Resolution = Resolution(), interlaced : Bool, framerate : Double, name : String?) {
        self.resolution = resolution
        self.interlaced = interlaced
        self.frameRate = framerate
        self.name = name
    }
}

//Init a Struct or Class
var _resolution = Resolution(1280, 720)
var _videoMode = VideoMode(resolution: _resolution, interlaced: false, framerate: 29, name: "normal")

//Access a property
print("the width of Struct Resolution is: \(_resolution.width)")
print("the height of class VideoMode is: \(_videoMode.resolution.height)")

//Set new value for a property
_videoMode.resolution.width = 2400
print("new width of the videoMode class is: \(_videoMode.resolution.width)")

//Struct rất vi diệu. ta k cần viết init cho nó. nhưng nó vẫn dùng hàm init được, tự động lấy body's members để truyền vào hàm init
//class thì k làm được như vậy

//NOTE: Structures and Enums are value type
//a value type is the type whose value is copied when it's asigned to a constant or variable, or
//when it's passed as a parameter to a function

//All of the basic types in swift are value type.
//Integers, Floating-point numbers
//Array
//Dictionaty
//String
//Boolean
//Struct
//Enum
//Set??

//Thực tế để tối ưu bộ nhớ, thì đối với collection (array, string, dictionary) thì không tạo ra 1 copied ngay lập tức
//mà nó sẽ shared memory with original instance
//khi nào cái thằng cái bản copy thay đổi (gán giá trị mới) thì mới thực sự được coppy
//Swift lo được, chỉ cần biết để yên tâm hơh thôi. :))

//example
var hd = Resolution(1280, 720)
var cinema = hd
print("init width value of hd: \(hd.width)")
print("init width value of cineme: \(cinema.width)")

//assign new value to width of cinema. then compare

cinema.width = 2400
print("current width of hd: \(hd.width)")
print("current width of cinema: \(cinema.width)")

//amazing, right?


//The same for Enum

enum PersonGender {
    case Male
    case Female
    case Other
    mutating func changeTo(to : PersonGender) {
        self = to
    }
}

var _Nhi = PersonGender.Female
var _Hai = _Nhi
print("init gender of Nhi is: \(_Nhi)")
print("init gender of Hai is: \(_Hai)")

_Hai.changeTo(to: .Male)
print("current gender of Nhi is: \(_Nhi)")
print("current gender of Hai is: \(_Hai)")

//amazing, right?

//CLASSES ARE REFERENCE TYPES

