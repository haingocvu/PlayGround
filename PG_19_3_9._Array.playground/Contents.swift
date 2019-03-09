import UIKit

var _int = 10
var _string = "Hello"
var _intString = _string + String(_int)

func calcNumOfApples() -> Int {
    return _int
}

//another way to include int in string
var _intString2 = "I have \(_int) apples"
var _intString3 = "I have \(calcNumOfApples()) apples"

//basic create a array
var _myArr : [Any] = ["Nhi", "Nguyen", "Thuy", "Uyen"]
var _theFirstChild = _myArr[0]

//create associate array
var _myAssArr : [String : Any] = [
    "name" : "Nguyen Thuy Uyen Nhi",
    "age" : 19,
    "lover" : "Vu Ngoc Hai"
]
var _sayHello = "The lover of \(_myAssArr["name"] ?? "Nguyen Thuy Uyen Nhi") is: \(_myAssArr["lover"] ?? "Vu Ngoc Hai")"

//add new item to basic array
_myArr.append(15)

//add new item to associate array
_myAssArr["newItem"] = "love together"
print(_myAssArr)

//create an empty basic array
var _myEmptyBasicArr = [Any]()
_myEmptyBasicArr.append("first")
_myEmptyBasicArr.append("seconds")
print(_myEmptyBasicArr)

//create an empty associate array
var _myEmptyAssociateArray = [String : Any]()
_myEmptyAssociateArray["name"] = "Nhi"
_myEmptyAssociateArray["age"] = 19
_myEmptyAssociateArray["lover"] = "Vu Ngoc Hai"
print(_myEmptyAssociateArray)

//empty an exists array
_myEmptyBasicArr = []
print(_myEmptyBasicArr.count)

//empty an exists associate array
_myEmptyAssociateArray = [:]
print(_myEmptyAssociateArray.count)
