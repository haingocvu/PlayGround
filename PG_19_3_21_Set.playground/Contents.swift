import UIKit

//SET stores distinct values.
//No defined order

class Person : Hashable {
    var name: String
    var age: Int
    var hashValue: Int {
        get {
            return age
        }
    }
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    static func == (l: Person, r: Person) -> Bool {
        if l.name == r.name && l.age == r.age {
            return true
        }
        return false
    }
}

//creating an empty SET
var _setOfPerson = Set<Person>()

print("a set's type is: \(type(of: _setOfPerson))")

//insert new item to a SET
_setOfPerson.insert(Person(name: "hai", age: 29))
_setOfPerson.insert(Person(name: "hai", age: 29))
for person in _setOfPerson {
    print("name: \(person.name), age: \(person.age)")
}
//cant insert the same item to the SET. good.
