import UIKit

//for in loop
var _myArr = ["Hai", "Nhi", "Giang"]

for value in _myArr {
    print(value)
}

//use for-in in a dictionary
var _myDic = ["wife" : "Nguyễn Thuỵ Uyển Nhi", "husband" : "Vũ Ngọc Hải"]

for (relationship, name) in _myDic {
    print("\(relationship), \(name)")
}

//for-in with numberic ranges
var _count = 0
for _ in 0..<9 {
    _count += 1
}
print("total: \(_count)")

//use stri stri stride function in for-in loop
//nó như for integer i = 0, i < 9, i+=2
//easy
//not inluding to (9)
for item in stride(from: 0, to: 9, by: 3) {
    print(item)
}

//using closed range
//stride(from, through, by) to include the through
for item in stride(from: 0, through: 9, by: 3) {
    print(item)
}

//WHILE LOOP

//WHILE: evaluates its condition of the start
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)

board[03] = +08
board[06] = +11
board[09] = +09
board[10] = +02
board[14] = -10
board[19] = -11
board[22] = -02
board[24] = -08

var diceRoll = 0
var currentSquare = 0
var count = 0
while currentSquare < finalSquare {
    //random a diceroll
    diceRoll = Int.random(in: 1...4)
    //move to the rolled amount
    currentSquare += diceRoll
    //check whether the player is on the board
    if currentSquare < board.count {
        //move up or down
        currentSquare += board[currentSquare]
    }
    count += 1
}
print("you take \(count) times to complete the game.")

//repeat while
//the same as do while in other language
var diceRoll1 = 0
var currentSquare1 = 0
var count1 = 0
repeat {
    //move up or down
    currentSquare1 += board[currentSquare1]
    //random
    diceRoll = Int.random(in: 1...4)
    //move to the rolled amount
    currentSquare1 += diceRoll
} while currentSquare1 < finalSquare

//if else
let name = "Nguyễn Thuỵ Uyển Nhi"
if name == "Nguyễn Thuỵ Uyển Nhi" {
    print("\(name) is my lover")
} else {
    print("\(name) is not my lover")
}

//switch case
//very simplest example of switch
let _alphabet : Character = "a"
switch _alphabet {
case "a":
    print("the first letter of alphabet")
case "z":
    print("the last letter of alphabet")
default:
    print("other letter")
}

//matching compound case

switch _alphabet {
case "a",
     "A":
    print("the first letter of alphabet")
default:
    print("the other letter of alphabet")
}

//Interval Matching (ranged Matching)
let _point = 0
switch _point {
case let x where x == 0:
    print("xep loai kem, diem: \(x)")
case 1...4:
    print("yeu")
case 5:
    print("trung binh")
case 6...7:
    print("Kha")
case 8...9:
    print("Gioi")
case 10:
    print("xuat sac")
default:
    print("tao meo biet")
}

//use tuples
// underscore (_) to match any possible value
let _myPoint = (1, 3)
switch _myPoint {
case (0, 0):
    print("Point is at the orighin")
case (_, 0):
    print("point is at x-axis")
case (0, _):
    print("point is at y-axis")
case (-2...2, -2...2):
    print("point is inside the box")
default:
    print("point is outside the box")
}

//Value Binding
//a switch case can name the value or values it matches to a temporary constans or variables, for use in the case's body
//this called value binding
switch _myPoint {
case (let x, 0):
    print("point is on the x-axis with x = \(x)")
case (0, let y):
    print("point is on the y-axis with y = \(y)")
case (let x, let y):
    print("point is \(x) : \(y)")
}

//Where
let _myPoint1 = (1, -1)
switch _myPoint1 {
case let (x, y) where x == y:
    print("point is on the line with x = y")
case let (x, y) where x == -y:
    print("point is on the line with x = -y")
default:
    print("I dont know")
}

//Compound cases and data binding
//phải cùng số lượng biến, cùng tên biến và cùng kiểu dữ liệu
let _myPoint2 = (8, 0)
switch _myPoint2 {
case (let distance, 0), (0, let distance):
    print("point is on an axis, with \(distance) from the origin")
default:
    print("I dont know!!")
}

//continue statement
//continue: bỏ qua các dòng lệnh phía sau. tiếp tục tới vòng lặp tiếp
let _myC : [Character] = ["a", "b", "c", "e", "f"]
var _result = ""

for item in _myC {
    switch item {
    case "a", "e":
        continue
    default:
        _result += String(item)
    }
}
print(_result)

//break: exit khỏi control statement ngay lập tức
//control statement có thể là if, switch, loop, ...
//nó khác với continue là quay lại vòng lặp tiếp theo ( chỉ là loop chứ k chứa if hay switch)
//example for break

//break in loop
//exit the loop when reach to break statement
var num = 0
var total = 0
while num < 10 {
    total += num
    num += 1
    if num == 5 {
        break
    }
}
print("total is: \(total)")

//breack in switch statement
let _c : Character = "z"
switch _c {
case "a":
    print("a")
default:
    print("t deo biet")
    break
}

//dont need to use break in switch statement

//fallthrough use in switch statement. nó nhảy luôn vô body của case tiếp theo mà k cần check condition
//nói chung là không cần dùng. biết cho vui
var rs = ""
let cc : Int = 2
switch cc {
case 2:
    rs += "thu 2 "
    fallthrough
case 10:
    rs += "t deo biet"
default:
    break
}
print(rs)

//nói chúng là chỉ cho vui. chả có tác dụng

//Labeled Statement
//sử dụng kết hợp vs break và continue. nhằm làm cho break và continue trở nên clear hơn
//example snakes ladders
let finalSquare2 = 25
var board2 = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square2 = 0
var diceRoll2 = 0
var count2 = 0
gameLoop : while square2 != finalSquare2 {
    diceRoll2 = Int.random(in: 1...4)
    count2 += 1
    switch square2 + diceRoll2 {
    case finalSquare2:
        break gameLoop
    case let x where x > finalSquare2:
        continue gameLoop
    default:
        square2 += diceRoll2
        square2 += board2[square2]
    }
}
print("you take \(count2) times to complete the game")


//guard is the same as if
//but guard always have an else block
//if the else block occur, you must write the code to exit the block where guard statement placing (use return, continue, break, throw, fatalError
//example
var _loverAge = 16
func checkIfDiTu(age: Int) -> String {
    guard age >= 18 else {
        return "di tu roi thang ngu"
    }
    return "thom roi"
}
print(checkIfDiTu(age: _loverAge))

//guard with optional value
func checkAge(age: Int?) {
    //make sure age is not nil
    guard let _age = age else {
        return
    }
    print("tuoi la: \(_age)")
}

checkAge(age: 18)

//guard else kiểu như là: chắc chắn rằng ... nếu không thì ...
//chắc chắn con kia từ 18 tuổi nếu không thì đi tù sml
//chắc chắn là có connection, nếu không thì ném ra lỗi


//Checking API Availability
guard #available(iOS 10, macOS 10.12, *) else {
    print("old version")
    fatalError("too old version")
}
print("new version")
