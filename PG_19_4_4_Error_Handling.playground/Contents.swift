import UIKit

//Representing and Throwing Errors
//in Swift, errors are represented by values of types that conform to the Error protocol. This empty protocol indicates that a type can be used for error handling.

//example
enum VendingMachineError : Error {
    case invalidSelection
    case insufficientFund(coinsNeeded : Int)
    case outOfStock
}

//Throwing an error lets you indicate that something unexpected happened and the normal flow of execution can’t continue

//throw VendingMachineError.insufficientFund(coinsNeeded: 10)

//Khi error được ném ra. nó cần phải có handling

//Propagating Errors Using Throwing Functions
//lan truyền lỗi sử dụng hàm (hàm ném ra lỗi)

//throwing function propagate erors that are thrown inside of it to the scope from which it's called
//ném ra scope nó được gọi

//example

struct Item {
    var count : Int
    var price : Int
}

class VendingMachine {
    static var inventory = [
        "Chips" : Item(count: 10, price: 2),
        "Apple" : Item(count: 12, price: 4),
        "Crush" : Item(count: 200, price: 20)
    ]
    var coinsDeposited = 0
    func ven(itemName name : String) throws {
        guard let item = VendingMachine.inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        //now item is available to use
        //điểm khác biệt của guard let và if let là
        //guard let luôn có else
        //biến sau gard let có thể sử dụng ở dưới (guard let item -> item có thể dùng ở phia dưới nếu guard true)
        //còn if let thì biến sử dụng trong body của chính if let đó
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        //đấy. bây giờ ta đã dùng được biến item rồi đấy. kk
        
        guard item.price <= self.coinsDeposited  else {
            throw VendingMachineError.insufficientFund(coinsNeeded: (item.price - self.coinsDeposited))
        }
        
        //ok. bây giờ mua đuọc rồi. ta sẽ xử lý cho mua
        
        //thối tiền
        self.coinsDeposited -= item.price
        
        //cập nhật lại danh sách hàng
        var clonedItem = item
        clonedItem.count -= 1
        VendingMachine.inventory[name] = clonedItem
        print("Done. nhận hàng")
    }
}

//dictionary lưu tên người và món yêu thích
let favoriteSnacks : Dictionary<String, String> = [
    "Nhi" : "Chips",
    "Hai" : "Crush"
]

//function mua snack

func buyFavoriteSnack(person : String, machine : VendingMachine) throws {
    let snackToBuy = favoriteSnacks[person] ?? "Apple"
    try machine.ven(itemName: snackToBuy)
}

//trong throwing function khi gọi 1 throwing function khác, ta chỉ cần dùng try trước function được gọi
//k cần dùng đầy đủ do try catch
//đây gọi là cơ chế propagating errors (lan truyền lỗi) -> nghe hơi chuối


//throwing initializers can propagate errors as the throwing methods do

struct PerchasedSnack {
    var name : String
    init(name : String, vendingMachine : VendingMachine) throws {
        try vendingMachine.ven(itemName: name)
        self.name = name
    }
}

//Handling errors using do try catch
//example

let vendingMachine1 = VendingMachine()
vendingMachine1.coinsDeposited = 8

do {
    try buyFavoriteSnack(person: "Nhi", machine: vendingMachine1)
    print("buy ok")
} catch VendingMachineError.invalidSelection {
    print("invalid selection")
} catch VendingMachineError.outOfStock {
    print("out of stock")
} catch VendingMachineError.insufficientFund(let coisneeded) {
    print("Insufficient fund. please insert additonal \(coisneeded) coins")
} catch {
    print("unknown \(error)")
}

//một do catch không nhất thiết phải handling all error
//nếu nó không handling đủ thì lỗi sẽ được propagating ra scope bên ngoài (surrounding scope)

//nếu không scope nào hứng lỗi thì nó bị đẩy ra top-level scope -> dẫn đến runtime error
//example

func mua(item : String) throws {
    do {
        try vendingMachine1.ven(itemName: item)
    } catch VendingMachineError.insufficientFund(let coinsneeded) {
        print("can them coins la: \(coinsneeded)")
    }
}

do {
    try mua(item: "DoNotExit")
} catch {
    print("loi: \(error)")
}

//ở trên ta thấy hàm mua nó handling đúng mỗi error là insufficientFund
//mà khi dùng hàm mua đó ta lại truyền vào 1 tên sản phẩm không tồn tại
//do đó mà lỗi từ hàm mua sẽ propagating ra bên ngoài do catch ở phía dưới
//hàm do catch phía dưới hứng lỗi và print ra màn hình

//easy? right?


//CONVERTING ERRORS TO OPTIONAL VALUE
//you use try? to handle an error by converting it to an optional value. if an error is thrown
//while evaluating the try? expression, the value of expression is nil

if let _ = try? mua(item: "Crush") {
    print("mua thanh cong")
} else {
    print("mua that bai")
}

//another example

func fetchDataFromLocal() throws -> Data? {
    //hơi không đúng, tại định nghĩa hàm throw mà chả thấy throw gì :))
    return Data(base64Encoded: "Hai")
}

func fetchDataFromServer() throws -> Data? {
    //hơi không đúng, tại định nghĩa hàm throw mà chả thấy throw gì :))
    return Data(base64Encoded: "Nhi")
}

func fetchData() -> Data? {
    if let data = try? fetchDataFromServer() {
        return data
    }
    if let data = try? fetchDataFromLocal() {
        return data
    }
    return nil
}


//DISABLING ERROR PROPAGATION
//sử dụng try! để disable error propagation
//nếu error được ném ra thì runtime error
//easy :))
//cách này chắc ít dùng. vì khi đó throwing function lại hoá ra chả có tác dụng gì.
//bởi vì ta đã không handling error mà nó trả ra

//try!vendingMachine1.ven(itemName: "dumbmyitem")
//hàm try ở trên sẽ gây ra runtime error. nên ta phải comment lại. muốn test thì mở ra nhé.


//SPECIFYING CLEANUP ACTIONS

//sử dụng defer statement
//defer statement sẽ được gọi sau cùng, trước khi việc execution exit scope hiện tại của nó
//việc exit có thể là do return, break, throwing error
//defer statement không thể chứa các code mà transfer control out of the statement (defer statement)
//nếu 1 block of code chứa nhiều defer statement thì defer statment nào định nghĩa trước sẽ execute sau (tức là theo chiều ngược lại lúc nó định nghĩa)

//simple example

func demoDefer() throws {
    defer {
        print("defer 1")
        print("defer is call by catch an error")
    }
    defer {
        print("defer 2")
    }
    defer {
        print("defer 3")
    }
    try vendingMachine1.ven(itemName: "dumbmy01")
    print("demo defer: mua thanh cong")
}
try demoDefer()

//ok
//easy? right?
