import UIKit

//Swift sử dụng ARC để track và quản lý bộ nhớ
//cứ mỗi lần ta new 1 instance của 1 class thì swift sẽ dành ra 1 vùng nhớ để lưu thông tin của instance
//ARC chỉ work với instance của class thôi
//ARC sẽ check xem mỗi instance của 1 class hiện có bao nhiêu strong reference đến instance đó
//nếu không có strong reference nào đến instance đó thì instance đó sẽ bị deallocated (giải phóng khỏi bộ nhớ)

//ARC IN ACTION

class Person {
    var name: String
    init(name: String) {
        print("initing person with name: \(name)")
        self.name = name
    }
    deinit {
        print("deinit person with name: \(name)")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?
reference1 = Person(name: "Uyen Nhi")
reference2 = reference1
reference3 = reference1

reference1 = nil
//khi ta gán reference1 = nil thì strong reference của biến reference1 đến instance của Person (ban đầu nó tạo ra)
//...bị bẻ gãy
//tuy nhiên vẫn còn 2 trong reference của reference2 và reference3 đến instance của Person đó
//cho nên instance Person đó vẫn ko bị Deallocated

//bây giờ ta thử gán 2 strong reference còn lại là reference2 và reference3 = nil

reference2 = nil
reference3 = nil
//rõ ràng bây giờ deinit được gọi
//bởi vì đã không còn strong reference nào đến instance của Person đó.



//STRONG reference cycles between class instances
//trường hợp này xảy ra khi tồn tại 2 class A và B mà
//trong class A chứa 1 property có kiểu dữ liệu là class B
//và trong class B chứa 1 property có kiểu dữ liệu là class A
//do đó nó tạo ra 1 strong reference cycles
//khiến cả 2 instance của A và B không thể deallocated
