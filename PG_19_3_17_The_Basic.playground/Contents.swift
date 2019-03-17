import UIKit

let binaryInteger = 0b10001
print(binaryInteger)

//Int converion
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
print(twoThousandAndOne)
print(type(of: twoThousandAndOne))

//Floating point conversion
//Integer to double
let _integerOfSix = 6
let _sampleDouble = 3.141519
let intToDouble = Double(_integerOfSix) + _sampleDouble
print(intToDouble)

//Double to Int
let _pi = 3.141519
let _doubleToInt = Int(_pi)
print(_doubleToInt)

//this will not cause an error because number literals dont have an explicit type in and of themselves
let _doubleValue = 3.141519 + 6
print(_doubleValue)

//Type Aliases
typealias audioSample = UInt16
var maxAmplitudeFound = audioSample.min
print(maxAmplitudeFound)

//boolean
let _true = true
print(_true)
if _true {
    print("true nhe")
}

//Tuples
//create a tuple
let _httpStatusCode = (404, "not found")
//decompose a tuple's content
let (statusCode, description) = _httpStatusCode
print("please check your connection: \(statusCode) - \(description)")
//or use directly with index
print("Please check your internet: \(_httpStatusCode.0) - \(_httpStatusCode.1)")
//Tuple like object type in other language by replacing the {} by ()???
//naming individual element in a tuple
let _httpOK = (statusCode: 100, description: "OK")
print("connected: \(_httpOK.statusCode) - \(_httpOK.description)")

//use tuple in the function return multiple value

enum MyError: Error {
    case GoAway
    case BienDi
}

func _returnMultipleValue(name: String) throws -> (statusCode: Int, inDetail: String) {
    if name == "Giang" {
        throw MyError.GoAway
    }
    return (1, "not good")
}

do {
    let _rs = try _returnMultipleValue(name: "Giang")
    print("My feeling: \(_rs.statusCode) - \(_rs.inDetail)")
} catch MyError.GoAway {
    print("g cut ngay")
}

//optional value
var _myString: String? = "10"
print(_myString ?? "")
//nil is null?. only use for optional value
_myString = nil
if _myString == nil {
    print("lam on init data for it")
}

//optional binding
if let firstNum = Int("10"), let sencondNum = Int("42"), firstNum < sencondNum && sencondNum <= 100 {
    print("\(firstNum) < \(sencondNum) < 100")
}

//Implicitly unwrapped optional
//tạo ra optional value mà khi sử dụng không cần phải unwrapped nó.
//chỉ sử dụng khi xác định là nó luôn luôn có giá trị
//sử dụng ! thay cho ? sau kiểu dữ liệu
var _myImplicitlyIUnwrappedOptional: String! = "hello, how are you"
print(_myImplicitlyIUnwrappedOptional)
let _mytest11: String = _myImplicitlyIUnwrappedOptional
print(_mytest11)
//bản thân của nó vẫn là optional value. và nó sẽ được tự động unwrapped khi cần. ví dụ như trên ta gán nó vào 1 kiểu String (non-optional) thì nó sẽ được unwrapped tự động và kết qủa là ta thấy ở console.
//another example
let _newString = "new String nha: " + _myImplicitlyIUnwrappedOptional
print(_newString)
//implicitly unwrapped optional is used the same as normal optional value
//example
if let _rs = _myImplicitlyIUnwrappedOptional {
    print(_rs + " hello")
}

//Nói chung không nên sử dụng implicitly unwrapped optional. cứ sử dụng ? sẽ an toàn hơn !

//Assertion. if assertion lead to failure, the program will be terminated
let _num = 12
assert(_num > 8, "failed assert")
print("success assert")
//another example for assertion
if (_num > 10) {
    print("assert OK")
} else {
    assertionFailure("Assert failed")
}

//preconditions is the same Assertion. But Preconditions use in production.
//example for preconditions
let _condition: Bool = true
switch _condition {
case true:
    print("OK. it's true")
default:
    preconditionFailure("Failed roi nhe.")
}
