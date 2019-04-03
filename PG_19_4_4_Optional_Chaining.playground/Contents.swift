//: Playground - noun: a place where people can play

import UIKit

//Optional chaining as an Alternative To Forced Unwrapped

//optional chaining tương tự như forced unwrapped.
//tuy nhiên forced unwrapped gây ra runtime eror nếu optional value = nil

//giá trị của toàn bộ biểu thức sẽ là 1 optional value
//example

class Person1 {
    var ressidence : Residence1?
}

class Residence1 {
    var numberOfRoom = 1
}

let john = Person1()

//use optional chaining

if let nums = john.ressidence?.numberOfRoom {
    print("there're \(nums) rooms")
} else {
    print("no room")
}

john.ressidence = Residence1()

if let nums = john.ressidence?.numberOfRoom {
    print("there're \(nums) rooms")
} else {
    print("no room")
}

//Defining model classes for optional chanining

//another complex example

class Room {
    let name : String
    init(name : String) {
        self.name = name
    }
}

class Address {
    var buildingName : String?
    var buildingNumber : String?
    var street : String?
    func buildingIdentifier() -> String? {
        if let buildingNum = buildingNumber, let stre = street {
            return "\(buildingNum) \(stre)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

class Residence {
    var rooms = [Room]()
    var numberOfRooms : Int {
        return self.rooms.count
    }
    subscript(i : Int) -> Room {
        get {
            return self.rooms[i]
        }
        set {
            self.rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("number of room: \(self.numberOfRooms)")
    }
    var address : Address?
}

class Person {
    var residence : Residence?
}

//Accessing properties through optional chaining

let terry = Person()
if let numOfrooms = terry.residence?.numberOfRooms {
    print("terry's residence has \(numOfrooms) rooms")
} else {
    print("Unable to retrieve the number of rooms")
}

//try to assign value to a nil optional value will lead failure
//example

var address1 = Address()
address1.buildingName = "Building of Nhi"

terry.residence?.address = address1

//vì residence hiện giờ đang nil cho nên không thể gán address cho nó được
//ở trên cái address1 k được evaluate vì nó fail ngay chỗ optional chaining rồi, nên nó sẽ dừng lại ở đây
//phần bên phải bị bỏ đi
//để kiểm chứng ta sẽ dùng 1 function để tạo ra address

func createAddress() -> Address {
    print("created a address")
    let add = Address()
    add.buildingName = "Building A"
    return add
}

terry.residence?.address = createAddress()

//rõ ràng không hề có print dòng chữ "created a address"
//chứng minh hàm createAddress không được gọi
//chứng minh điều ta nói ở trên là đúng :))

//check xem có set được ko
//như hàm set địa chỉ ở trên nếu thành công sẽ trả về kiểu Void?
//thất bại thì là nil
//cho nên ta dễ dàng check xem set địa chỉ có thành công hay không

if (terry.residence?.address = createAddress()) != nil {
    print("it's possible to set a address")
} else {
    print("it's not possible to set a address")
}

//Calling Methods Through Optional Chaining
//tương tự khi gọi 1 method

if (terry.residence?.printNumberOfRooms() != nil) {
    print("print number of room ok")
} else {
    print("print number of room failed")
}

//Accessing subscript through optional chaining
//viết dấu ? trước subscript

if let room1name = terry.residence?[1].name {
    print("room1's name is: \(room1name)")
} else {
    print("unable to retrieve the name of room 1")
}

//bây giờ thử tạo giá trị cho residence của terry

let johnHouse = Residence()
johnHouse.rooms.append(Room(name: "Room 1"))
johnHouse.rooms.append(Room(name: "Room 2"))

terry.residence = johnHouse

if let firstHouseName = terry.residence?[0].name {
    print("the first room name is: \(firstHouseName)")
} else {
    print("unable to retrieve the first room name")
}

//key để nhớ
//...Vế bên trái.residence?.Vế bên phải...


//Accessing Subscript of Optional Type
//tức là giá trị của subscript trả về optional type
//cứ đơn giản là cứ chấm tới...gặp thằng nào trả về optional type thì quất dấu chấm hỏi ngay sau nó ????

var testScores = [
    "Nhi" : [9, 10, 8],
    "Hai" : [10, 10, 9]
]

//để tăng điểm môn đầu tiên cho Nhi

testScores["Nhi"]?[0] += 1

//giải thích
//vì truy suất đến 1 phần tử trong dictionary bằng subscript trả về 1 optional type.
//do đó ta phải viết dấu ? phía sau. còn tiếp theo thì đơn giản rồi

//gán điểm môn thứ 3 của Hải là 10

testScores["Hai"]?[2] = 10

print(testScores)

//ok?


