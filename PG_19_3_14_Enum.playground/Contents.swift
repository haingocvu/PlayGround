import UIKit

enum Rank : Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "your rank is ace"
        case .jack:
            return "your rank is jack"
        case .queen:
            return "your rank is queen"
        case .king:
            return "your rank is king"
        default:
            return "your rank is: " + String(self.rawValue)
        }
    }
}

var ace = Rank.ace
print(ace)
print(ace.simpleDescription())

//function to compare 2 rank
func isRankHigher(yourRank: Rank, rankToCompare: Rank) -> Bool {
    if yourRank.rawValue <= rankToCompare.rawValue {
        return true
    }
    return false
}

var _compara = isRankHigher(yourRank: Rank.ace, rankToCompare: Rank.four)
if _compara {
    print("Your rank is higher than the other one")
} else {
    print("your rank is lower than the other one")
}

//init Rank from rawvalue
if let convertedRank = Rank(rawValue: 3) {
    let simpleDescription = convertedRank.simpleDescription()
    print(simpleDescription)
}


//another example for enum
//if no rawvalue, don't need to provide the type of Enum. dont need to provide the rawvalue
enum Suit {
    case spades, hearts, diamonds, clubs
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "your Suit is: Spades"
        case .hearts:
            return "your Suit is: Hearts"
        case .diamonds:
            return "your Suit is: Diamonds"
        case .clubs:
            return "your Suit is: Clubs"
        }
    }
    func getColor() -> String {
        switch self {
        case .spades, .clubs:
            return "Your color is: Black"
        case .diamonds, .hearts:
            return "Your color is: Red"
        }
    }
}

var _mySuit: Suit = .hearts
print(_mySuit.simpleDescription())
print(_mySuit.getColor())


//another way to use enum
enum ServerResponse {
    case result(String, String)
    case failure(String)
    case sayHello(String)
}

var success = ServerResponse.result("6:00 am", "8:00 pm")
var failure = ServerResponse.failure("Out of cheese")
var sayHello = ServerResponse.sayHello("Good morning")

switch sayHello {
    case let .result(sunrise, sunset):
        print("Sunrise is at \(sunrise). sunset is at \(sunset)")
    case let .failure(err):
        print("Failure: \(err)")
    case let .sayHello(text):
        print("It said: \(text)")
}

//Struct
//the most important different between struct and class is:
//struct is passed as copied
//class is passed by reference
struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "the \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}

var threeOfSpades = Card(rank: .three, suit: .spades)
var threeOfSpadesDescription = threeOfSpades.simpleDescription()
print(threeOfSpadesDescription)
