import UIKit

//Methods
//the difference between swift and other languages is that swift can define methods for enum and struct type.

//example
struct Counter {
    var count : Int = 0
    mutating func inCrement() {
        count += 1
    }
    mutating func inCrement(by amount : Int) {
        count += amount
    }
    mutating func reset() {
        count = 0
    }
}

//Self key word
//Every instance of a type has an implicit property called self, which is exactly equivalent to the instance itself. You use the self property to refer to the current instance within its own instance methods.
//example
class Person {
    var name : String
    init(name : String) {
        self.name = name
    }
}

let nhi = Person(name: "Nhi")
print(nhi.name)

//Modifying Value Type from Within Instance Methods
//struct và enum là value type do đó
//sử dụng mutating trước method của struct và enum nếu phương thức đó thay đổi property của enum hay struct đó
//thậm chí là thay đổi nguyên struct hay enum đó
//ví dụ như trên

var counter1 = Counter(count: 0)
counter1.inCrement(by: 2)
print("count is: \(counter1.count)")
//nhưng khi dùng let thì không được nha
let counter2 = Counter(count: 0)
//uncomment the below line will case a compile error
//counter2.inCrement()

//Assigning to Self within a mutating method

struct Point {
    var x = 0, y = 0
    mutating func moveTo(x : Int, y : Int) {
        self = Point(x: x, y: y)
    }
}

var point1 = Point(x: 0, y: 0)
var point2 = point1
print("current point is: \(point1.x) - \(point1.y)")
point1.moveTo(x: 2, y: 2)
print("after move is: \(point1.x) - \(point1.y)")
print("after move is (for point2): \(point2.x) - \(point2.y)")

//như vậy, ta thấy bản chất enum hay struct sau khi dùng mutating cho method của nó thì nó vẫn là value type
//nhưng khi dùng mutating ta có thể thay đổi các properties của instance đó
//thật vi cmn diệu

//another example for enum

enum Gender {
    case Male
    case Female
    mutating func switchGender() {
        switch self {
        case .Male :
            self = .Female
        case .Female :
            self = .Male
        }
    }
}

var genderOfPhuong = Gender.Male
print("init gender of Phuong is: \(genderOfPhuong)")
genderOfPhuong.switchGender()
print("current gender of Phuong is: \(genderOfPhuong)")

//cho dễ hiểu. value type là kiểu dữ liệu mà bản thân nó không tự thay đổi nó được (kiểu như là dùng method của nó để thay đổi property của chính nó)
//bây giờ cần làm việc đó thì dùng key word mutating trước method đó.
//simple easy

//TYPE METHODS
//static methods
//Type methods dùng được cho cả enum, struct và class

class Person1 {
    static var name = "Nhi"
    static func sayHi() -> String {
        return "hi \(Person1.name)"
    }
}

print(Person1.sayHi())

//use self inside a type method
//now self prefers to type itself, rather than an instance of this type
//example
class Person2 {
    var age : Int
    init(age : Int) {
        self.age = age
    }
    static var name = "Nhi"
    static func changename(to name : String) {
        self.name = name
    }
}

print("current name : \(Person2.name)")
Person2.changename(to: "Hai")
print("current name : \(Person2.name)")

//NOTE
//bên trong static methods ta chỉ có thể sử dụng static properties or static methods khác
//như trong function changename ở trên. ta không thể prefer tới self.age vì age không phải là static property (type property)

//Another Example

struct LevelTracker {
    static var highestTrackedLevel = 1
    var currentLevel = 1
    static func unLock(level : Int) {
        if level > highestTrackedLevel {
            highestTrackedLevel = level
        }
    }
    static func isUnlocked(_ level : Int) -> Bool {
        return (level <= highestTrackedLevel)
    }
    @discardableResult
    mutating func advance(to level : Int) -> Bool {
        if level <= LevelTracker.highestTrackedLevel {
            currentLevel = level
            return true
        }
        return false
    }
}

LevelTracker.unLock(level: 10)
var lvTracker = LevelTracker()

lvTracker.advance(to: 11)
print("current level: \(lvTracker.currentLevel)")

if (lvTracker.advance(to: 6)) {
    print("current level is: \(lvTracker.currentLevel)")
}

//use levelTracker in Player Class

class Player {
    var tracker = LevelTracker()
    var playerName : String
    init(name : String) {
        playerName = name
    }
    func complete(level : Int) {
        LevelTracker.unLock(level: level)
        tracker.advance(to: level)
    }
}

let player = Player(name: "Nguyen Thuy Uyen Nhi")
player.complete(level: 10)
print("highest unlocked level is: \(LevelTracker.highestTrackedLevel)")

var player2 = Player(name: "Uyen Nhi")
if player2.tracker.advance(to: 12) {
    print("now at level: \(12)")
} else {
    print("level: 12 is not unlocked yet")
}

//Subscript
//Accessing an item in a collection with index (balls[1])
//you can use subscript in class, enum, struct
//as below

struct SPerson {
   var name = "Nhi"
   var age =  18
   var gender = Gender.Male
    subscript(index : Int) -> Any? {
        set {
            switch index {
            case 0:
                self.name = newValue as! String
            case 1:
                self.age = newValue as! Int
            case 2:
                self.gender = newValue as! Gender
            default:
                break
            }
        }
        get {
            switch index {
            case 0:
                return self.name
            case 1:
                return self.age
            case 2:
                return self.gender
            default:
                return nil
            }
        }
    }
    subscript(_name : String) -> Any? {
        get {
            switch _name {
            case "name":
                return self.name
            case "age":
                return self.age
            case "gender":
                return self.gender
            default:
                return nil
            }
        }
    }
}

var person3 = SPerson()
//get name of person3
print("current person3 name: \(person3[0]!)")
//set new name for person3
person3[0] = "Nguyen Thuy Uyen Nhi"
//get name again
print("new name for person3 is: \(person3[0] ?? "")")
print("age for person3 is: \(person3["age"]!)")

//another example for subscript

struct Matrix {
    var rows : Int
    var columns : Int
    var grid : [Double]
    init(rows : Int, columns : Int) {
        self.rows = rows
        self.columns = columns
        self.grid = Array(repeating: 0.0, count: self.columns * self.rows)
    }
    @discardableResult
    func isvalidIndex(row : Int, column : Int) -> Bool {
        return row >= 0 && row <= self.rows && column >= 0 && column <= self.columns
    }
    subscript(row : Int, column : Int) -> Double {
        get {
            assert(isvalidIndex(row: row, column: column), "Out of index")
            return self.grid[row * columns + column]
        }
        set {
            assert(isvalidIndex(row: row, column: column), "Out of index")
            self.grid[row * columns + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 3)
matrix[0, 1] = 2.3
matrix[1, 2] = 4.8

print("matrix value of [0, 1] is: \(matrix[0, 1])")
print("matrix value of [1, 2] is: \(matrix[1, 2])")
