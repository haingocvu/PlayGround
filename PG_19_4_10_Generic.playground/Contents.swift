import UIKit

//GENERIC
//generic là sức mạnh của swift

//GENERIC FUNCTIONS
//generic functions là functions có thể work với any type

//example
func SwapTwoValue<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

var a = 10
var b = 5
SwapTwoValue(&a, &b)
print("now the value of a is: \(a) and b is: \(b)")
//kiểu dữ liệu T sẽ được infer ta từ kiểu dữ liệu của parameter ta truyền vào function
//trong trường hợp trên kiểu dữ liệu T sẽ là Int


//GENERIC TYPES
//generic types là custom classes, tructs, enumerations mà có thể work với any type. tương tự như Array, Dictionary

//bây giờ ta thử tạo ra 1 generic type tương tự như Array, gọi là Stack
//theo quy tắc có thể appened vào cuối và chỉ có thể lấy ra từ cuối của collection
//theo quy tắc Last-In First-Out
//quy tắc này sử dụng trong UINavigationController

//trước tiên thử làm 1 Non-Generic Stack với Int trước

struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}


//bây giờ làm generic version cho thằng Stack nhé

struct Stack<T> {
    var items = [T]()
    mutating func push(_ item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}

//thử dùng generic Stack này với liểu String xem sao

var myCrushes = Stack<String>()
myCrushes.push("Giang")
myCrushes.push("Linh")
myCrushes.push("Anh")
myCrushes.push("Tu")
myCrushes.push("Nga")
myCrushes.push("Tien")
myCrushes.push("Nhi")

let nhi = myCrushes.pop()
print(nhi)


//EXTENDING A GENERIC TYPE
//khi extend 1 generic type thì không cần ghi ra kiểu dữ liệu generic của parameter
//tuy nhiên ta vẫn dùng được kiểu dữ liệu generic của parameters bên trong body của extension
//extending có thể dùng chung với where clause để chỉ rõ điều kiện rằng:
//the extended type must satisfy in order to gain the new functionality

extension Stack {
    var topItem: T? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let _topItem = myCrushes.topItem {
    print(_topItem)
}



//TYPE CONSTRAINTS
//GENERIC TYPE có thể work với bất cứ kiểu dữ liệu nào, tuy nhiên đôi khi ta muốn kiểu dữ liệu đó phải thoả mãn 1 điều kiện nào
//nào đó, đó là khái niệm của type constraints

//liên hệ với generic dictionary ta đã học trước đây, Dictionary ràng buộc rằng Key của nó phải conform protocol Hasable
//mục đích của việc này để Dictionary đảm bảo rằng key của nó là duy nhất
//nếu không đảm bảo việc này, nó không thể tìm ra 1 value từ 1 key, cũng không thể set newvalue cho 1 key nào đó


//TYPE CONSTRAINTS IN ACTION

//trước tiên, viết 1 hàm bình thường có tên là findIndex
//như sau:

func findIndex(ofString stringToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == stringToFind { return index }
    }
    return nil
}

let arrStr1 = ["Giang", "Linh", "Nhi"]
if let index = findIndex(ofString: "Nhi", in: arrStr1) {
    print("index of Nhi is: \(index)")
}

//giờ viết generic function
//uncomment function bên dưới sẽ gây ra lỗi
//func findIndexG<T>(off valueToFind: T, in array: [T]) -> Int? {
//    for (index, value) in array.enumerated() {
//        if value == valueToFind {
//            return index
//        }
//    }
//    return nil
//}
//function findIndexG ở trên bị lỗi chỗ so sánh bằng
//đơn giản với 1 generic type thì nó không thể biết được là
//làm cách nào để so sánh bằng.
//ntn là bằng nhau. bằng nhau theo tiêu chí nào???

//ơn giời, swift cung cấp cho chúng ta 1 protocol là Equatable
//any type mà conform Equatable thì phải implement 2 operators là
//là == và !=
//nhờ việc này mà ta có thể so sánh == được


//bây giờ ta sẽ TYPE CONSTRAINTS để viết lại hàm findIndex ở trên nhé

func findIndexG<T: Equatable>(off valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
//như trên ta thấy, bây giờ ta buộc thằng T phải conform được Equatable
//hết lỗi :))


//thử dùng hàm trên xem nào

//dùng với String
//by default. String đã conform Equatable

if let index = findIndexG(off: "Nhi", in: ["Nhi", "Tien"]) {
    print("index cua Nhi la: \(index)")
}


//dùng với Int
//by default, Int cũng conform Equatable

if let index = findIndexG(off: 2, in: [1, 9, 8, 2, 5, 6, 10, 3]) {
    print("index cua 2 la: \(index)")
}

//ok, easy? go ahead!


//ASSOCIATED TYPES

