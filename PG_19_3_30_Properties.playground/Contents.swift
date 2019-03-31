import UIKit


//Stored Properties
//property mà lưu gía trị cho chính nó khi được assign
//stored properties chỉ có trong class và struct
//example
struct fixedLengthRange {
    var firstValue : Int
    let length : Int
}

var newRange = fixedLengthRange(firstValue: 2, length: 6)
print("first value: \(newRange.firstValue)")

newRange.firstValue = 8
print("first value: \(newRange.firstValue)")

//firsValue and Length are two stored properties

//Stored Properties of Constant Structure Instances
let constRange = fixedLengthRange(firstValue: 2, length: 4)
print("first value is: \(constRange.firstValue)")
//uncommented below line will cause a compile error.
//constRange.firstValue = 10
//struct is value type so when you define struct instance as constant, you cant modify it.

//Lazy Stored Properties
//lazy stored properties are properties whose initial value is not calculated ultil the first time it is used
//a lazy stored property is always a var (not let)
//khi nào cần thì mới có property đó, còn không cần thì thôi.
//kiểu mấy thằng bạn mấy dạy vậy. khi nào cần vay tiền mới gọi, không thì thôi.

//example for lazay stored properties

class DataInporter {
    var fileName = "abc.txt"
}

class DataManager {
    lazy var dataImport = DataInporter()
    var data : Array<String>
    init() {
        self.data = [String]()
    }
}

let dataManager = DataManager()
dataManager.data.append("some data")
dataManager.data.append("some more data")

//tới đây thì dataimport vẫn chưa được khởi tạo

//try to print the dataimport
//bây giờ dataimport mới được khởi tạo. vì ta đã dùng tới nó
print(dataManager.dataImport.fileName)

//Computed Properties
//computed properties có trong class, struct, và enum
//computed properties kiểu như getter và setter ở các ngôn ngữ khác
//alway var not let

//example

struct Point {
    var x = 0.0
    var y = 0.0
}
struct Size {
    var width = 0.0
    var height = 0.0
}
struct Rect {
    var origin : Point
    var size : Size
    var center : Point {
        get {
            let xCenter = origin.x + (size.width/2)
            let yCenter = origin.y + (size.height/2)
            return Point(x: xCenter, y: yCenter)
        }
        set {
            origin.x = newValue.x - (size.width/2)
            origin.y = newValue.y - (size.width/2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10, height: 10))
var initialSquareCenter = square.center
print("init square center is: (\(initialSquareCenter.x), \(initialSquareCenter.y))")

//Shorthand Setter Declaration
//newValue ngầm định. example trên cũng đã dùng rồi còn gì :))

//Read-only Computed properties
//only getter. not setter
//but alway use var keywork. not let

struct NewStruct {
    var value1 : Double
    var value2 : Double
    var getter1 : Double {
        get {
            return value1 * value2
        }
    }
}

var newStruct = NewStruct(value1: 2, value2: 8)
print("mul is: \(newStruct.getter1)")

//Property observers
//you can add any property observers to any stored properties you define
//except for lazy stored properties
//you also can use property observers for computed properties if these comes from the supper class or struct (parent)

struct StepCounter {
    var totalSteps : Int = 0 {
        willSet {
            print("setting total steps to: \(newValue)")
        }
        didSet {
            if oldValue < totalSteps {
                print("added \(totalSteps - oldValue) steps.")
            }
        }
    }
}

var stepCounter = StepCounter(totalSteps: 12)

//the willSet and didSet observer dont be called when initializing (in owned class)
//setting new value
stepCounter.totalSteps = 100

//If you pass a property that has observers to a function as an in-out parameter, the willSet and didSet observers are always called

//Global and Local Varibales
 //The capabilities described above for computing and observing properties are also available to global variables and local variables. Global variables are variables that are defined outside of any function, method, closure, or type context. Local variables are variables that are defined within a function, method, or closure context.


var name : String = "Nguyen" {
    willSet {
        print("new value: \(newValue)")
    }
    didSet {
        print("old value \(oldValue)")
    }
}

name = "Nhi"
//Global constants and variables are always computed lazily, in a similar manner to Lazy Stored Properties. Unlike lazy stored properties, global constants and variables do not need to be marked with the lazy modifier.
//Local constants and variables are never computed lazily.


//Type Properties
//the same as static in orther languages

//example

//struct type properties
struct Example1 {
    static var staticStoredProperty : Int = 10
    static let staticReadOnlyStoredProperty : String = "Hai"
    static var staticComputedProperty : Int {
        get {
            return Example1.staticStoredProperty
        }
        set {
            //do something i dont know
        }
    }
    static var staticReadOnlyComputedProperty : String {
        get {
            return Example1.staticReadOnlyStoredProperty
        }
    }
}

//enum
enum Example2 {
    static var staticStoredProperty : Int = 10
    static let staticReadOnlyStoredProperty : String = "Hai"
    static var staticComputedProperty : Int {
        get {
            return Example2.staticStoredProperty
        }
        set {
            //do something
        }
    }
    static var staticReadOnlyComputedProperty : String {
        get {
            return Example2.staticReadOnlyStoredProperty
        }
    }
}

//class

class Example3 {
    static var staticStoredProperty : Int = 10
    static let staticReadOnlyStoredProperty : String = "Hai"
    static var staticComputedProperty : Int {
        get {
            return Example3.staticStoredProperty
        }
        set {
            //do something
        }
    }
    static var staticReadOnlyComputedPropety : String {
        get {
            return Example3.staticReadOnlyStoredProperty
        }
    }
    //the below property can be overriden by subclass
    class var overrideableComputedTypeProperty : Int {
        get {
            return 10
        }
    }
}

//example
struct AudioChannel {
    static let thresholdLevel : Int = 10
    static var maxInputlevelForAllChannels = 0
    var currentLevel : Int = 0 {
        didSet {
            print("did set")
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputlevelForAllChannels {
                AudioChannel.maxInputlevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 11
print("maxInputlevelForAllChannels of left: \(AudioChannel.maxInputlevelForAllChannels)")
print("maxInputlevelForAllChannels of right: \(AudioChannel.maxInputlevelForAllChannels)")
