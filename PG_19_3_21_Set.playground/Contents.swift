import UIKit

//SET stores distinct values.
//No defined order

class Person : Hashable {
    var name: String
    var age: Int
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(age)
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

print("the number of items in the above set is: \(_setOfPerson.count)")

//check whether a Set isEmpty or not
if _setOfPerson.isEmpty {
    print("the above set is empty")
} else {
    print("the above set is not empty")
}

//add new item to SET by using insert method
_setOfPerson.insert(Person(name: "Nguyen Thuy Uyen Nhi", age: 19))
for person in _setOfPerson {
    print("name: \(person.name), age: \(person.age)")
}

let _giang = Person(name: "Giang", age: 24)
_setOfPerson.insert(_giang)
for person in _setOfPerson {
    print("name: \(person.name), age: \(person.age)")
}
let _removedPerson = _setOfPerson.remove(_giang)
for person in _setOfPerson {
    print("name: \(person.name), age: \(person.age)")
}
print("the number of person Set now is: \(_setOfPerson.count)")
print("I removed \(_removedPerson?.name ?? "") from my heart!")


var _myLovers : Set<Person>? = Set<Person>()
let _Nhi = Person(name: "Nguyen Thuy Uyen Nhi", age: 19)
let _emGaiMua = Person(name: "Giang", age: 24)
_myLovers?.insert(_Nhi)

//check whether Nhi is my lover
if (_myLovers?.contains(_Nhi))! {
    print("Nhi is my lover. :D")
} else {
    print("Nhi is not my lover")
}

//check if emGaiMua is my lover
if (_myLovers?.contains(_emGaiMua))! {
    print("em gai mua is my lover")
} else {
    print("em gai mua is not my lover")
}

//loop over a set
for lover in _myLovers! {
    print("my lover is: \(lover.name), age: \(lover.age)")
}

//Set Operations

//Fundamental Set Operations

let _nhiXinhGai = Person(name: "Uyen Nhi", age: 19)
let _ngaCute = Person(name: "Nga Thu", age: 23)
let _giangMup = Person(name: "Giang Pham", age: 24)

let _group1 : Set<Person> = [_nhiXinhGai, _ngaCute]
let _group2 : Set<Person> = [_nhiXinhGai, _giangMup]

//Intersection. get the common part
let _lovers = _group1.intersection(_group2)
for lover in _lovers {
    print("my lover is: \(lover.name)")
}

//Symmetric Deifference. Difference part
let _emGaiMuas = _group1.symmetricDifference(_group2)
for emgaiMua in _emGaiMuas {
    print("em gai mua: \(emgaiMua.name), age: \(emgaiMua.age)")
}

//union. +
let _all = _group1.union(_group2)
for p in _all {
    print("name: \(p.name), age: \(p.age)")
}

//subTraction a - b. return new Set with values of a that not in set of b
var _subs = Set<Person>()
do {
    let _subsArray = try _group1.subtracting(_group2).sorted(by: {(p1: Person, p2: Person) throws -> Bool in
        return p1.name < p2.name
    })
    _subs = Set(_subsArray)
} catch {
    
}
for sub in _subs {
    print("sub: \(sub.name), age: \(sub.age)")
}

//Set Membership and Equality
let _set1 : Set<Person> = [_nhiXinhGai, _ngaCute, _giangMup]
let _set2 : Set<Person> = [_nhiXinhGai]
let _set3 : Set<Person> = [_ngaCute, _giangMup]

if _set1.isSuperset(of: _set2) {
    print("set1 is superset of set2")
}

if _set2.isSubset(of: _set1) {
    print("set2 is subset of set1")
}

//super but not equal
if _set1.isStrictSuperset(of: _set2) {
    print("set1 is strict superset of set2")
}

//sub but not equal
if _set2.isStrictSubset(of: _set1) {
    print("set2 is strict subset of set1")
}

//use isDisjoint to determine whether 2 sets have no value in common
if _set1.isDisjoint(with: _set2) {
    print("all the item in set1 are not in set2")
} else {
    print("any item in set1 is in set2")
}
