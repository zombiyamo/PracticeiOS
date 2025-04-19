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
