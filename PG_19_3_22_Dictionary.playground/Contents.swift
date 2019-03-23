import UIKit

class Person : Hashable {
    
    var name: String
    var age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    var hashValue: Int {
        get {
            return self.age.hashValue + self.name.hashValue
        }
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        if lhs.age == rhs.age && lhs.name == rhs.name {
            return true
        }
        return false
    }
}

//init an empty Dictionary
//short hand
var _mySet1 : Dictionary<Int, Person> = [Int:Person]()
//short hand way 2
var _mySet2 : Dictionary<Int, Person> = [:]
//short hand recommended
var _mySet3 = [Int:Person]()
//normal. not recommended
var _mySet4 = Dictionary<Int, Person>()

//when the key's type in a dictionary is type of Int. the dictionary become an array? right?
_mySet3[0] = Person(name: "Uyen Nhi", age: 19)

//add items when initializing a dictionary
var _myDic1 : Dictionary<Int, Person> = [
    1 : Person(name: "Uyen Nhi", age: 19),
    2 : Person(name: "Ngoc Hai", age: 29)
]

//a very simple way to create an dictionary
var _simpleDic = [
    "wife" : Person(name: "Uyen Nhi", age: 19),
    "husband" : Person(name: "Ngoc Hai", age: 29)
]

print(type(of: _simpleDic))

//count item
print("so nguoi trong tu dien la : \(_simpleDic.count)")

//check whether a dictionary is empty
if _simpleDic.isEmpty {
    print("the dictionary is empty")
} else {
    print("the dictionary is full")
}

//add new value
_simpleDic["new"] = Person(name: "Giang Pham", age: 24)
print("now the dictionary is: \(_simpleDic.count)")

//update value
_simpleDic["wife"] = Person(name: "Nguyễn Thuỵ Uyển Nhi", age: 19)
print("now my wife is \(_simpleDic["wife"]?.name ?? "Uyen Nhi")")

//update value by using update method
//the update method return the old value if existing. otherwise, rerurn nil (add new item to dictionary)
//update method is used to update or add new item?
if let _oldValue = _simpleDic.updateValue(Person(name: "Vu Ngoc Hai", age: 29), forKey: "husband") {
    print("updated")
    print("old value: \(_oldValue.name)")
    print("new value: \(_simpleDic["husband"]?.name ?? "")")
} else {
    print("inserted new value")
}

//retrieve a value for a particular key
if let dicItem = _simpleDic["wife"] {
    print("wife is: \(dicItem.name)")
} else {
    print("empty!")
}

//remove a key-value pair in the dictionary by assign a nil to the key
_simpleDic["new"] = nil
print("now the dictionary is: \(_simpleDic.count)")

//or using removeValue method
if let _removed = _simpleDic.removeValue(forKey: "new") {
    print("removed: \(_removed.name)")
} else {
    print("I dont see the key. thanks!")
}

//Iterating over a dictionary
for (key, value) in _simpleDic {
    print("key: \(key). name: \(value.name)")
}

//loop over keys property of the dictionary
for key in _simpleDic.keys {
    print(key)
}

//the same. we iterating over the values property of the dictionary
for value in _simpleDic.values {
    print(value.name)
}

//init an array from the keys of the dictionary
var _myArr = Array(_simpleDic.keys)
print(_myArr)

//init an array from the values of the dictionary
var _myArr1 = [Person](_simpleDic.values)
for person in _myArr1 {
    print(person.name + " " + String(person.age))
}
