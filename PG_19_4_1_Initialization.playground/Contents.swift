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
//swift subclass dont inherit their supperclass initializers by default
//nếu hàm init của subclass mà matching (hình như là trùng tên tham số và kiểu dữ liệu tham số với hàm init của super class thì bắt buộc ta phải override
//khi override thì ta có thể override 1 designated init của lớp cha thành convenience init của thằng con
//hoặc ngược lại override 1 convenience của thằng cha thằng designated init của thằng con

//example
class MyVehicle {
    var numberOfWheels = 0
    var description : String {
        return "\(numberOfWheels) wheels"
    }
}

// do class MyVehicle k có phương thức khởi tạo cho nên nó sẽ nhận default initializer
var myVehicle1 = MyVehicle()
print("Vehicle: \(myVehicle1.description)")

class Bicycle : MyVehicle {
    var color : String
    override init() {
        //setting value for itself property
        self.color = "blue"
        //call super class init
        super.init()
        //custom value
        numberOfWheels = 2
    }
    override var description: String {
        return "\(numberOfWheels) wheels and \(color)"
    }
}

//hàm init của Bicycle override lại init của MyVehicle. do đó ta phải sử dụng override
var bicycle1 = Bicycle()
print("Bicycle: \(bicycle1.description)")

//AUTOMATIC INITIALIZER INHERITANCE
//GIẢ SỬ bạn đã gán default value cho tất cả các properties bạn đã define trong subclass
//thì 2 rule sau đây sẽ được áp dụng:

//RULE 1:
//nếu bạn cưa khai báo bất cứ designated initializer nào cho subclass thì subclass sẽ tự động kế thừa tất cả designated initializers của thằng cha
//key to remember: con tay trắng thì xin cha

//RULE 2:
//nếu subclass có TẤT CẢ designated initializers của lớp cha.
//bất chấp nó có được bằng rule 1: kế thừa
//hoặc là nó có được bằng cách custom implement (override)
//thì nó sẽ kế thừa tất cả convenience initializers của lớp cha
//key to remember: được voi đòi tiên
//lấy hết rồi còn đòi lấy thêm

//exmaple

class Food {
    var name : String
    //designated
    init(name : String) {
        self.name = name
    }
    //convenience init
    convenience init() {
        //giải thích tại sao phải để chữ convenience ở đầu hàm init này
        //lý do là nếu k có chữ convenience thì hàm init này là 1 designated initializer
        //mà như ta biết thì designated initializer không thể nào delegate (call) cùng cấp được (call init của chính nó)
        //nó phải delegate up (call lên lớp cha). cho nên phải có annotation @convenience ở đầu hàm init này để ám chỉ nó là convenience init
        //ok?
        self.init(name: "unnamed")
    }
}

//let take some sample on Food class
var food1 = Food(name: "apple")
print(food1.name)
var food2 = Food()
print(food2.name)

//RecipeIngredient will inherit Food

class RecipeIngredient : Food {
    var quantity : Int
    //designated init của ipeIngredient
    //bên trong hàm có delegate up đến lớp cha (food)
    init(name : String, quantity : Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    //ở đây ta sẽ override hàm designated init của thằng cha (food) thành convenience init của thằng con (recipeingredient)
    convenience override init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

//khi này theo rule 2 ở trên thì thằng RecipeIngredient sẽ có hàm convenience init của thằng cha (food)
//do đó t mới có cái hay ho sau
var recipe1 = RecipeIngredient()
print(recipe1.quantity)

//amazing, right?

//tiếp theo ta sẽ có class Shopping List Item kế thừa class RecipeIngredient

class ShoppingListItem : RecipeIngredient {
    var purchased = false
    var description : String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

//vì class ShoppingListItem đã gán giá trị cho tất cả các property của nó by default
//nó k implement bất cứ designated init nào do đó nó kế thừa tất cả designated init của thằng cha (RecipeIngredient)
//vì nó kế thừa tất cả designated init của thằng cha cho nên nó cũng kế thừa tất cả convenience init của thằng cha theo như rule 2

var breakFastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6)
]
breakFastList[0].name = "orange juice"
breakFastList[0].purchased = true
for item in breakFastList {
    print(item.description)
}

//Failable Initializers
//để define failable init ta thêm ? sau chữ init (init?)
//có thể có failable và non-failable init có cùng tham số và kiểu dữ liệu của tham số
//để xác định hàm init đó failure, ta return nil trong body của init đó

//ví dụ như hàm convert sang Int

var wholeNumber : Double = 12345.0
var pi = 3.14159

var rs1 = Int(exactly: wholeNumber)
if let _rs1 = rs1 {
    print("convert ok: \(_rs1)")
}

var rs2 = Int(exactly: pi)
if rs2 == nil {
    print("can not convert : \(pi)")
}

struct Animal {
    var species : String
    init?(species : String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}

var someCreature = Animal(species: "Giraffi")
if let giraffi = someCreature {
    print("an animal was initialized with a species of \(giraffi.species)")
}

let anonymousCreature = Animal(species: "")
if anonymousCreature == nil {
    print("anonymous can't be initialized")
}

//failable init for enum

enum TemperatureUnit {
    case kelvin
    case Censius
    case Fahrenheit
    init?(symbol : Character) {
        switch symbol {
        case "F":
            self = .Fahrenheit
        case "C":
            self = .Censius
        case "K":
            self = .kelvin
        default:
            return nil
        }
    }
}

var fahrenheitUnit = TemperatureUnit(symbol: "F")
if let f = fahrenheitUnit {
    print("init ok: \(f)")
}

var xx = TemperatureUnit(symbol: "L")
if xx == nil {
    print("failed to init temperature: X")
}

//ENUM failable init with rawValue

enum Temp : Character{
    case Kelvin = "K"
    case Censius = "C"
    case Fahrenheit = "F"
}

var TinF = Temp(rawValue: "F")
if let f = TinF {
    print("init success: \(f)")
}

var xxx = Temp(rawValue: "X")
if xxx == nil {
    print("init failed of X")
}

//Failable Init có thể delegate across or up

class Product {
    var name : String
    init?(name : String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class CartItem : Product {
    var quantity : Int
    init?(name: String, quantity : Int) {
        if quantity < 1 {
            return nil
        }
        self.quantity = quantity
        super.init(name: name)
    }
}

//check thử

var okCartItem = CartItem(name: "Apple", quantity: 2)
if let okcart = okCartItem {
    print("ok. Item: \(okcart.name) - quantity: \(okcart.quantity)")
}

var nonameCart = CartItem(name: "", quantity: 2)
if nonameCart == nil {
    print("failed to init cart with noname")
}

var zeroQuantityCart = CartItem(name: "Strawberry", quantity: 0)
if zeroQuantityCart == nil {
    print("failed to init cart with zero item")
}

//Override Failable Init tương tự như override init khác
//ta có thể override 1 failable init thành 1 un-failable init

class Document {
    var name : String?
    init() {
    }
    init?(name : String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class AutomaticallyNamedDocument : Document {
    override init() {
        super.init()
        self.name = "Untitled"
    }
    
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "Untitled"
        } else {
            self.name = name
        }
    }
}

//You can use forced unwrapping in an initializer to call a failable initializer from the superclass as part of the implementation of a subclass’s nonfailable initializer.

class UntitledDocument : Document {
    override init() {
        super.init(name: "Untitled")!
    }
}

//NOTE
//ngoài ra ta có thể dùng init!
//tương tự như cách ta dùng optional type thôi
//unwrapped ngâm định
//ta không cần phải dùng if let đồ nữa

//You can delegate from init? to init! and vice versa, and you can override init? with init! and vice versa. You can also delegate from init to init!, although doing so will trigger an assertion if the init! initializer causes initialization to fail.

//Required Initializers

///Write the required modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer:
//Không cần viết override
//You do not write the override modifier when overriding a required designated initializer

class SomeClass {
    required init() {
    }
}

class SomeSubclass : SomeClass {
    required init() {
    }
}

//Setting a Default Property Value with a Closure or Function

