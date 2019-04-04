import UIKit

//Nested Type
//hay còn gọi là type in type
//nó dùng để xây dựng complex data type

//example

struct BlackjackCard {
    //nested enum SUITE
    enum Suite : Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    //nested enum Rank
    //điểm của lá bài
    //enum Rank có 1 getter là value để lấy ra điểm của lá bài
    enum Rank : Int {
        case two = 2
        case three, four, five, six, seven, eight, nine
        case jack, queen, king, ace
        //nested struct-type
        struct Value {
            var first : Int
            var second : Int?
        }
        var value : Value {
            switch self {
            case .ace:
                return Value(first: 1, second: 11)
            case .jack, .queen, .king:
                return Value(first: 10, second: nil)
            default:
                return Value(first: self.rawValue, second: nil)
            }
        }
    }
    var suite : Suite
    var rank : Rank
    var description : String {
        var output = "Suite is: \(self.suite.rawValue),"
        output += "Rank is: \(self.rank.value.first)"
        if let second = self.rank.value.second {
            output += ", or \(second)"
        }
        return output
    }
}

//dùng thôi
var theAceOfSpade = BlackjackCard(suite: .spades, rank: .ace)
print("theAceOfSpade: \(theAceOfSpade.description)")

//Referring to Nested Types
//To use a nested type outside of its definition context, prefix its name with the name of the type it is nested within:

//example

var heartSymbol = BlackjackCard.Suite.hearts.rawValue
print(heartSymbol)

//very simple? right?
//ok, let's go ahead!
//fighting
