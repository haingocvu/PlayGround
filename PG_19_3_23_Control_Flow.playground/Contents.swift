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
