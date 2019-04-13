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


//CÓ 2 cách giải quyết Strong Reference Cycle


//C1: dùng weak Reference
//key to remember:
//Weak Reference đến thằng có lifetime ngắn hơn
//dĩ nhiên rồi, có khi nào mà gủi hết tiền cho ngân hàng sắp phá sản không??? :))

//Ví dụ nha

class Person1 {
    var name: String
    init(name: String) {
        print("init person \(name)")
        self.name = name
    }
    var apartment: Apartment?
    deinit {
        print("deninit person: \(name)")
    }
}

class Apartment {
    var unit: String
    init(unit: String) {
        print("init apartment unit: \(unit)")
        self.unit = unit
    }
    weak var tenant: Person1?
    deinit {
        print("deinit apartment unit: \(unit)")
    }
}

//vì căn nhà sẽ có thể không có chủ, nó mới được xây để cho thuê chẳng hạn. cho nên
//nên cứ cho là căn nhà sẽ weak reference đến Person

var person1: Person1? = Person1(name: "Nam Le")
var apartment1: Apartment? = Apartment(unit: "5C")

person1?.apartment = apartment1
apartment1?.tenant = person1

person1 = nil

//khi mà gán person1 = nil nghĩa là ta đã cắt đứt strong reference đến instant Perrson1 mới tạo trước đó
//Instance này giờ chỉ còn 1 weak reference đến nó
//Do đó nó sẽ bị deallocated. và hàm deinit của Person được gọi


//C2: dùng unowned reference
//nó ngược với weak reference
//unowned reference sẽ luôn có giá trị, nghĩa là không thể là optional value
//unowned refenece đến thằng có lifetime bằng or dài hơn
//khuyên dùng unowned reference khi ta make sure được rằng: thằng được unowned reference tới phải có trước

//xem ví dụ sau cho dễ hiểu

class Customer {
    var name: String
    init(name: String) {
        print("init a customer with name: \(name)")
        self.name = name
    }
    var card: CreditCard?
    //vì 1 người có thể có or không có credit card. nên sẽ là optional value
    deinit {
        print("deinit a customer with name: \(name)")
    }
}

class CreditCard {
    var number: UInt64
    init(number: UInt64, customer: Customer) {
        print("init a credit card with number: \(number)")
        self.number = number
        self.customer = customer
    }
    unowned var customer: Customer
    //vì 1 credit card phải là thuộc quyền sở hữu của 1 người.
    //nên sử dụng unowned reference
    //để đảm bảo rằng customer luôn luôn có. ta đã có truyền customer vào hàm init của CreditCard
    deinit {
        print("deinit card number: \(number)")
    }
}

//dùng thử

var customer1: Customer? = Customer(name: "Ngan Nguyen")
customer1?.card = CreditCard(number: 4824_3131_5454_5333, customer: customer1!)

customer1 = nil
//xem hình trên web để hiểu hơn. khó giải thích được @@


//UNOWNED reference and implicitly unwrapped optional properties
//The examples for weak and unowned references above cover two of the more common scenarios in which it’s necessary to break a strong reference cycle.
//
//The Person and Apartment example shows a situation where two properties,
//both of which are allowed to be nil, have the potential to cause a strong reference cycle. This scenario is best resolved with a weak reference.
//
//The Customer and CreditCard example shows a situation where one property that is allowed to be nil
//and another property that cannot be nil have the potential to cause a strong reference cycle. This scenario is best resolved with an unowned reference.
//
//However, there is a third scenario, in which both properties should always have a value, and neither property should ever be nil once initialization is complete.
//In this scenario, it’s useful to combine an unowned property on one class with an implicitly unwrapped optional property on the other class.
//

class Country {
    var name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
        //để ý rằng ở đây ta truyền self như là tham số của hàm khởi tạo 1 City
        //nên nhớ rằng Country có 2 stored properties là name và capitalCity
        //theo như 2 phase init thì ta chỉ có thể dùng được self như là tham số (...tức là
        //...tức là truyền self cho biến khác, khi và chỉ khi tất cả các stored properties của nó được khởi tạo hết
        //đó là lý do tạo sao ta phải lại dùng implicitly unwrapped optional cho biến capitalCity (giá trị default là nil)
        //var capitalCity: City! có nghĩa là ban đầu nó có giá trị nil
        //sau khi đó bắt buộc bằng 1 cách nào đó nó phải có giá trị (để thực hiện điều này ...
        //...ta đã khởi tạo giá trị cho nó trong hàm init)
        //và sua khi có giá trị thì nó không thể nào bằng nil 1 lần nữa
        //và đồng thời ta sẽ sử dụng nó như 1 cách bình thường, nghĩa là đã được unwrapped rồi.
        //nghe vi diệu vl
        //đó là ý nghĩa của implicitty unwrapped optional
    }
}

class City {
    var name: String
    unowned var country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

//dùng thử

var country = Country(name: "Việt Nam", capitalName: "Ha Noi")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")


//trước khi qua cái mới thì ta tổng kết lại
//nếu 2 properties đều là optional (có cũng được, không có cũng được) thì ta dùng weak reference
//nếu 2 properties có 1 là optional, 1 là bắt buộc thì ta dùng unowned reference
//nếu 2 properties mà cả 2 là bắt buộc thì 1 cái ta dùng implicitly unwrapped optional, 1 cái ta dùng unowned reference

//ok? easy? no easy!!



//STRONG reference cycle for Closure
//hơi the same như strong reference cycle giữa 2 class với nhau thì
//Strong reference cycle giữa 1 class và 1 closure cũng sẽ xảy ra nếu ...
//...1 property bên trong class được gán bằng 1 closure (vì closure là reference type nên property đó đã tạo ra 1 strong reference đến closure đó...
//...và closure đó cũng tham chiếu đến class đó (sử dụng self bên trong closure)
//điều này tạo ra 1 strong reference cycle


//xem ví dụ cho dễ hiểu

class HtmlElement {
    var name: String
    var text: String?
    init(name: String, text: String?) {
        self.name = name
        self.text = text
    }
    lazy var asHtml: () -> String = {
        //chú ý ở đây ta phải dùng lazy bởi vì asHtml là 1 stored property của class HtmlElement
        //nên nó cần được khởi tạo khi init HtmlElement. nhưng ta đã không làm điều này.
        //vì vậy ta phải bắt buộc sử dụng lazy để mà có thể dùng được self bên trong closure
        //vì lazy có thể có or không. có nghĩa là biến lazy chỉ tồn tại khi ta truy xuất đến nó
        //khi tạo ra instance của HtmlElement thì chưa có asHtml
        //khi ta truy xuất đến asHtml thì biến asHtml mới tồn tại
        //có nghĩa là khi asHtml có thì dĩ nhiên là instance của class HtmlElement đã có rồi
        //nên ta dùng self bên trong closure thoải mái
        //chỉ 1 dòng code mà giải thích vl luôn ...
        //...
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        }
        return "<\(self.name) />"
    }
    deinit {
        print("\(name) is being deinited")
    }
}

var htmlElement1: HtmlElement? = HtmlElement(name: "Strong", text: "Nguyễn Thuỵ Uyển Nhi")
print(htmlElement1!.asHtml())

//bên trên là demo cho strong reference giữa 1 class và 1 closure
//asHtml refer to Closure -> creates a strong reference
//closure refer to Self (class instance) -> creates a strong reference
//both create a strong reference cycle


//không thử thử gán htmlElement1 = nil để xem htmlElement1 có deinit hay không???

htmlElement1 = nil
//không hề print ra deinit của htmlElement1. đó, chính là strong reference cycle


//RESOLVING STRONG reference cycles for closures
//Swift requires you to write self.someProperty or self.someMethod() (rather than just someProperty
//or someMethod()) whenever you refer to a member of self within a closure. This helps you remember that it’s possible to capture self by accident.
//có 1 cách giải quyết strong reference cycle giữa class và closure
//1: sử dụng Capturing list (weak or unowned tuỳ hoàn cảnh ...)


//DEFINING a capturing list
//phần này phải coi document để hiểu rõ hơn
//Each item in a capture list is a pairing of the weak or unowned keyword with a reference to a class instance
//(such as self) or a variable initialized with some value (such as delegate = self.delegate!).
//These pairings are written within a pair of square braces, separated by commas.



//Weak and Unowned References
//
//Define a capture in a closure as an unowned reference when the closure and the instance it captures will always refer to each other,
//and will always be deallocated at the same time.
//
//Conversely, define a capture as a weak reference when the captured reference may become nil at some point in the future.
//Weak references are always of an optional type, and automatically become nil when the instance they reference is deallocated.
//This enables you to check for their existence within the closure’s body.
//
//nói tóm là khá giống quy luật giữa 2 class với nhau thôi
//
//If the captured reference will never become nil, it should always be captured as an unowned reference, rather than a weak reference.
//


//ví dụ
//viết lại class HtmlElement

class HtmlElementWay2 {
    var name: String
    var text: String?
    init(name: String, text: String?) {
        self.name = name
        self.text = text
    }
    lazy var asHtml: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        }
        return "<\(self.name) />"
    }
    deinit {
        print("\(name) is being deinited")
    }
}

//dùng

var htmlw2: HtmlElementWay2? = HtmlElementWay2(name: "h1", text: "Nhiii Nguyễn")
print(htmlw2!.asHtml())

htmlw2 = nil
//bây giờ h1 đã được deinit



//NOTEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
//CASE STUDY
//unowned self
//weak delegate = self.delegate!
//closure reference đến chính instance của class đó (self) thì dùng unowned
//closure reference đến instance của 1 class khác (như là delegate của class đó) thì dùng weak


//cũng đơn giản, right?
//go ahead!!!
