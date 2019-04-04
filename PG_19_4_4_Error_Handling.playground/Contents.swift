import UIKit

//Representing and Throwing Errors
//n Swift, errors are represented by values of types that conform to the Error protocol. This empty protocol indicates that a type can be used for error handling.

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
