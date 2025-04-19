import UIKit

// mixigroup/2025BeginnerTrainingiOS at session-0 Swiftの基本
// https://github.com/mixigroup/2025BeginnerTrainingiOS/tree/session-0?tab=readme-ov-file


// 変数var定数let
var mutable = "Apple"
mutable = "Lemon"

let immutable = "Apple"
// immutable = "Lemon" error Cannot assign to value: 'immutable' is a 'let' constant

// Optional
var age: Int? = 42
age = nil

var userId: Int = 1234
// userId = nil error 'nil' cannot be assigned to type 'Int'

// nil check これOptional Bindingって言うらしい。へー。
var optionalValue: Int? = 1
if let value = optionalValue {
    print("Value: \(value)")
} else {
    print("Couldn't bind an optional value")
}

// 変数名を変えない場合
if let optionalValue {
    print("Value: \(optionalValue)")
} else {
    print("Couldn't bind an optional value")
}

// 値を取り出さずに値を参照したい場合
let optionalImagePath: String? = "logo.png"
if optionalImagePath?.hasSuffix(".png") == true {
    print("The image is PNG format")
    // Optional Chainingの結果はOptional型になる
    print(optionalImagePath?.hasSuffix(".png")) // "Optional(true)\n"
}

// Optional方の変数がnilならデフォルト値を返したい場合、??を使う
// OptionalBindingの場合
var result: Int
if let value = optionalValue {
    result = value
} else {
    result = 0
}
// ??を使う場合(Optional Bindingより簡潔)
result = optionalValue ?? 0

// 強制アンラップ(nilに対して強制アンラップをするとexceptionを吐くので非推奨)
optionalValue = nil
// let value = optionalValue! // error:queue = 'com.apple.main-thread', stop reason = EXC_BREAKPOINT (code=1, subcode=0x195713658)

// 関数
// 1行のみの場合はreturnを省略できる
func greet(person: String) -> String {
    "Hello, \(person)!"
}
// 以下と同義
//func greet(person: String) -> String {
//    let greeting = "Hello, " + person + "!"
//    return greeting
//}

print(greet(person: "Alice"))

// 引数ラベル
func move(from home: String, to office: String) {
    print( "Moving from \(home) to \(office)." )
}

move(from: "Chiba", to: "Tokyo")

// クロージャ(多言語の無名関数と同義)
var decorate: (Int) -> String = { number in "[[\(number)]]"}
decorate(100)

// sortedはクロージャを受け取ることができる
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
// トレイリングクロージャで丸括弧省略
names.sorted { $0 < $1 }

// 式 評価されると値になる
let number: Double = if Bool.random() { 2.718 } else { 3.14 }
let state: State = .failure(DummyError())
let word: String = switch state {
case .success: "guitar"
case .failure: "piano"
}

// Associated Values
enum State {
    case success
    case failure(Error)
}

struct DummyError: Error {}
switch state {
case .success:
    print("Success!")
case .failure(let error):
    print("Error: \(error)")
}

// 文 評価されても値にならない
let number2: Double
if Bool.random() {
    number2 = 2.718
} else {
    number2 = 3.14
}
let word2: String
switch state {
case .success:
    word2 = "guitar"
case .failure:
    word2 = "piano"
}

// enum
enum CompassPoint {
    case north
    case south
    case east
    case west
}
var point = CompassPoint.north
point = .south // 型名省略可

let directionToHead: CompassPoint = .south
// 推奨される書き方
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

// default指定可能
switch directionToHead {
case .north:
    print("Lots of planets have a north")
default: break // caseが追加されたときにエラーが出ないので非推奨
}

// structとclass
// 推奨
struct SomeStructure {
    // structure definition goes here
}
// 保持データの同一性担保が必要な場合、またはObjective-Cとの互換性が必要な場合に使用
class SomeClass {
    // class definition goes here
}

// 上記のStateをstructを使って表現する場合
// 推奨
struct AnotherState {
    var state: State
    
    enum State {
        case success
        case failure(Error)
    }
}
AnotherState(state: .success)

// 非推奨
struct AnotherState2 {
    var state: State
    var error: Error?
    
    enum State {
        case success
        case failure
    }
}
// stateがsuccessなのにerrorが非nilという本来表現できない状態を表現できてしまうため非推奨
AnotherState2(state: .success, error: DummyError())

// structで定義した方は値型
struct S {
    var value: Int
}

var a = S(value: 1)
var b = a // 値型のインスタンスを別の変数に格納すると、それぞれメモリ上は別管理となる

b.value = 2
print(a.value) // メモリ上はbと別管理のため、bの変更は影響しない
// a: 1
print(b.value)
// b: 2

// classで定義した型は参照型
class C {
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
}

var a2 = C(value: 1)
var b2 = a2 // 参照型なのでメモリ上の同じ場所を指し示す

b2.value = 2
print(a2.value) // b2の変更の影響を受ける
// a2: 2
print(b2.value)
// b2: 2

// ARC (Automatic Reference Counting) Swiftのメモリ管理　参照カウントが0にならない限りメモリ解放しない
class Person {
    let name: String
//    var apartment: Apartment?
    weak var apartment: Apartment? //弱参照 参照カウントに加算されない
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let person: Person
    
    init(person: Person) {
        self.person = person
        person.apartment = self
    }
    
    deinit {
        print("Apartment is being deinitialized")
    }
}

var person: Person? = Person(name: "Tom")
// Personの参照カウント1
var apartment: Apartment? = Apartment(person: person!)
// Apartmentの参照カウント1
// Personの参照カウント2

person = nil
// Personの参照カウント1
apartment = nil
// Apartmentの参照カウント0
// Prints "Apartment is being deinitialized"
// Personの参照カウント0
// Prints "Person Tom is being deinitialized"


// PersonのpropertyにApartmentを持たせた場合
//var person: Person? = Person(name: "Tom")
// Personの参照カウント1
//var apartment: Apartment? = Apartment(person: person!)
// Apartmentの参照カウント2
// Personの参照カウント2

//person = nil
// Personの参照カウント1
//apartment = nil
// Apartmentの参照カウント1
// 循環参照になってしまうため永遠にメモリ解放されない

// 弱参照を使用した場合
// 参照カウントに加算されないため循環参照にならない

// じゃあ全部weakで良くない？
//strong（デフォルト）    所有してる＝確実に生きてる、安心して使える 非Optional
//weak    所有しない＝解放されてもいい、循環参照を防ぐための措置　Optional

// Protocols AndroidでいうInterface
protocol Drink {
    // 定価
    var price: Double { get }
    func serve()
}

// extensionはプロトコル拡張 別で実装しなければここのがデフォルトで使われる
extension Drink {
    func serve() {
        print("Serving a drink: $ \(price)")
    }
}

struct Soda: Drink {
    let price: Double
}

let soda = Soda(price: 2.5)
soda.serve()
// Serving a drink: $ 2.5

protocol Discountable {
    var discountPrice: Double { get }
}

struct Coffee {
    let price: Double
}

// CoffeeにDiscountableを適用し、割引対応を追加
extension Coffee: Discountable {
    // $1 discount
    var discountPrice: Double { 1.0 }
}

// デフォルト実装を上書きすることも可能
extension Coffee: Drink {
    func serve() {
        print(
            "Serving a coffee: $\(price - discountPrice), $\(discountPrice) off"
        )
    }
}

let coffee = Coffee(price: 3.0)
coffee.serve()
