import UIKit

//basic use of switch and for in
var _totalPoint = 0
var _pointsOfClass : [Int] = [
    10,
    20,
    30,
    80,
    60,
    50,
    70,
    88
]
for _item in _pointsOfClass {
    if _item > 50 {
        _totalPoint += _item
    }
}
print(_totalPoint)

//optional value
var _myOptionalValue : String?
print(_myOptionalValue == nil)

//use if let to compare to nil and unwrapped an optional value
func sayHello(name: String?) -> String {
    var rs = "Anonymous"
    //very easy to compare and unwrapped an optional value
    //use if let
    if let _name = name {
        rs = _name
    }
    return String(format: "hi %@", rs)
}
sayHello(name: nil)

//another way to handle optional values
//use ?? to provide a default value when optional value is nil
//?? use to unwrapped and provide an optional value if the variable is nil
func sayHelloAnotherWay(name: String?) -> String {
    return String(format: "Hello %@", name ?? "Anonymous")
}
sayHelloAnotherWay(name: nil)

//switch case in swift
func findLover(text : String?) -> String {
    var rs : String?
    if let txt = text {
        switch txt {
        case let t where t.hasSuffix("Nhi"):
            rs = String(format: "%@ is the lover of Vu Ngoc Hai", t)
        default:
            rs = "next"
        }
    }
    return rs ?? "next"
}

print(findLover(text: "Uyen Nhi"))

let interestingNumber = [
    "prime" : [2, 3, 5, 7, 11, 13],
    "fibonacci" : [1, 1, 2, 3, 5, 8],
    "square" : [1, 4, 9, 16, 25]
]

var _largest = Int.min
var _largestType : String?

for (type, numbers) in interestingNumber {
    for number in numbers {
        if number > _largest {
            _largest = number
            _largestType = type
        }
    }
}
print(_largest)
if let _lt = _largestType {
    print(_lt)
}

//use while
var _n = 2
while _n * 4 < 100 {
    _n *= 4
}
print(_n)

//use repeat while
var _m = 3
repeat {
    _m *= 3
} while _m < 32
print(_m)

//use ..<
var _total = 0
for number in 0..<10 {
    _total += number
}
print(_total)

//use ...
var _total2 = 0
for num in 0...10 {
    _total2 += num
}
print(_total2)

//function
func demoFunc(_ name: String?, ageInYear age: Int?) -> String {
    var _rs: String?
    if let _name = name, let _age = age {
        _rs = "Hi \(_name). your age is \(_age)"
    }
    return _rs ?? "hi anonymous"
}

print(demoFunc("Hai Vu", ageInYear: 29))

//multiple return
func calculateStatistics(numbersOfInt numbers: [Int]?) -> (min: Int?, max: Int?, sum: Int?) {
    var min: Int?
    var max: Int?
    var sum: Int?
    if let nums = numbers {
        min = Int.max
        max = Int.min
        sum = 0
        for num in nums {
            if num < min! {
                min = num
            }
            if num > max! {
                max = num
            }
            sum! += num
        }
    }
    return (min, max, sum)
}

var rs = calculateStatistics(numbersOfInt: [2, 10, 3, 1, 9, 8, 4, 5, 6])
print("min is \(rs.min ?? 0). max is \(rs.max ?? 0). sum is: \(rs.sum ?? 0)")

//nested function
func returnFitteen() -> Int {
    var rs = 10
    func add() -> Void {
        rs += 5
    }
    add()
    return rs
}
print(returnFitteen())

//function rerturn another function
func makeIncrementer() -> ((Int?) -> Int?) {
    func addOne(num: Int?) -> Int? {
        return num! + 1
    }
    return addOne
}
var incrementer = makeIncrementer()
print(incrementer(10) ?? 0)

//function can take another function as one of its arguments
func hasAnyMatches(list: [Int]?, condition: (Int) -> Bool) -> Bool {
    if let _list = list{
        for num in _list {
            if condition(num) {
                return true
            }
        }
    }
    return false
}

func lessThanTen(num: Int) -> Bool {
    if num < 10 {
        return true
    }
    return false
}

print(hasAnyMatches(list: [10, 30, 60, 9, 20, 18, 21, 32], condition: lessThanTen))

//closure
func makeIncrementerByOne() -> () -> Int {
    var count = 0
    func incrementByOne() -> Int {
        count += 1
        return count
    }
    return incrementByOne
}
var myIncrementerByOne = makeIncrementerByOne()
print(myIncrementerByOne())
print(myIncrementerByOne())
print(myIncrementerByOne())

var _myNums = [2, 3, 5, 1, 6, 8]
var _mappedNums = _myNums.map({
    (num: Int) -> Int in
    var rs = num
    if num % 2 != 0 {
        rs = 0
    }
    return rs
})
print(_mappedNums)

//shorted
var _mappedNums2 = _myNums.map({
    num in num * 2
})

print(_mappedNums2)
