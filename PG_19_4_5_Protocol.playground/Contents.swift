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
