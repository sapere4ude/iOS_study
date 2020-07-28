# iOS_study

swift를 이용한 iOS 앱 만들기에 필요한 과정들을 공부하고 정리해두는 공간입니다

# Closures

 * self-contained code blocks 이라고 부른다

 * 기본 모양
   
   ```
   {
     (parameters) -> ReturnType in
      statements
   }

            {statements}
    ```
<br>

* <strong>Closures 는 global scope 에서 단독으로 작성할 수 없다.</strong>
    ```
    let c = { print("Hello, Swift") } 
    // 이런식으로 상수안에 넣어줘야 사용가능하다.
    c() // 호출하면 Hello,Swift 가 나오는 걸 확인할 수 있다.
    ```
<br>

* str 은 파라미터일 뿐이지 argument label의 역할은 하지 않는다.
    ```
    let c2 = { (str: String) -> String in
        return "Hello, \(str)"
    }

    let result = c2("Closure") // 클로저를 호출할때 argument label을 호출 하지 않은 것을 확인할 수 있다.
    print(result) // Hello, Closure

    ```
<br>

* Closure를 파라미터로 전달
    ```
    typealias SimpleStringClosure = (String) -> String
    func perform(closure: SimpleStringClosure){
        print(clousre("iOS"))
    }
    perform(closure: c2)    // argument로 전달하는 c2가 파라미터인 SimpleStringClosure로 전달된다.
    ```
<br>

* Closure 자체를 직접 argument에 전달 ( inLine Closure )
    ```
    perform(closure:{ (str: String) -> String in
        return "Hi, \(str)" // "Hi,iOS"
    })

    ```
<br>

* Closure 사용 예시 1
    ```
    import Foundation

    let Product = [
        "MacBook Air", "MackBook Pro",
        "iMac", "iMac Pro", "Mac Pro", "Mac mini",
        "iPad Pro", "iPad", "iPad mini", 
        "iPhone 11Pro", "iPhone 11", "iPhone XS", "iPhone XR"
        "AirPods", "AirPods Pro"
        "Apple Watch Serires 5", "Apple Watch Nike+"
    ]

    var proModels = products.filter({(name: String) -> Bool // 우리가 직접 클로저를 호출하는 것 X . 필터 메소드를 호출하면 실행되는 것
        in
        return name.contains("Pro")
    })

    print(proModels)    // ["MacBook Pro", "iMac Pro", "Mac Pro", "iPad Pro", "iPhone 11Pro", "AirPods Pro"]

    print(proModels.sorted())

    proModels.sort(by: {(lhs: String, rhs: String) -> Bool  // 대소문자 관련없이 오름차순으로 정렬시킬 수 있다.
        in
        return lhs.caseInsensitiveCompare(rhs) == .orderedAscending
    })

    print(proModels)

    ```
<br>

*  Closure 사용 예시 2
    ```
    import Foundation


    print("Start")

    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {  // inLine Closure
        print("End")
        
    })

    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {   // Syntax Optimization (문법최적화)
        print("End")
    }
    ```
<br>

* Syntax Optimization  <strong>(매우 중요!)</strong>
    ```
    // 예시 1

    // 기존 형식
    var proModels = products.filter({(name: String) -> Bool
        in
        return name.contains("Pro")
    })

    // 규칙1. 파라미터 형식 생략 & 리턴형 생략가능
    products.filter({(name) in
        return name.contains("Pro")
    })

    // 규칙2. 파라미터 이름과 in 키워드 생략 & Shortand argument 이름으로 대체, 첫번째 파라미터이기에 $0
    // 만약 두번째 파라미터가 존재한다면 $1 으로 작성한다.

    products.filter({
        return $0.contains("Pro")
    })

    // 규칙3. return 키워드 생략. implicit return ( 암시적 반환 )
    products.filter({
        $0.contains("Pro")
    })


    // 규칙4. trailing closure ( inLine 클로저를 괄호 뒤로 빼는 방식 )
    products.filter(){
        $0.contains("Pro")
    }

    // 규칙5. ( ) 사이에 코드가 없을 경우 생략한다
    products.filter {
        $0.contains("Pro")
    }

    // 예시 2

    // 기존 형식
    proModels.sort(by: {(lhs: String, rhs: String) -> Bool
        in
        return lhs.caseInsensitiveCompare(rhs) == .orderedAscending
    })


    // 규칙1. 파라미터 형식 생략 & 리턴형 생략가능
    proModels.sort(by: {(lhs, rhs) in
        return lhs.caseInsensitiveCompare(rhs) == .orderedAscending
    })

    // 규칙2. 파라미터 이름과 in 키워드 생략 & Shortand argument 이름으로 대체, 첫번째 파라미터이기에 $0
    // 만약 두번째 파라미터가 존재한다면 $1 으로 작성한다.
    proModels.sort(by: {
        return $0.caseInsensitiveCompare($1) == .orderedAscending
    })

    // 규칙3. return 키워드 생략. implicit return ( 암시적 반환 )
    proModels.sort(by: {
        $0.caseInsensitiveCompare($1) == .orderedAscending
    })

    // 규칙4. trailing closure ( inLine 클로저를 괄호 뒤로 빼는 방식 )
    proModels.sort(){   // argument Label인 by: 를 삭제할 수 있다
        $0.caseInsensitiveCompare($1) == .orderedAscending
    }

    // 규칙5. ( ) 사이에 코드가 없을 경우 생략한다
    proModels.sort{
        $0.caseInsensitiveCompare($1) == .orderedAscending
    }

    ```
<br>

*  Capturing Values

```
    // Closure 내부에서 외부의 값에 접근하면 값에 대한 참조를 획득한다. 내부에서 값을 바꾼다면 외부의 값도 함께 바뀐다.

    var num = 0

    let c = {
        num += 1 // 외부에서 선언된 값을 클로저 내부로 가져와 변경할 수 있다
        print("check point #1 : \(num)")    // 윗라인에서 선언한 num 변수의 값을 캡쳐하여 가져옴, check point #1 : 1
    }

    c()


    print("check point #2 : \(num)") // check point #2 : 1
```
<br>

# Tuples

* Tuple Expression
```
// 표현방법
(expr1, expr2, ...)

// 형식
let i = (12, 34)    // 튜플형식, compound type
let data = ("<html>", 200, "OK", 12.34) // 가상의 데이터, 튜플에 4가지 맴버가 저장되어 있다
// 맴버를 삭제하는건 불가능. 값은 변경하는건 가능
```

* Explicit Member Expression
```
// 표현 방법
tuple.n << n은 0번 인덱스부터 시작한다

// 형식
data.0
data.1
data.2
data.3

var mutableTuple = data         // mutable : 값을 바꿀수 있다 라는 의미 (가변성)
mutableTuple.1 = 404
mutableTuple.1
```

* Named Tuples

```
// 표현 방법
(name1: expr1, name2: expr2, ...)
tuple.memberName

// 형식
let data = ("<html>", 200, "ok", 12.34)

let named = (body: "<html>", statusCode: 200, statusMessage: "OK", dataSize: 12.34)

named.statusCode    // 200
named.1             // 200
```

* Tuple Decomposition

```
// Decomposition : 분해라는 뜻을 갖는다
// 튜플에 저장된 맴버를 개별 상수나 개별 변수에 따로 저장하는 방법

let data = ("<html>", 200, "OK", 12.34)

// 방법1. 개별 변수들을 상수에 저장하는 방법
//let body = data.0
//let code = data.1
//let message = data.2
//let size = data.3

// 방법2. Decomposition 
let (name1, name2, ...) = tupleExpr
var (name1, name2, ...) = tupleExpr

let (body, code, message, size) = data  // data 의 갯수에 맞게 맞춰줘야한다

// 만약 size 값을 뽑아내고 싶지 않다면 와일드카드 연산자를 사용하면 된다.
//let (body, code, message, _) = data
```

* Tuple Matching

```
let resolution = (3840.0, 2160.0)

if resolution.0 == 3840 && resolution.1 == 2160 {
    print("4K")
}

// switch 문법은 tuple을 지원한다. if문보다 훨씬 간결하게 코드를 작성할 수 있는 장점이 있다.

switch resolution {
case let(w, h) where w / h == 16.0 / 9.0:
    print("16:9")
case (_, 1080): // 너비는 생각하지 않으니깐 와일드카드 문자로 두고 높이만 작성해줌
    print("1080p")
case (3840...4096, 2160):   // case 블록에서 tuple을 매칭시키는 중, interval 매칭도 가능하다
        print("4K")
default:
    break
}
```

# String and Characters

* String and Characters

```
// 문지열로 처리
let s = "String"

// 문자로 처리되기 위해선?
let c: Character = "C"

// 빈 문자를 저장하려면? >> 문자열 사이에 공백을 넣어줘야 한다
let emptyChar: Character = " "

// 빈 문자열이 저장된 것 X, 공백이 포함된 문자열이 저장된 것이다
let emptyString = " "
emptyString.count   // 1이 나오는 것을 확인 >> 빈 문자열이 아님을 알 수 있다

// 빈 문자열이 되기 위해선 공백이 없어야 한다
let realEmptyString = ""
realEmptyString.count

// 문자열 생성자로 빈문자열을 생성할 수도 있다
let emptyString2 = String()
```

* String Types

```
// String 의 종류
// String >> Swift String , NSString >> Foundation String

var nsstr: NSString = "str"
// swift 문자열을 foundation 문자열에 저장할 때는 type casting 한 뒤에 저장해야 한다
let swiftStr: String = nsstr as String
// foundation 문자열을 swift 문자열로 저장할 때도 마찬가지로 type casting 과정이 필요하다
nsstr = swiftStr as NSString

// cf. Toll-Free Bridged : type casting 으로 호환이 가능한 자료형을 의미한다
```

* Mutablitiy

```
// 문자열의 가변성은 let, var 키워드로 결정된다.

// 바꿀 수 없는 문자열
let immutableStr = "str"
// immutableStr = "new str"     // error

// 바꿀 수 있는 문자열
var mutableStr = "str"
mutableStr = "new str"          // 문자열을 변수로 설정하면 언제든 바꿀 수 있다.
```

* Unicode

```
let str = "Swift String"    // Unicode에 독립적인 문자열

str.utf8
str.utf16

var thumbUp = "👍🏻"

thumbUp = "\u{1F44D}"   // 유니코드 스칼라 방식

//👍🏻
//올린 엄지
//유니코드: U+1F44D U+1F3FB, UTF-8: F0 9F 91 8D F0 9F 8F BB
```

* Multiline String Literals

```
let Apple = "Apple began work on the first iPhone in 2005 and the first iPhone was released on June 29, 2007. The iPhone created such a sensation that a survey indicated six out of ten Americans were aware of its release."

let multiline = """
Apple began work on the first iPhone in 2005 and the first iPhone was released on June 29, 2007. The iPhone created such a sensation that a survey indicated six out of ten Americans were aware of its release.
""" // 첫문단의 시작 열과 맞춰서 작성해줘야 에러가 나지 않는다.
```

* String Interpolation

```
// String Interpolation : 문자열 삽입으로 이해하면 된다
// 문자열을 동적으로 구성하는 두 가지 방법을 공부

var str = "12.34KB"

let size = 12.34

//str = size + "KB"   // 두 값의 자료형을 일치시켜야 가능하다

str = String(size) + "KB"   // Double형을 String으로 변환 << 많이 사용하진 않음

str = "\(size)KB"   // 문자열을 쉽게 유추 가능해짐, 직관적!

// 단점 : 원하는 포맷을 직접 지정할 수 없다
```

* Format Specifier

```
// 소수점 첫번째 자리까지만 출력하는 코드
str = String(format: "%.1fKB", size)    // .1 : 소수점 첫번째자리 까지 출력, f 는 실수를 출력하는 포맷 지정자로 사용된다

// 기본적인 포맷 지정자

String(format: "Hello, %@", "Swift")

String(format: "%d", 12)

String(format: "%10.3f", 12.34) // 전체 출력범위를 10자리로 두고 소수점 3자리까지 출력

String(format: "[%d]", 123)
String(format: "[%10d]", 123)   // 오른쪽 정렬
String(format: "[%-10d]", 123)  // 왼쪽 정렬

// 다국어 포맷 문자열
let firstName = "Yoo"
let lastName = "jaejun"

let korFormat = "나의 이름은 %2$@ %1$@ 입니다."
let engFormat = "My name is %@ %@."

String(format: korFormat, firstName, lastName)
String(format: engFormat, firstName, lastName)


// Escape Sequence (백슬래쉬 저장)
str = "\\"
print(str)

print("A\tB")   // tab 추가
print("C\nD")

print("\"Hello\" He is...")
print("\'Hello\' He is...")
```

* String Indices

```
let str = "Swift"

let firstCh = str[str.startIndex] // 특정 문자에 접근할때는 SubScript 문법을 사용한다. fistCh 상수에는 S 가 저장된다.

print(firstCh)

//let lastCh = str[str.endIndex] // endIndex: 마지막 인덱스의 다음 순서 (past the end)
//print(lastCh)

let lastCharIndex = str.index(before: str.endIndex)
let lastCh = str[lastCharIndex] // SubScript로 마지막 인덱스 이전을 설정해준다
print(lastCh)


let secondCharIndex = str.index(after: str.startIndex)
let secondCh = str[secondCharIndex]
print(secondCh)

// cf. SubScript란? >> 컬렉션, 리스트, 시퀀스 타입의 개별 요소에 접근할 수 있는 지름길을 제공하는 것

var thirdCharIndex = str.index(str.startIndex, offsetBy: 2) // startIndex에서 2개 이후의 것이 입력됨

var thirdCh = str[thirdCharIndex]
print(thirdCh)
```

* String Basics

```
//
//  Copyright (c) 2018 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
import UIKit

/*:
 # String Basics
 */
var str = "Hello, Swift String"
var emptyStr = ""   // 반드시 공백없이 작성해야 빈문자열이 만들어진다

let a = String(true)    // 문자열로 사용된 true

let b = String(12)      // 숫자 12가 아닌 문자열 12

let c = String(12.34)

let d = String(str)


let hex = String(123, radix: 16)    // 123이라는 문자가 16진수로 버뀐 것을 확인할 수 있다
let octal = String(123, radix: 8)
let binary = String(123, radix: 2)

// 특정 문자를 원하는 갯수만큼 만들어 초기화 하는 방법
let repeatStr = String(repeating: "👍🏻", count: 7)
let unicode = "\u{1f44f}"

let e = "\(a) \(b)"     // String Interpolation으로 연결시켜준 것
let f = a + " " + b
str += "!!"             // 복합할당 연산자


// 문자열 길이 확인
str.count
str.isEmpty  // 문자열 비어있는지 확인할 때 사용

// 문자열 비교
str == "Apple"
"apple" != "Apple"
"apple" < "Apple"

// 대소문자 변환
str.lowercased()    // 모든 문자를 소문자로 바꿔주는 키워드, 끝에 -ed 로 끝나는 것들은 원본은 그대로 두고 새로운 값을 전달해주는 역할을 한다
str.uppercased()
str                 // 원본은 그대로인것을 확인할 수 있다

"apple ipad pro".capitalized     // 문자열의 첫번째르 대문자로 변경


// Character Sequence (문자 집합)
for char in "Hello" {
    print(char)
}

let num = "1234567890"
num.randomElement()
num.shuffled()      // 랜덤으로 섞어서 문자 배열로 리턴해준다

```

* Substring

```
// 1. Substring : 하나의 문자열에서 특정 범위에 있는 문자열을 부르는 말. 원본 문자열의 메모리를 공유한다!
// 사용하는 이유는? >> 문자열을 처리할때 메모리를 절약하기 위해서
// Swift엔 대부분 Copy on Write 방식이 적용되어 있다

let str = "Hello, Swift"

let l = str.lowercased()    // lowercased() >> 문자열을 받아와 전부 소문자로 바꾸어주고 새로운 문자열로 저장해주는 것

var first = str.prefix(1)   // 첫번째 문자 h가 추출되어 first에 저장된다

first.insert("!", at: first.endIndex)   // insert 메소드는 원본 문자열을 변경할 수 있게 한다

let newStr = String(str.prefix(1))


// 2. 문자열의 특정 범위 추출

//let s = str[str.startIndex ..< str.index(str.startIndex, offsetBy: 2)]
let s = str[ ..<str.index(str.startIndex, offsetBy: 2)]     // << one sided ranges 사용
str[str.index(str.startIndex, offsetBy: 2)...]              // << one sided ranges 사용

let lower = str.index(str.startIndex, offsetBy: 2)
print(str[lower])
let upper = str.index(str.startIndex, offsetBy: 5)
print(str[upper])
str[lower ... upper]

```

* String Editing #1

```

```


