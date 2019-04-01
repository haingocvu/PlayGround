import UIKit

//khi inherit từ lớp cha thì lớp con có thể sử dụng observers khi override properties bất chấp đó là stored properties hay là computed properties

//example
class Vehicle {
    var currentSpeed = 0.0
    var description : String {
        return "Traveling at \(self.currentSpeed) miles per hour"
    }
    func makeNoise() {
        //the implementation will be done by subclasses
    }
}

let vehicle1 = Vehicle()
print(vehicle1.description)

//subclasses

class Bicycle : Vehicle {
    var hasBasket = false
}

var bicycle1 = Bicycle()
bicycle1.hasBasket = true
bicycle1.currentSpeed = 40
print(bicycle1.description)

//subclass of bicycle
class Tandem : Bicycle {
    var currentNumberOfPassengers = 0
}

let tanDem1 = Tandem()
tanDem1.hasBasket = false
tanDem1.currentNumberOfPassengers = 2
tanDem1.currentSpeed = 22
print(tanDem1.description)

//Overriding Methods
//có thể ghi đè 1 method là static hoặc not static đều được

class Train : Vehicle {
    override func makeNoise() {
        super.makeNoise()
        print("Choo Choo")
    }
}

var train1 = Train()
train1.makeNoise()

//Overriding Properties
//có thể override static properties or not static properties
//override loại này để cung cấp getter, setter, observers cho property đó


//override property Getter and Setter
//có thể cung cấp getter (or settter if available) cho 1 property mà nó kế thừa. bất chấp đó là stored property
//hay là computed property (getter, setter properties)
//khi override properties phải khai báo đầy đủ name và type để tránh compile error
//read-only property (getter) có thể override thành read-write property (getter and setter)
//nhưng. read-write property không thể override thành read-only property
//override setter thì cũng phải override getter
//key remember: override thì chỉ có thể mở rộng nó ra, chứ không phải làm hẹp nó lại? ok?

class Car : Vehicle {
    var gear : Int = 1
    override var description: String {
        //getter
        return super.description + " in gear \(gear)"
    }
}

let car1 = Car()
car1.gear = 3
car1.currentSpeed = 80
print("Car: \(car1.description)")


//Overriding Property Observers
//khi override thì không thể dùng vừa override setter và observers với nhau
//vì observers đã là setter rồi.
//nếu vẫn muốn dùng observers có thể để nó ở bên trong setter

class AutomaticCar : Car {
    override var currentSpeed: Double {
        didSet {
            self.gear = Int(self.currentSpeed/10.0) + 1
        }
    }
}

var autoCar1 = AutomaticCar()
autoCar1.currentSpeed = 90
print("auto car: \(autoCar1.description)")

//PREVENT OVERRIDING
//you can prevent a method, property or subscript from being overridden by making it as final
//final var
//final func
//final class func (class func là static function mà cho phép override)
//final subscript
//final class
