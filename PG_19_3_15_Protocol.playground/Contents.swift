import UIKit

protocol Example {
    //can get and set
    var name: String {get set}
    //only get
    var id: Int {get}
    //static property
    //dont need to create a class, you still can access to the static property
    static var _staticproperty: String {get set}
    
}

//basic example for protocol
protocol FullyNamed {
    var fullname: String {get}
}

struct Person : FullyNamed {
    let fullname: String
}

var john = Person(fullname: "John Terry")
print(john.fullname)

class StarShip: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullname: String {
        get {
            if let _prefix = self.prefix {
                return _prefix + " " + self.name
            }
            return self.name
        }
    }
}

var _starShip1 = StarShip(name: "Enterprise", prefix: "USS")
print(_starShip1.fullname)

//Method Requirements
protocol RandomNumberGenerator {
    func random() -> Double
}

class BasicRandom: RandomNumberGenerator {
    func random() -> Double {
        return Double.random(in: 0.0...1.0)
    }
}

var _myRandom = BasicRandom()
print("first random number: " + String(_myRandom.random()))
print("seconds random number: " + String(_myRandom.random()))


//another example for protocol
protocol ExampleProtocol {
    var simpleDescription: String? {get}
    mutating func adJust()
}

class simpleClass: ExampleProtocol {
    var simpleDescription: String?
    init(simpleDes: String) {
        self.simpleDescription = simpleDes
    }
    func adJust(){
        self.simpleDescription! += " now 100% adjusted"
    }
}

var _aSimpleClass = simpleClass(simpleDes: "hi good morning")
print(_aSimpleClass.simpleDescription ?? "")
_aSimpleClass.adJust()
print(_aSimpleClass.simpleDescription ?? "")

struct SimpleStruct: ExampleProtocol {
    var simpleDescription: String?
    init(simpleDes: String) {
        self.simpleDescription = simpleDes
    }
    mutating func adJust() {
        self.simpleDescription! += "now 100% adjusted"
    }
}

var _simpleStruct = SimpleStruct(simpleDes: "a simple struct")
print(_simpleStruct.simpleDescription ?? "")
_simpleStruct.adJust()
print(_simpleStruct.simpleDescription ?? "")

//extension uses to add functionality to an existing type
extension simpleClass {
    func sayHello(name: String) -> String {
        return "hello: \(name)"
    }
}

var _anotherSimpleClass = simpleClass(simpleDes: "hello")
print(_anotherSimpleClass.sayHello(name: "Nguyen Thuy Uyen Nhi"))

//use protocol name just like any other named type
var _protocolValue: ExampleProtocol = _anotherSimpleClass
print(_protocolValue.simpleDescription ?? "")
//the below line will cause an error. NOTE: protocol is interface
//print(_protocolValue.sayHello(name: "Error"))
