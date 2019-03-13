import UIKit

class NamedShape {
    var numberOfSides = 2
    var name: String
    init(name: String) {
        self.name = name
    }
    func simpleDescription() -> String {
        return "A Shape with \(self.numberOfSides) sides"
    }
}

var shape = NamedShape(name: "Hinh Tron")
print(shape.simpleDescription())

class Square : NamedShape {
    var sideLength: Double
    init(name: String, sideLength: Double) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func getArea() -> Double {
        return self.sideLength * self.sideLength
    }
    
    override func simpleDescription() -> String {
        return "A Square with side length: \(self.sideLength)"
    }
}

let _mySquare = Square(name: "Square", sideLength: 22)
print(_mySquare.getArea())
print(_mySquare.simpleDescription())


class Circle : NamedShape {
    var radius: Double
    init(name: String, radius: Double) {
        self.radius = radius
        super.init(name: name)
        numberOfSides = 1
    }
    func getArea() -> Double {
        return self.radius * self.radius * 3.14
    }
    override func simpleDescription() -> String {
        return "A Circle with radius: \(self.radius)"
    }
}

var _myCircle = Circle(name: "Circle", radius: 6)
print(_myCircle.getArea())
print(_myCircle.simpleDescription())

//setter and getter
class EquilateralTriangle : NamedShape {
    var sideLength: Double
    init(name: String, sideLength: Double) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    var perimeter: Double {
        get{
            return self.sideLength * 3
        }
        set {
            self.sideLength = newValue/3
        }
    }
    override func simpleDescription() -> String {
        return "An EquiLateral Triangle with side Length: \(self.sideLength)"
    }
}
var _myEquilateralTriangle = EquilateralTriangle(name: "EquilateralTriangle", sideLength: 6)
print(_myEquilateralTriangle.perimeter)
_myEquilateralTriangle.perimeter = 9
print(_myEquilateralTriangle.sideLength)

class SquareAndTriangle {
    var square: Square {
        willSet {
            self.triangle.sideLength = newValue.sideLength
        }
    }
    var triangle: EquilateralTriangle {
        willSet {
            self.square.sideLength = newValue.sideLength
        }
    }
    init(name: String, sideLength: Double) {
        self.square = Square(name: name, sideLength: sideLength)
        self.triangle = EquilateralTriangle(name: name, sideLength: sideLength)
    }
}

var _triangleAndSquare = SquareAndTriangle(name: "Shape", sideLength: 8)
print(_triangleAndSquare.square.sideLength)
print(_triangleAndSquare.triangle.sideLength)

_triangleAndSquare.square = Square(name: "Square", sideLength: 20)
print(_triangleAndSquare.square.sideLength)
print(_triangleAndSquare.triangle.sideLength)

//optional value
var optionalSquare: Square? = Square(name: "Square", sideLength: 9)
var _sideLength = optionalSquare?.sideLength
print(_sideLength ?? 0)
