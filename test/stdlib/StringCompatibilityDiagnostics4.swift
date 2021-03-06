// RUN: %target-swift-frontend -typecheck -swift-version 4 %s -verify

func testPopFirst() {
  var str = "abc"
  _ = str.popFirst() // expected-error{{'popFirst()' is unavailable: Please use 'first', 'dropFirst()', or 'Substring.popFirst()'}}
  _ = str.characters.popFirst() // expected-warning{{'characters' is deprecated: Please use String directly}}
    // expected-error@-1{{'popFirst()' is unavailable: Please use 'first', 'dropFirst()', or 'Substring.popFirst()'}}
  _ = str.popFirst() // expected-error{{'popFirst()' is unavailable: Please use 'first', 'dropFirst()', or 'Substring.popFirst()'}}
  _ = str.unicodeScalars.popFirst() // expected-error{{'popFirst()' is unavailable: Please use 'first', 'dropFirst()', or 'Substring.UnicodeScalarView.popFirst()'}}

  var charView: String.CharacterView // expected-warning{{'CharacterView' is deprecated: Please use String directly}}
  charView = str.characters // expected-warning{{'characters' is deprecated: Please use String directly}}
  dump(charView)

  var substr = str[...]
  _ = substr.popFirst() // ok
  _ = substr.characters.popFirst() // expected-warning{{'characters' is deprecated: Please use Substring directly}}
  _ = substr.unicodeScalars.popFirst() // ok

  var charSubView: Substring.CharacterView // expected-warning{{'CharacterView' is deprecated: Please use Substring directly}}
  charSubView = substr.characters // expected-warning{{'characters' is deprecated: Please use Substring directly}}
  dump(charSubView)

  var _ = String(str.utf8) ?? "" // expected-warning{{left side of nil coalescing operator '??' has non-optional type 'String', so the right side is never used}}
  var _: String = String(str.utf8)! // expected-error{{'init(_:)' is unavailable: Please use non-failable String.init(_:UTF8View) instead}}
  var _: String = String(str.utf8) // ok
}



