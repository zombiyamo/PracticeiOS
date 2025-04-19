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
