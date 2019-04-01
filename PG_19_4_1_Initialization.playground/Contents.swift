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
    init(red : Double, green : Double, blue blue : Double) {
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
