//: Playground - noun: a place where people can play

import UIKit

//Init value for stored properties
//khi set default value cho stored properties hay là khởi tạo giá trị của stored properties trong hàm init
//thì observers sẽ không được gọi

//sư dụng hàm init
struct Person {
    var name : String
    init(name : String) {
        self.name = name
    }
}

var person1 = Person(name: "Uyen Nhi")
print("name: \(person1.name)")

//Provide default value
struct Vehicle {
    var vehicleName : String = "Vehicle name default"
}

var bicylce = Vehicle()
print("default name is: \(bicylce.vehicleName)")

//CUSTOMIZING INITIALIZATION

//Initialization Parameters
//sử dụng cách khai báo parameters tương tự như cách ta dùng với functions and methods khác
//example

struct Celsius {
    var temperatureInCelsius : Double
    init(fromFahrenheit fahrenheit : Double) {
        temperatureInCelsius = (fahrenheit - 32.0)/1.8
    }
    init(fromKelvin kelvin : Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let poilingPointOfWater = Celsius(fromFahrenheit: 212.0)
print("poiling point of water is: \(poilingPointOfWater.temperatureInCelsius)")

let freezingPointOfWater = Celsius(fromKelvin: 273.15)
print("freezing point of water is: \(freezingPointOfWater.temperatureInCelsius)")

//ta thấy nó hơi khác với các ngôn ngữ khác. ở đây cả 2 hàm init cùng nhận vào 1 constant kiểu Int
//nhưng mà nó vẫn không bị lỗi, đó là do cơ chế sử dụng labeled arguments của swift
//thật vi diệu, right?

//Parameter Names and Argument Labels
//the same as other functions and methods

struct Color {
    var red, green, blue : Double
    init(red : Double, green : Double, blue : Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white : Double) {
        red = white
        green = white
        blue = white
    }
}

let halfGray = Color(white: 0.5)
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)

//Initializer Parameters Without Argument Labels
//the same/ using underscore (_)
//example

struct CelsiusAdvanced {
    var temperatureInCelsius : Double
    init(_ celsius : Double) {
        self.temperatureInCelsius = celsius
    }
}

var celsius2 = CelsiusAdvanced(12)
print("current temperature in Celsius is: \(celsius2.temperatureInCelsius)")

//Optional Property type
//optional properties có thể không cần init giá trị ban đầu cho nó
//đơn giản là nếu là optional nó đã có giá trị ban đầu là nil (nghĩa là chỉ có gì :)) )
//example

struct ServeyQuestion {
    var text : String
    var response : String?
    init(text : String) {
        self.text = text
    }
    func ask() {
        print(self.text)
    }
}

var servey = ServeyQuestion(text: "what is your name?")
servey.ask()

//init constant properties
//constant properties only can be set by class itself
//subclass can't set the value for the constant that it inherited

class SurveyQuestion {
    let text : String
    var response : String?
    init(text : String) {
        self.text = text
    }
}

var newSurveyQuestion = SurveyQuestion(text: "what is your name?")
newSurveyQuestion.response = "Hai Vu"
print("the response is: \(newSurveyQuestion.response!)")

//initializer delegation for value type
//hàm init có thể gọi 1 hàm init khác, nhằm tiết kiệm code.
//cơ chế này gọi là initializer delegation
//vì value type (struct, enum) k có inherit nên hàm init của value type chỉ có thể gọi các hàm init khác của chính nó
//Nếu value type có custom init thì default init và memberwise init sẽ không sử dụng được nữa

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
    var point : Point = Point()
    var size : Size = Size()
    init() {
    }
    init(origin : Point, size : Size) {
        self.point = origin
        self.size = size
    }
    init(center : Point, size : Size) {
        let originX = center.x - (size.width/2)
        let originY = center.y - (size.height/2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

//hàm init thứ 1 như default init
var basicRect = Rect()
print("basic rect: (\(basicRect.point.x), \(basicRect.point.y))")

//cái hàm init thứ 2 như memberwise init
var originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
print("origin rect: (\(originRect.point.x), \(originRect.point.y))")

//init thứ 3 phức tạp hơn, nó call (delegate đến 1 hàm init khác)
var centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
print("center rect: (\(centerRect.point.x), \(centerRect.point.y))")

//you can use extensions to define your custom initializers without removing default and memberwise initializers
//dùng extensions để thêm init, thảo luận sau


//CLASS INHERITANCE AND INITIALIZATION
//các stored properties của 1 class (bao gồm cả những cái nó kế thừa được đều cần phải init trong quá trình tạo ra instant
//swift cung cấp 2 loại init cho class để đảm bảo rằng tất cả các stored properties đều nhận được init value
//đó là: Designated initializers and Convenience initializers

//Designated Init là phương thức init đầu tiền của 1 class. nó sẽ được gọi đầu tiên khi init.
//Nó cung cấp tất cả giá trị init cho những properties mà CHÍNH CLASS đó định nghĩa.
//sau đó nó sẽ gọi tiếp phương thích init thích hợp của class cha, để tiếp tục quá trình init
//key to remember: mình lo cho mình trước đã =)). cứ phải init cho mình trước tiên rồi tính tiếp.

//mỗi class phải có ít nhất 1 designated initializers. có thể là được kế thừa tùq lớp cha

//Convenience Initializers là phương thức khởi tạo thứ 2 của 1 class. nó không bắt buộc


//Rule cho Designated Initializers and Convenience initializers
//Rule 1: Designated Initializers phải gọi 1 phương thức designated initializers từ lớp cha trực tiếp của nó
//Rule 2: Convenience chỉ có thể gọi 1 phương thức init từ chính class đó. nội bộ
//Rule 3: convenience initializer sau cùng (cuối body của convenience init) phải gọi 1 designated initializer

//Key to remember: Designated Init phải luôn luôn gọi lên (tức là lên lớp cha)
//Convenience Init phải luôn luôn gọi ngang hàng (gọi trong nội bộ class)

//two-phase initialization
//class init trong swift là two-phase process.
//phase 1: mỗi stored property được init value bởi class tạo ra nó
//phase 2: mỗi class có cơ hội để customize stored properties của nó trước khi instance của class được tạo ra

//swift compiler thực hiện 4 bước safety-check để đảm bảo rằng two-phase init thực hiện thành công mà không có lỗi

//Safety-check 1: a designated initializers phải đảm bảo rằng tất cả các stored properties của chính class đó phải được khởi tạo giá trị ban đầu...
//trước khi nó gọi tiếp init của superclass

//Safety-check 2: a designated initializer phải gọi lên phương thức init của lớp cha trước khi nó muốn assign new value cho properties mà nó kế thừa được từ lớp cha

//Safety-check 3: a convenience initializer phải gọi đến 1 phương thức init khác trước khi nó gán giá trị mới cho properties (bao gồm của properties của chính
//class đó)

//Safety-check 4: an initializer không thể call 1 instance method, hay read 1 instance property, hay prefer to self as a value cho tới khi phase 1 completed

//For detail of 2-phase init. read the document


//Initializer Inheritance and Overriding
//swift subclass dont inherit their supperclass initializers


