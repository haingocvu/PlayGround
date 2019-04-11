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
//khi định nghĩa protocol ta đôi khi cần định nghĩa 1 or nhiều associated types
//associated types hiểu như đại diện cho kiểu dữ liệu bất kì để mà ta có thể refer đến cho tiện...
//...ở bên trong body của protocol.
//thế nên associated types chỉ tồn tại trong protocol???
//kiểu dữ liệu đại diện này sẽ được infer ra khi mà protocol được adopt bởi 1 kiểu khác

//simple example

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
//như trên ta thấy Item là 1 associated type.
//được dùng trong hàm append và subscript

//ta thử viết lại IntStack struct mà conform Container
//Non-generic version

struct IntStackWay2: Container {
    //original Intstack Implement
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    //conforming Container protocol
    //ở đây ta có nói rằng kiểu Item ở Container protocol chính là kiểu Int ở trường hợp này
    //thật ra không cần dòng ngay dưới đây. Swift có thể infer ra đuọc dựa vào kiểu trả về của subscript or kiểu tham số của append
    typealias Item = Int
    mutating func append(_ item: Int) {
        items.append(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}


//bây giờ khó hơn, ta sẽ viết lại generic Stack mà conform Container protocol
//Generic Version


struct StackWay2<Element>: Container {
    //original Stack Implement
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    //conforming protocol Container
    var count: Int {
        return items.count
    }
    mutating func append(_ item: Element) {
        items.append(item)
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}
//khó hơn tuy nhiên cũng đơn giản phải không?
//chú ý ở đây ta không hề dùng typealias nhưng swift vẫn hiểu được nhé
//vi diệu không? :))


//bây giờ thử dùng xem

var stackway222 = StackWay2<String>()
stackway222.append("Nhi")
stackway222.append("Giang")

print("count: \(stackway222.count)")
print("First: \(stackway222[0])")


//ADDING Constraints to an Associated Type
//nhắc đến constraints là cứ nhớ đến dấu ":" (dấu hai chấm)
//hoặc là mệnh đề Where
//xem code cho dễ hiểu

protocol ContainerV2 {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
//như trên có nghĩa là khi 1 type khác adopt ContainerV2 protocol thì
//thì kiểu dữ liệu của parameter có tên là item phải conform được protocol Equatable

//ví dụ luôn cho nóng

struct Stackv3<Element>: ContainerV2 where Element: Equatable{
    var items = [Element]()
    var count: Int {
        return items.count
    }
    mutating func append(_ item: Element) {
        items.append(item)
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}
//khi định nghĩa Stackv3 ta đã có chỉ ra rằng generic type (Element) phải conform được Equatable...
//...bằng mệnh đề where. Như vậy là Element đã thoả mãn được Constraints của Associated type.



//USING a protocol in its Associated type's constraints

//protocol mà associated type của nó có constraints đến chính protocol đó
//hao hao như đệ quy
//lại mệt rồi


//example

protocol SuffixableContainer: ContainerV2 {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

//kiểu dữ liệu Suffix này có 2 constraints là:
//1 là phải conform được SuffixableContainer
//2 là Item type của Suffix phải the same như Item type của containerv2
//thật sự thì mình không hiểu ở chỗ này, chả nhẽ có trường hợp mà Item type của Suffix khác Item type của ContainerV2 sao????


//bây giờ thử để StackV3 adopt protocol SuffixableContainer bằng cách thực hiện extension

extension Stackv3: SuffixableContainer {
    func suffix(_ size: Int) -> Stackv3 {
        var result = Stackv3()
        for i in (count - size)..<count {
            result.append(self[i])
        }
        return result
    }
}

//dùng thử

var stack33 = Stackv3<Int>()
stack33.append(22)
stack33.append(88)
stack33.append(99)

let suffix2 = stack33.suffix(2)
print(suffix2)


//another example của việc dùng SuffixableContainer
//bây giờ ta dùng trên non-generic version của Stack gọi là IntStackWay2

extension IntStackWay2: SuffixableContainer {
    //vì thằng Stackv3 đã adopt thằng SuffixableContainer nên ta có thể dùng nó như kiểu trả về của hàm suffix
    func suffix(_ size: Int) -> Stackv3<Int> {
        var result = Stackv3<Int>()
        for i in (count - size)..<count {
            result.append(self[i])
        }
        return result
    }
}

//thử dùng xem

var intstackw222 = IntStackWay2()
intstackw222.append(2)
intstackw222.append(8)
intstackw222.append(10)
let suffix3 = intstackw222.suffix(2)
print(suffix3)


//GENERIC where clauses
//type constraints (dấu :) được dùng định nghĩa constraints cho generic type của function, subscript, or type
//còn để định nghĩa constraints cho associated type (type trong protocol mà có chữ associated phía trước) ...
//...ta dùng mệnh đề where
//You write a generic where clause right before the opening curly brace of a type or function’s body.


//example
func allItemsMatch<C1: ContainerV2, C2: ContainerV2>(_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item
{
    //C1: ContainerV2 nghĩa là generic type C1 phải conform được protocol ContainerV2
    //tương tự cho C2
    //where C1.Item == C2.Item
    //ý nói rằng: kiểu dữ liệu của container1 (C1) phải the same kiểu dữ liệu của container2 (C2)
    //mục đích của việc này là để ta có thể so sánh được
    //theo như ví dụ thì là vầy
    //where C1.Item == C2.Item, C1.Item: Equatable
    //tuy nhiên ở ContainerV2 ta đã chỉ rõ rằng Item type phải conform Equatable rồi nên
    //nên không cần phải làm vậy nữa, sẽ dư code.
    //protocol với assicoated type có nên gọi là Generic Protocol không nhỉ??? :))
    //giờ cài đặt logic thôi
    
    //for false case
    if someContainer.count != anotherContainer.count { return false }
    //mình dùng được someContainer.count vì nó có requirement property là count
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] { return false }
        //mình dùng được dạng someContainer[i] được vì nó có requirement là subscript
    }
    
    //all match
    return true
}

//dùng thử

var stackv3333 = Stackv3<String>()
stackv3333.append("Nhi")
stackv3333.append("Giang")
stackv3333.append("Ngan")

var arrayOfStrings = ["Nhi", "Giang", "Ngan"]

//do lười biếng nên thôi cứ lấy clone thằng stackv3333 ra thôi rồi so sánh cho nhanh

var stackv3333333 = stackv3333

var rsult = allItemsMatch(stackv3333, stackv3333333)
print("ket qua là: \(rsult)")



//EXTENSION with a generic where clause


