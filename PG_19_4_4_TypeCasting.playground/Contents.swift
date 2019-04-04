import UIKit

class MediaItem {
    var name : String
    init(name : String) {
        self.name = name
    }
}

class Movie : MediaItem {
    var director : String
    init(name : String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song : MediaItem {
    var artist : String
    init(name : String, artist : String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "I Love you", director: "Uyen Nhi"),
    Song(name: "I Miss you", artist: "Hai Vu"),
    Song(name: "Miss Nhi", artist: "Ngoc Hai Vu"),
    Movie(name: "Love Nhi", director: "Hai Ngoc Vu")
]

//biến library ở trên sẽ được infer kiểu là [MediaItem]
//vì mediaItem là lớp cha của 2 thằng Movie và Song

//sử dụng is để check xem 1 instance có là kiểu dữ liệu của SUBCLASS
//nhớ là SUBCLASS nha
//về cơ chế thì nó tương tự cách DOWNCASTING
//cũng là từ cha -> down thành con
//chỉ là is thì k trả về kết quả
//chỉ dùng để check condition
//còn as! hay as? thì trả về kết quả

//example is
var countOfMovie = 0
var countOfSong = 0
for item in library {
    switch item {
    case is Movie:
        countOfMovie += 1
    case is Song:
        countOfSong += 1
    default:
        break
    }
}
print("count of Movie: \(countOfMovie)")
print("count of Song: \(countOfSong)")

//DOWNCASTING
//as? thì cast về optional value của SUBCLASS
//as! thì cast về optionalvalue của SUBCLASS và FORCE unwrapped. cho nên nếu k cast được thì văng lỗi luôn

//example

for item in library {
    switch item {
    case is Movie:
        let _movie = item as? Movie
        print("Movie with director is: \(_movie?.director ?? "")")
    case let x where x is Song:
        let _song = x as? Song
        print("Song with artist is: \(_song?.artist ?? "")")
    default:
        break
    }
}

//Type Casting for Any và AnyObject
//Any: cái gì cũng được. bao gồm cả function type
//AnyObject : class nào cũng được

//simple example

var thing = [Any]()

thing.append(8)
thing.append(3.14)
thing.append(true)
thing.append((9, 9))
thing.append({(name : String) -> String in "hello \(name)"})

for item in thing {
    switch item {
    case let item as Int:
        print("Int with value: \(item)")
    case let item as Double:
        print("Double with value: \(item)")
    case let item as Bool:
        print("Bool with value: \(item)")
    case let (a, b) as (Int, Int):
        print("Tuple with value (\(a), \(b))")
    case let closure as (String) -> String:
        print("closure with the returned value is: \(closure("Uyen Nhi"))")
    default:
        break
    }
}

//NOTE:
//as ở ví dụ trên là as ở trong case pattern, khác với as? hay as!

//các pattern thưởng thấy
//case let item as Int
//case let item as Int where item > 10
//case is Int

////Lưu ý là khi bạn muốn dùng 1 optional value gán cho Any thì bạn phải cast nó (dùng as) sang Any trước khi gán
//nhưng không khuyến khích làm đièu này

let x : Int? = 10
thing.append(x as Any)


//TỚI ĐÂY CÓ DẤU HỎI LỚN LÀ KHI NÀO DÙNG is, as, as?, as!

var song1 = Song(name: "song 1", artist: "Nhii")

var new1 = song1 as MediaItem
print(new1.name)

//có thể suy luận là as! và as? dùng cho downcast. còn ngược lại thì dùng mấy cái kia
//right?
