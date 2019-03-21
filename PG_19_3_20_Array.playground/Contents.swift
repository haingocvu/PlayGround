import UIKit

var _myArr: [Int] = []
print(_myArr.count)
_myArr.append(12)
_myArr.append(24)
print(_myArr.count)
for item in _myArr {
    print(item)
}

//creating an array
var _myArr8 = Array(repeating: 8, count: 8)
print(_myArr8)
var _myArr9 = Array(repeating: 9, count: 9)
print(_myArr9)
var _myArr89 = _myArr8 + _myArr9
print(_myArr89)
//another way to creating an array
var _myArrll = ["Nhi", "Tuyen", "Thanh"]
print(_myArrll)
//count the items of array by using count PROPERTY.
print(_myArrll.count)
print(_myArrll.isEmpty ? "empty" : "full")
_myArrll = []
print(_myArrll.isEmpty ? "empty" : "full")
//add new item to array by using append method
//this method will append new item to the end of the array
_myArrll.append("Linh")
_myArrll.append("Vy")
_myArrll.append("Nhi")
print(_myArrll)
//you can also use + operator to add new items to an array
_myArrll += ["Nga", "Yen"]
print(_myArrll)

//access a child of array by using index
print("my lover is: \(_myArrll[2])")
//or you can update value for the specific item in an array by using index
_myArrll[2] = "Uyen Nhi"
print(_myArrll[2])

//replacing a range of items in an array
_myArrll[0...2] = ["Nhi", "Chi", "Tu", "Giang", "Phuong", "Duong"]
print(_myArrll)

//insert new item into a specific index by using insert method
_myArrll.insert("Hai", at: 1)
print(_myArrll)

//remove a item from an array
let removed = _myArrll.remove(at: 4)
print("I removed: \(removed)")

//remove last item
let lastItem = _myArrll.removeLast()
print("last is: \(lastItem)")

//loop over an array
for item in _myArrll {
    print(item)
}

//if you need the index of each item, using array's enumerated method
for (index, item) in _myArrll.enumerated() {
    print("\(item) is: \(index)")
}
