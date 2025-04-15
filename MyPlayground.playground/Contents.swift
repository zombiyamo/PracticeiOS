import UIKit

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
