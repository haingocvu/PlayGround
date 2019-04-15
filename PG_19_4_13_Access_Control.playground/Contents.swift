import UIKit

//ACCESS CONTROL
//You can assign specific access levels to individual types (classes, structures, and enumerations),
//as well as to properties, methods, initializers, and subscripts belonging to those types.
//Protocols can be restricted to a certain context, as can global constants, variables, and functions.


//để cho dễ, ta sẽ nói đến các thứ có thể sử dụng access control là entities (properties, type, function, ...)


//open hay puclic access: entities có thể được access ở đâu cũng được, trong source file của cùng module, hay source file
//của module khác mà import module mà entities thuộc về
//thường dùng để định nghĩa public interface của framework
//
//internal: bên trong mudule đó thôi
//
//file-private: bên trong file
//
//Private access restricts the use of an entity to the enclosing declaration,
//and to extensions of that declaration that are in the same file.
//Use private access to hide the implementation details of a specific piece of functionality ...
//...when those details are used only within a single declaration.


//open access chỉ áp dụng đến class và class member. nó khác public access như sau:
//
//Classes with public access, or any more restrictive access level, can be subclassed only within the module where they’re defined.
//Class members with public access, or any more restrictive access level, can be overridden by subclasses only within the module where they’re defined.
//
//Open classes can be subclassed within the module where they’re defined, and within any module that imports the module where they’re defined.
//Open classes can be subclassed within the module where they’re defined, and within any module that imports the module where they’re defined.
//
//


//Guiding Principle of Access Levels
//No entity can be defined in terms of another entity that has a lower (more restrictive) access level.

//nghĩa là
//một biến với public access được gán vào 1 kiểu có access level là private hay fielprivate hay internal
//
//một function không thể có phạm vi truy xuất là public trong khi parameter hay return type của nó lại có phạm vi truy xuất là private được...
//...vì lúc đó parameter có đâu mà gọi :))
//


//DEFAULT ACCESS LEVELS
//all entities thì mặc định có phạm vi truy xuất là internal (trong module của nó)
//nên đa số trường hợp, ta không cần khai báo access level.
//nếu đơn thuần ta chỉ viết ra 1 app và chả cần phải import nó như 1 module trong project khác.
//của ta ta xài :))
//vậy thì thôi, k cần đọc nữa.

//Nếu vẫn muốn đọc thì đọc
//


//Access Levels for Single-Target Apps
//như nói ở trên, không cần định nghĩa gì dả



//Access Levels for Frameworks
//giờ ta định nghĩa cái gọi là API
//API là application public interface
//nghĩa là cái module của bạn muốn cho người ta xài được cái gì cái đó gọi là API
//API phải là public hoặc open để mà thằng khác xài được
//như vậy những cái ta muốn dấu thì vẫn private, ... các kiểu thôi
//đó là định nghĩa đơn giản của API
//..không biết ok k :))


//Access Levels for Unit Test Targets
//từ từ bàn, đại loại là chưa cần :D


//Access Control Syntax
//Define the access level for an entity by placing one of the open, public, internal, fileprivate, or private modifiers before the entity’s introducer:

//example

open class SomeOpenClass {}
//open chỉ dùng cho class và class's member
public class SomePublicClass{}
internal class SomeInternalClass{}
fileprivate class SomeFilePrivateClass{}
private class SomePrivateClass{}

public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}

//thực tế thì access level default là internal, cho nên việc viết internal như 1 access level cho entities là không cần thiết
//ví dụ

class SomeInternalClass01 {}
//đây là 1 internal class

let someInternalConstant01 = 0
//đây là internal constant



//CUstom types
//class, struct, enum là custom.
//The access control level of a type also affects the default access level of that type’s members (its properties, methods, initializers, and subscripts)
//nếu bạn define access level cho class là fileprivate thì default access level của properties và methods trong class đó cũng là fileprivate
//nếu bạn define access level cho 1 type là public hay là internal thì member của type đó sẽ là internal

//nếu bạn thắc mắc tại sao access level của 1 type là public mà member (properties, methods) của nó lại là internal...???
//bởi vì thường những cái public là để trưng ra làm API cho module khác...
//..nên swift để default như vậy nhằm tránh việc trình bày ra những cài đặt bên trong của type đó


//example

public class SomePublicClass02 {
    //public class
    public let somepublicConstant = 0
    //public constant
    var someInternalVariable = 0
    //internal variable
    fileprivate func someFilePrivateFunction(){}
    //file private function
}

class SomeInternalClass02 {
    //interal class
    let someInternalConstant = 0
    //internal constant
    fileprivate var someFilePrivatevariable = 0
    //file private variable
    private func somePrivateFunction() {}
    //private function
}

fileprivate class SomeFilePrivateClass02 {
    //file private class
    fileprivate func someFilePrivateFunction() {}
    //file private function
    private func somePrivateFunction(){}
    //private function
}

private class SomePrivateClass02 {
    public var aa = 10
    //sao dùng như trên vẫn được ta???
    //private class
    private let somePrivateConstant = 0
    //private constant
    var somePrivateVariable = 0
    //private variable
    func somePrivateFunction() {}
    //private function
}

private let nnn = SomeInternalClass02()
print(nnn.someInternalConstant)

//Tuple types
//nếu 1 tuple compose 2 difference types
//1 là file private
//cái còn lại là private ...thì access level của tuple đó phải là private
//tương tự như function


//FUNCTION types
//The access level for a function type is calculated as the most restrictive access level of the function’s parameter types and return type

//ví dụ

internal class SomeInternalClass03 {}
private class SomePrivateClass03 {}

private func someFunction() -> (SomeInternalClass03, SomePrivateClass03) {
    return (SomeInternalClass03(), SomePrivateClass03())
}
//vì access level của tuple có phạm vi chung là private
//nên access của function sẽ là private
//easy?


//Enumeration Types
//từng case cụ thể của enum sẽ lấy access level của enum làm access level của nó.
//khônh thể chỉ định case cho từng case

public enum Gender {
    case Male
    case Female
}
//trường hợp trên Male và Female đều có access level là public
//NOTE:
//access level của Rawvalue or Associated Values của enum phải có access level bằng or cao hơn (tức là less restrict hơn) access level của enum đó


//Nested Types
//Nested types defined within a private type have an automatic access level of private.
//Nested types defined within a file-private type have an automatic access level of file private.
//Nested types defined within a public type or an internal type have an automatic access level of internal.
//If you want a nested type within a public type to be publicly available, you must explicitly declare the nested type as public.



//Subclassing
//có 1 số quy tắc về access level khi subclassing
//
//subclass không thể có access level cao hơn super class (không thể less restrict hơn super class)
//
//khi override 1 superclass's member thì subclass có thể thay đổi access level của member đó theo quy tắc là phải less restrict hơn
//nghĩa là xem ví dụ đi

public class SomePublicClass04 {
    fileprivate func someFilePrivateFunction() {}
}

private class SomeSubclass: SomePublicClass04 {
    override internal func someFilePrivateFunction() {
        super.someFilePrivateFunction()
    }
}
//ở đây ta đã public -> private
//fileprivate -> internal
//khi subclassing thì access level của class hạ xuống
//override thì access level của member nâng lên
//có hạ xuống thì phải có nâng lên mới cân bằng được :))
//việc gọi method hay gì diễn ra bình thường, thậm chí như trên ta gọi 1 fileprivate method bên trong 1 internal method



//KEY to remember
//hơi rối rồi phải không???
//
//cứ hiểu nhanh rằng, khi định nghĩa cái mới thì nó phải more strictly hơn (or =) những cái dùng để định nghĩa ra nó.
//như 1 function thì phải more strictly hơn các parameters hay return type của function đó


//Constants, Variables, Properties, and Subscripts
//như cách ta đã nói ở trên
//A constant, variable, or property can’t be more public than its type

//ví dự
private let nnnn = SomeInternalClass02()
//nnnn có type là SomeInternalClass02
//vì SomeInternalClass02 có access level là Internal
//nghĩa là nnnn phải có access level more strictly. nghĩa là fileprivate, private
//ở đây ta dùng private nên ok


//Getters and Setters
//Getters and setters for constants, variables, properties, and subscripts automatically receive the same access level
//as the constant, variable, property, or subscript they belong to.

//You can give a setter a lower access level than its corresponding getter, to restrict the read-write scope of that variable, property, or subscript.
//You assign a lower access level by writing fileprivate(set), private(set), or internal(set) before the var or subscript introducer.


//example

struct StrackedString {
    //internal struct
    fileprivate(set) var numberOfEdit = 0
    //mặc định thì store properties sẽ có getter, setter ngầm định
    //và getter và setter cho numberOfEdit sẽ có access level là internal vì ...
    //...vì numberofedit có access level là internal.
    //bây giờ ta giới hạn lại setter của numberofedit đến fileprivate or private.
    var value: String = "" {
        didSet {
            numberOfEdit += 1
        }
    }
}

//dùng thử
var strckSring = StrackedString()
strckSring.value = "This string will be tracked."
strckSring.value += " This edit will increment numberOfEdits."
strckSring.value += " So will this one."
print("the number of edit is: \(strckSring.numberOfEdit)")


//Note that you can assign an explicit access level for both a getter and a setter if required.

public struct TrackedString2 {
    public private(set) var numberOfEdit = 0
    public var value: String = "" {
        didSet {
            numberOfEdit += 1
        }
    }
    public init() {}
}


//Initializers
//Custom initializers can be assigned an access level less than or equal to the type that they initialize
//nhu fucntion thoi



//Protocols
//If you want to assign an explicit access level to a protocol type, do so at the point that you define the protocol.
//The access level of each requirement within a protocol definition is automatically set to the same access level as the protocol.
//You can’t set a protocol requirement to a different access level than the protocol it supports. This ensures that all of the protocol’s requirements will be visible on any type that adopts the protocol.

//f you define a public protocol, the protocol’s requirements require a public access level for those requirements when they’re implemented.
//This behavior is different from other types, where a public type definition implies an access level of internal for the type’s members.


//Protocol Inheritance
//If you define a new protocol that inherits from an existing protocol, the new protocol can have at most the same access level as the protocol it inherits from.
//You can’t write a public protocol that inherits from an internal protocol, for example.



//Protocol Conformance
//A type can conform to a protocol with a lower access level than the type itself
//For example, you can define a public type that can be used in other modules,
//but whose conformance to an internal protocol can only be used within the internal protocol’s defining module.


//Extensions
//Generics
//để sau @@

//mỗi vụ access level mà nhứt đầu vcl
//thôi dẹp qua 1 bên
//xem cho biết
//làm singla target app thì k biết cũng đc
//next thôi. đủ rồi :))
