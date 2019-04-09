import UIKit

//PROTOCOL
//tương tự như interface trong java
//nó định nghĩa ra 1 blueprint của methods, properties, and other để được implement bởi 1 đối tượng khác
//đối tượng đó có thể là enum, struct hay class

//nếu 1 class có 1 superclass thì đặt superclass đó ngay sau dấu ":", rồi mới tới protocol


//PROPERTIES REQUIREMENTS
//protocol không định nghĩa properties là stored hay computed properties
//nó chỉ định nghĩa property name và type, cùng với là property đó là getter hay cả getter setter
//do đó mình có thể conform protocol đó với properties là loại nào tuỳ, miễn là nó thoả mãn getter (hay getter setter) của properties của protocol
//properties của protocol là instance property thì ta k thể conform nó với 1 type property???
//property requirement của protocol luôn được định nghĩa bởi var keyword, theo sau là get hoặc get
//example

protocol Person {
    var name: String { get }
}

struct Male : Person {
    //name là 1 instance property bình thường. vì vậy nó cớ setter và getter ngầm định của riêng nó
    //nó cùng tên cùng kiểu với property của protocol Person, do đó nó conform được property name của person
    let name: String
}

//nếu muốn require 1 type property thì protocol phải prefix keyword static trước chữ var
//nếu requirement property là static thì conform property cũng phải là static or class (nếu được 1 class conform)
//ý của từ class thay cho static là nó có thể được override khi nó được kế thừa bởi subclass

protocol Drink {
    static var name: String { get }
}

class MilkTea: Drink {
    class var name: String {
        get {
            return "Milk tea"
        }
    }
}

//Another Example of Properties Requirement

protocol FullyNamed {
    var fullName: String { get }
}

class StarShip: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (self.prefix != nil ? self.prefix! + " " : "") + self.name
    }
}

let starShip1 = StarShip(name: "HCMUS", prefix: "09")
print(starShip1.fullName)


//METHODS REQUIREMENT
//methods requiremented của protocol thì y như method bình thường (có thể là instance or type methods)
//tuy nhiên nó không chứa body của method.
//và nó khôg thể chứa default values cho các parameters của method
//required type method (static method) thì phải luôn luôn bắt đầu với static keyword

//simple example for methods requiremented

protocol RandomNumberGenerator {
    func random() -> Any
}

class IntRandom: RandomNumberGenerator {
    func random() -> Any {
        return Int.random(in: 0...10)
    }
}

let random1 = IntRandom()
print("random of: \(random1.random())")


//MUTATING METHOD REQUIREMENTS
//khi conform muating methods trong class thì không cần dùng chữ muating nữa
//bản thân của class đã là vậy rồi, vì nó là reference type (not value type like enum or struct)

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case on, off
    mutating func toggle() {
        switch self {
        case .on:
            self = .off
        case .off:
            self = .on
        }
    }
}
var lightSwitch = OnOffSwitch.off
print(lightSwitch)
lightSwitch.toggle()
print(lightSwitch)


//Initializer Requirements
//dùng bình thưởng nhuư init bình thường thôi. không có gì khác biệt cả
//khi 1 class conformes initializer requirements đó thì phương thức init đó phải có chữ required phía trước
//class đó có thể conform init requirements bằng designated or convenience init

protocol SomeProtocol {
    init(someparameter: Int)
}

//class implementations of protocol initializer requirements

class SomeClass: SomeProtocol {
    //conform bằng designated init
    required init(someparameter: Int) {
        //some code
    }
}

class SomeClass1 : SomeProtocol {
    init() {
        //do something
    }
    //conform bằng convenience init
    required convenience init(someparameter: Int) {
        //do something
        self.init()
    }
}

//chữ required ở trên đảm bảo rằng subclass của những class này cũng phải implement cái phương thức init đó (để mà conform được protocol)
//example

class SomeSubClass1: SomeClass {
    var someProperty: String
    required init(someparameter: Int) {
        self.someProperty = "Hello"
        super.init(someparameter: someparameter)
    }
}

//nếu là final class thì khi conform init ta không cần thêm chữ required vào trước init của class conform nữa vì
//vì final class không thể có subclass, nên không cần phải đảm bảo subclass cũng phải conform protocol

final class SomeClass2: SomeProtocol {
    init(someparameter: Int) {
        //do something
    }
}

//nếu 1 subclass override một matching designated init của supperclass và
//và subclass đó cũng conform cùng matching init đó của protocol
//thì ta dùng cả override và required ở hàm init đó của subclass
//ví dụ bên dưới

class ClassA {
    //designated init
    init() {
        //do something
    }
}

protocol ProtocolB {
    //init requirement
    init()
}

class Subclass1: ClassA, ProtocolB {
    //vì Subclass1 override lại init() của ClassA nên nó phải có chữ override
    //Subclass1 nó conform ProtocolB nên nó phải có chữ required ở init()
    required override init() {
        //do something
    }
}


//Failable Initializer Requirements
//tương tự, xem trong init section
//một failable init có thể được conform bởi 1 failable or non-failable init
//một non-failable init có thể được conform bơi 1 non-failable or force unwrapped (!) failable init



//Protocol As Type
//protocol cũng là kiểu dữ liệu, nó như interface trong các ngôn ngữ khác

protocol RandomGen {
    func random() -> Any
}

class DoubleRandom: RandomGen {
    func random() -> Any {
        return Double.random(in: 0...1)
    }
}

class Dice {
    var sides: Int
    var generator: RandomGen
    init(sides: Int, generator: RandomGen) {
        self.sides = sides
        self.generator = generator
    }
    func roll() throws -> Int? {
        guard let random = self.generator.random() as? Double else {
            //rerurn nil or throw error
            return nil
        }
        return Int(random * Double(self.sides) + 1)
    }
}

var d6 = Dice(sides: 6, generator: DoubleRandom())

try print(d6.roll() ?? 0)
try print(d6.roll() ?? 0)
try print(d6.roll() ?? 0)
try print(d6.roll() ?? 0)
try print(d6.roll() ?? 0)
try print(d6.roll() ?? 0)



//DELEGATION
//delegate là 1 design pattern mà
//kiểu như lười biếng, không muốn làm.
//đầy 1 vài công việc của mình cho người khác làm
//mà méo cần quan tâm nó làm như thế nào
//có được việc hay là không
//This design pattern is implemented by defining a protocol that encapsulates the delegated responsibilities

//try the quite complex version of SnakeAndLadder game with protocol and delegate


protocol RandomGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}

class SucSac {
    var sides: Int
    var randomGenerator: RandomGenerator
    init(sides: Int, randomGenerator: RandomGenerator) {
        self.sides = sides
        self.randomGenerator = randomGenerator
    }
    func roll() -> Int {
        return Int(self.randomGenerator.random() * Double(self.sides) + 1)
    }
}

protocol GameSucSac {
    var sucSac: SucSac { get }
    func play()
}

//dùng anyobject để chỉ ra rằng. protocol này chỉ có thể được conform bởi CLASS (not struct hay enum)
//nhờ vậy mà ta mới có thể dùng weak ở trong class SnakeAndLadders
//weak chỉ có thể dùng cho instance của class???
protocol GameSucSacDelegate: AnyObject {
    func gameDidStart(_ game: GameSucSac)
    func game(_ game: GameSucSac, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: GameSucSac)
}

class SnakeAndLadders: GameSucSac {
    let sucSac: SucSac = SucSac(sides: 6, randomGenerator: LinearCongruentialGenerator())
    let finalSquare = 25
    var square = 0
    var board: [Int]
    init() {
        //init
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    //ở đây định nghĩa delegate là optional bởi vì không cần thiết phải có nó game mới diễn ra được
    //ở đây nó chỉ đóng vai là gametracker
    weak var delegate: GameSucSacDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let lacsingau = sucSac.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: lacsingau)
            switch square + lacsingau {
            case finalSquare:
                break gameLoop
            case let tongdiem where tongdiem > finalSquare:
                continue gameLoop
            default:
                square += lacsingau
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class GameSucSacTracker: GameSucSacDelegate {
    var numberOfTurns: Int = 0
    func gameDidStart(_ game: GameSucSac) {
        if game is SnakeAndLadders {
            print("Started a new game of Snake and Ladders")
        }
        print("game su dung con suc sac co \(game.sucSac.sides) mat")
    }
    
    func game(_ game: GameSucSac, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Lac duoc \(diceRoll) diem")
    }
    
    func gameDidEnd(_ game: GameSucSac) {
        print("game ended sau \(numberOfTurns) luot choi.")
    }
}

let tracker = GameSucSacTracker()
let game = SnakeAndLadders()
game.delegate = tracker
game.play()


//ADDING PROTOCOL CONFORMANCE WITH AN EXTENSION
//mở rộng 1 kiểu sẵn có để conform 1 protocol

//example

protocol TextRepresentAble {
    var textualDescriptions: String { get }
}

extension SucSac: TextRepresentAble {
    var textualDescriptions: String {
        return "A \(sides) sides-dice"
    }
}

//try to create a new SucSac
let sucsau1 = SucSac(sides: 8, randomGenerator: LinearCongruentialGenerator())
print(sucsau1.textualDescriptions)


//tương tự ta cho game snakeandladders conform protocol textrepresentable

extension SnakeAndLadders: TextRepresentAble {
    var textualDescriptions: String {
        return "A game of Snake and Ladders with \(finalSquare) squares"
    }
}

print(game.textualDescriptions)


//CONDITIONALLY CONFORMING TO A PROTOCOL
//đối với generic type (array, list, ...) thì nó có thể chỉ conform protocol ở trong những trường hợp cụ thể
//ví dụ như kiểu phần tử của nó conform protocol đó thì nó mới conform protocol đó
//để biểu diễn điều đó, ta dùng where clause.
//see generic where clauses

//example

extension Array: TextRepresentAble where Element: TextRepresentAble {
    var textualDescriptions: String {
        let itemAsDes = self.map { $0.textualDescriptions }
        return "[" + itemAsDes.joined(separator: ",") + "]"
    }
}
//đáng nhẽ phải clone deep
//nhưng làm vầy vì lười, để dễ hình dung ra ta đang có 2 phần tử khác nhau của mảng mà thôi
let sucsac2 = sucsau1
let arr1 = [sucsau1, sucsau1]

print(arr1.textualDescriptions)


//Declaring Protocol Adoption with an Extension
//nếu 1 kiểu dữ liệu đã tự nó conform protocol đó rồi mà nó chưa khai báo nó extend protocol đó (adopt)
//thì ta có thể dùng extension để khai báo type đó extend protocol đó
//mà không cần phải khai báo phần định nghĩa

//example

struct Hamster {
    var name: String
    var textualDescriptions: String {
        return "A Hamster named is: \(name)"
    }
}

extension Hamster: TextRepresentAble{}
//như trên ta thấy bên trong phần dấu {} không có gì
//Types don’t automatically adopt a protocol just by satisfying its requirements. They must always explicitly declare their adoption of the protocol.


//Collections of Protocol Types
//protocol có thể được dùng như kiểu dữ liệu, như bàn ở trên
//dĩ nhiên là có thể dùng như kiểu dữ liệu của collection type như là array, list, dictionary ...

//example

let thing: [TextRepresentAble] = [game, sucsau1, Hamster(name: "Mickey")]
for item in thing {
    print(item.textualDescriptions)
}


//PROTOCOL INHERITANCE
//một protocol có thể kế thừa được nhiều protocol khác (như interface thôi - chỉ kế thừa từ 1 supper class, tuy nhiên kế thừa từ nhiều interface khác)

//simple example

protocol PrettyTextrepresentable: TextRepresentAble {
    var prettyTextualDescription: String { get }
}

extension SnakeAndLadders: PrettyTextrepresentable {
    var prettyTextualDescription: String {
        var output = textualDescriptions + ":\n"
        for i in 0..<finalSquare {
            switch board[i] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

print(game.prettyTextualDescription)


//CLASS ONLY PROTOCOL
//bạn có thể giới hạn cho 1 protocol chỉ có thể được implement bởi 1 class (thay vì enum, struct)
//bằng cách cho protocol đó kế thừa từ protocol AnyObject

//example

protocol ClassOnlyProtocol: AnyObject {
    var name: String { get }
}

class SomeClassOne: ClassOnlyProtocol {
    var name: String {
        return "Hi how are you"
    }
}
//struct hay enum không thể implement protocol ClassOnlyProtocol


//PROTOCOL COMPOSITION


//không cần giải thích, xem example là sẽ rõ :))

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct PPerson: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday \(celebrator.name), you are \(celebrator.age)")
}

var nhi = PPerson(name: "Nguyen Thuy Uyen Nhi", age: 20)
wishHappyBirthday(to: nhi)

//để ý parameter celebrator, nó nhận vào Named & Aged
//đây gọi là protocol composition
//nó có nghĩa là sẽ nhận bất cứ kiểu dữ liệu nào mà adopt được 2 protocol là Named và Aged
//ở đây PPerson là 1 struct và nó đã adopt cả Named và Aged, cho nên nó thoả mãn
//dùng Named & Aged: nó chỉ tạo ra 1 temp protocol bao gồm cả 2 protocol Named & Aged.

//another example

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class City: Location, Named {
    var name: String
    init(name: String, lititude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: lititude, longitude: longitude)
    }
}

func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)")
}

let seattle = City(name: "Seattle", lititude: 47.6, longitude: -122.3)
beginConcert(in: seattle)

//như trên ta thấy, hiểu mở rộng ra, ta có thể combine giữa 1 class và 1 protocol
//nó có nghĩa là bất cứ kiểu dữ liệu nào mà có supper class là Location và adopt protocol Named
//ở đây, thằng City nó có supper class là Location và nó adopt protocol Named.
//do đó nó thoả điều kiện


//CHECKING FOR PROTOCOL CONFORMANCE
//use (is & as) to check for protocol conformance

//example

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.141519
    var radius: Double
    init(radius: Double) {
        self.radius = radius
    }
    var area: Double {
        return radius * radius * pi
    }
}

class Country: HasArea {
    var area: Double
    init(area: Double) {
        self.area = area
    }
}

class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

let objects: [AnyObject] = [
    Country(area: 222_888),
    Circle(radius: 2.0),
    Animal(legs: 2)
]
//AnyObject đại diện cho 1 class nào đó

for obj in objects {
    if let objWithArea = obj as? HasArea {
        print("Area is: \(objWithArea.area)")
    } else {
        print("something went wrong")
    }
}


//OPTIONAL PROTOCOL REQUIREMENTS
//optional requirement có nghĩa là khi adopt protocol đó thì ta có thể implement optional requirements đó
//hoặc là không cần implement ( đó là nghĩa của từ optional)
//optional requirements phải được mark với từ optional
//cả protocol và optional requirement phải được mark với @objc
//opbjectc protocol chỉ có thể được adopt bởi 1 class kế thừa từ object-c classes hoặc @objc classes
//chúng không thể được adopt bởi enum or struct
//optional requirement tự chuyển thành kiểu optional
//ví dụ hàm (Int) -> String mà là optional thì nó sẽ trở thành ((Int) -> String)?
//chú ý là nguyên hàm trở thành optional chứ không phải là chỉ mỗi kiểu trả về
//chú ý điều này để dùng trong optional chaining
//NOTE: CHÚ Ý 2 CÁCH VIẾT SAU ĐÂY
//C1: someOptionalMethod(someArgument)?
//cách viết 1 thì ý là hàm someOptionalMethod có kiểu trả về là optional
//C2: someOptionalMethod?(someArgument)
//viết theo cách 2 thì nguyên cái hàm someoptionalMethod là 1 optional. có nghĩa là:
//là hàm someOptionalmethod có thể có or không (=nil)
//nên chú ý điều này

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

//use

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement: Int = 3
}

var counter1 = Counter()
counter1.dataSource = ThreeSource()
for _ in 0..<4 {
    counter1.increment()
    print(counter1.count)
}

//another datasource

class TowardZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        switch count {
        case 0:
            return 0
        case let x where x > 0:
            return -1
        case let x where x < 0:
            return 1
        default:
            return 0
        }
    }
}

counter1.dataSource = TowardZeroSource()
counter1.count = -4
for _ in 0..<4 {
    counter1.increment()
    print(counter1.count)
}


//PROTOCOL EXTENSION
//protocol có thể sử dụng extension để thêm IMPLEMENT methods, init, subscript, computed properties đến TẤT CẢ conforming types của nó
//Protocol extensions can add implementations to conforming types but can’t make a protocol extend or inherit from another protocol.

//simple example

extension RandomGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

let generator1 = LinearCongruentialGenerator()
print("here's a random number: \(generator1.random())")
print("and here's a random boolean: \(generator1.randomBool())")



//PROVIDING DEFAULT IMPLEMENTATIONS
//bạn có thể sử dụng protocol extension để cung cấp default implementations của các requirement (methods, computed properties, ...) của
//của protocol đó. nếu conforming type cung cấp implement của những requirement đó thì implement riêng đó sẽ được dùng
//còn không thì sử dụng default implement đã được định nghĩa bằng protocol extension

//example

extension PrettyTextrepresentable {
    var prettyTextualDescription: String {
        return textualDescriptions
    }
}
//ở trên ta đã cung cấp default getter cho prettyTextualDescription



//ADDING CONSTRAINTS TO PROTOCOL EXTENSIONS
//When you define a protocol extension, you can specify constraints that conforming types must satisfy before the methods and properties of the extension are available.

//very simple example

extension Collection where Element: Equatable {
    func equalAll() -> Bool {
        for ele in self {
            if ele != self.first { return false }
        }
        return true
    }
}

var equalNumbers = [100, 100, 100, 100, 100, 100]
var differentNumbers = [200, 100, 100, 200, 200, 200]
print(equalNumbers.equalAll())
print(differentNumbers.equalAll())
