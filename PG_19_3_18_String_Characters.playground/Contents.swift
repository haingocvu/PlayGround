import UIKit

//special characters
var _stringIncludeDoubleQuotation = "\"I love you - She said\""
print(_stringIncludeDoubleQuotation)

//heart symbol
let _heartSymbol = "\u{1F496}"
print(_heartSymbol)

//init an empty string.
//way 1.very simple
var _emptyString1 = ""
//way 2.
var _emptyString2 = String()

//check if a string is empty
//use isEmpty. Please not that isEmpty is a property not method!!!!!
if _emptyString2.isEmpty {
    print("nothing to display")
} else {
    print(_emptyString2)
}

//String Mutability
//by using a let before a variable's name
let _mutabilityString = "Cant change"
//uncommented the below line will case an error because the mutability String cant be changed
//_mutabilityString += "after changed"
//String are value type not reference

//woriking with characters
//loop over a string
for item in _mutabilityString {
    print(item)
}
//create a character
let _myCharacter: Character = "!"
print(_myCharacter)
//String can be constructed by passing an array of character
let _arrChars: [Character] = ["h", "i", "h", "o", "w", "a", "r", "e", "y", "o", "u"]
let _stringInitFromAnArrayOfCharacter = String(_arrChars)
print(_stringInitFromAnArrayOfCharacter)

//concat a string and character
var _string1 = "hi, "
var _string2 = "how are you today"
var _string12 = _string1 + _string2
print(_string12)
//use +=
_string1 += _string2
print(_string1)

//append a character to a string.
let _aCharacter: Character = "?"
_string1.append(_aCharacter)
print(_string1)

//String Interpolation
var _myName = "Nguyen Thuy Uyen Nhi"
var _hiNhi = "Hi \(_myName)"
print(_hiNhi)

//Extended Grapheme Clusters
//mỗi ký tự (character) mà chúng ta thấy trên màn hình là sự combined của 1 or nhiều unicode scalar. cho nên mới nói. k phải cứ 1 unicode scalar sẽ tương ứng với 1 character, mà là có thể nhiều unicode scalar sẽ combine với nhau để tạo ra 1 character
//example: to create an "é" character
let _way1 = "\u{E9}"
let _way2 = "\u{65}\u{301}"
print(_way1)
print(_way2)
//the two above lines result the same output. amazing.

//example for korean
var precompress = "\u{D55C}"
print(precompress)
var decompress = "\u{1112}\u{1161}\u{11AB}"
print(decompress)

//counting character
//nó không đếm dấu
var _iloveu = "I Love You"
print(_iloveu.count)
_iloveu += "\u{301}"
print(_iloveu)
print(_iloveu.count)

//access and modify a string
//cant acc the string's character by using interger index. because swift string is using unicode scalar cluster.
//you dont know exactly unicode scalar using to combine a character.
//example for access the specific character in a string
let _myString = "chào em nha Nhi"
let _startingCharacter = _myString[_myString.startIndex]
print(_startingCharacter)
let _charAfterStaringIndex2Offset = _myString[_myString.index(_myString.startIndex, offsetBy: 2)]
print(_charAfterStaringIndex2Offset)
//end character
let _endingCharacter = _myString[_myString.index(before: _myString.endIndex)]
print(_endingCharacter)

//loop over a string using indeces
for index in _myString.indices {
    print(_myString[index])
}

//insert and remove
//insert a singgle character
var _beforeString = "hi. how are you today"
_beforeString.insert("?", at: _beforeString.endIndex)
print(_beforeString)
_beforeString.insert(contentsOf: "good morning, ", at: _beforeString.startIndex)
print(_beforeString)
//insert nó không đè lên. nó chỉ insert vào và đẩy cái sẵn có đi

//remove a single character
_beforeString.remove(at: _beforeString.index(before: _beforeString.endIndex))
print(_beforeString)

//remove a range of string
let _range = _beforeString.startIndex..<_beforeString.endIndex
_beforeString.removeSubrange(_range)
if _beforeString.isEmpty {
    print("before string is empty")
} else {
    print("before string " + _beforeString)
}

//Substring
//khi bạn get 1 phần của string thì bạn nhận được substring. substring not string. substring thì shared memory với original string. nó tối ưu performance.
//nhưng nó tồn tại thời gian ngắn. nếu muốn dùng lâu dài thì phải convert sang string và lưu vào 1 biến khác
//in action
//sử dụng substring nếu bạn không mướn thay đổi value của nó
//ngược lại thì convert sang String?
//example
var ex10 = "hi, how are you"
let _endIndex = ex10.firstIndex(of: ",") ?? ex10.endIndex
var _subString1 = ex10[..<_endIndex]
print(_subString1)
var _sbString1ToString = String(_subString1)
print(_sbString1ToString)

//comparing String
//there are 3 ways to compare string
//Way1: String and Character Equality
var str1 = "this is me"
var str2 = "this is me"
if str1 == str2 {
    print("str 1 = str 2")
}
//Two String values (or two Character values) are considered equal if their extended grapheme clusters are canonically equivalent. Extended grapheme clusters are canonically equivalent if they have the same linguistic meaning and appearance, even if they’re composed from different Unicode scalars behind the scenes.
let _str11 = "caf\u{E9}"
let _str22 = "caf\u{65}\u{301}"
if _str11 == _str22 {
    print("str11 = str22")
}
//NOTE: below strings not equal. one's latin and the other is Russian
let _AInLatin = "\u{41}"
let _AInRussian = "\u{0410}"
if _AInLatin == _AInRussian {
    print("AinLAtin is equal AinRussian")
} else {
    print("AinLAtin is not equal AinRussian")
}
//Way2, Way3: prefix and suffix equality
//the same as the above. using hasPrefix and hasSuffix
//these function return a Boolean value
//example
let _myLovers = [
    "Nguyễn Thuỵ Uyển Nhi",
    "Trần Thị Tuyến",
    "Nguyễn Thị Lan Anh",
    "Trần Thị Xuân Thanh",
    "Huỳnh Thị Ngọc Anh",
    "Nguyễn Thị Bích Ngọc"
]

var _countLastNameStartWithNguyen = 0
var _countFirstNameStartWithAnh = 0
for name in _myLovers {
    if name.hasPrefix("Nguyễn") {
        _countLastNameStartWithNguyen += 1
    }
    if name.hasSuffix("Anh") {
        _countFirstNameStartWithAnh += 1
    }
}

print("số người họ Nguyễn là \(_countLastNameStartWithNguyen)")
print("số người tên Anh là \(_countFirstNameStartWithAnh)")


//Unicode representation
//see below
let _dog = "Dog‼🐶"

//utf8
for codeUnit in _dog.utf8 {
    print("\(codeUnit) ", terminator: "")
}

print("")

//utf16
for codeUnit in _dog.utf16 {
    print("\(codeUnit) ", terminator: "")
}

print("")

//unicode scalar
for scalar in _dog.unicodeScalars {
    print("\(scalar)", terminator: "")
}

print("")

//to print the scalar value
for scalar in _dog.unicodeScalars {
    print("\(scalar.value) ", terminator: "")
}
