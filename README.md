swift를 이용한 iOS 앱 만들기에 필요한 과정들을 공부하고 정리해두는 공간입니다
<br>
<br>

## 목차
1. [Function](#function)
2. [Optional](#Optional)
3. [Closures](#closures)
4. [Tuples](#tuples)
5. [String and Characters](#String-and-Characters)
6. [Collection](#Collection)
7. [Enumeration](#Enumeration)
8. [Property](#Property)
9. [Method and Subscript](#Method-and-Subscript)
10. [Inheritance and Polymorphism](#Inheritance-and-Polymorphism)
11. [Initializer and Deinitializer](#Initializer-and-Deinitializer)
12. [Extension](#Extension)
13. [Protocol](#Protocol)
14. [Memory,Value Type and Reference Type](#memory-value-type-and-reference-type)
15. [Generics](#Generics)
16. [Error Handling](#Error-Handling)
17. [Advanced Topics](#Advanced-Topics)
    
<br>
<br>
---

# Function

 * 함수와 메서드는 기본적으로 같다.
 * 상황이나 위치에 따라 다른 용어로 부른다.
   <br>구조체 / 클래스 / 열거형 등 특정 타입에 연관되어 사용하는 함수 : 메서드
   <br>모듈 전체에서 전역적으로 사용할 수 있는 것 : 함수  
     

<br>
<br>

# Optional

 * Optional이 필요한 이유는?  
  어떠한 변수에 값이 있을 수도 없을 수도 있는 경우를 대비하기 위함
 * 옵셔널을 사용할땐 강제 추출, 암시적 추출 옵셔녈을 사용하기보단 옵셔널 바인딩 & 옵셔널 체이닝을 사용하는 것이 훨씬 안전하다.
 * Optional Binding -> 이게 nil인지, 값이 있는지를 체크하는 것. 경우에 따라 결과를 달리하고싶을때 사용
 * Optional Chaining -> 하위 프로퍼티에 옵셔널 값이 있는지 연속적으로 체크하면서 중간에 nil이 하나라도 발견된다면 nil이 반환되는 형식

<br>
<br>

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
<br>

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
<br>

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
<br>

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
<br>

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
<br>

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
<br>

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
<br>

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
<br>

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
<br>

* Multiline String Literals

```
let Apple = "Apple began work on the first iPhone in 2005 and the first iPhone was released on June 29, 2007. The iPhone created such a sensation that a survey indicated six out of ten Americans were aware of its release."

let multiline = """
Apple began work on the first iPhone in 2005 and the first iPhone was released on June 29, 2007. The iPhone created such a sensation that a survey indicated six out of ten Americans were aware of its release.
""" // 첫문단의 시작 열과 맞춰서 작성해줘야 에러가 나지 않는다.
```
<br>

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
<br>

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
<br>

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
<br>

* String Basics

```
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
<br>

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
<br>
* String Editing #1

```
// 1. 문자열 뒤에 추가
var str = "Hello"
str.append(", ")                    // append 메소드는 대상을 직접 변경한다

let s = str.appending("Swift")      // -ed , -ing 가 붙은 메소드는 원본을 변경하지 않는다. 그렇기 때문에 값이 상수인지 변수인지 신경쓰지 않아도 괜찮다
str
s

// Appending Format 메소드
"File size is ".appendingFormat("%.1f", 12.3456)

// 2. 문자열 중간에 추가
var new_str = "Hello Swift"
// 문자열 index는 정수로 표현할 수 없다. 반드시 string index를 사용해야 한다.
new_str.insert(",", at: new_str.index(new_str.startIndex, offsetBy: 5))

if let sIndex = new_str.firstIndex(of: "S"){
    new_str.insert(contentsOf: "Awesome ", at: sIndex)
}
print(new_str)

```
<br>
* String Editing #2

```
// 문자 삭제 & 범위 삭제
var str = "Hello, Awesome Swift!!!"

let lastCharIndex = str.index(before: str.endIndex)
let lastCh = str[lastCharIndex]

var removed = str.remove(at: lastCharIndex)     // 삭제된 문자를 변수에 저장
print(str)      // remove로 인해 ! 하나가 삭제된 것을 확인할 수 있다

removed = str.removeFirst() // 삭제된 첫번째 문자열을 반환, "H"
removed // "H"
str     // "ello, Awesome Swift!!"

str.removeFirst(2)  //  "lo, Awesome Swift!!"
str                 //  "lo, Awesome Swift!!"

str.removeLast()    //  "!"
str                 //  "lo, Awesome Swift!"
    
str.removeLast(2)   //  "lo, Awesome Swif"
str                 //  "lo, Awesome Swif"



if let range = str.range(of: "Awesome"){
    str.removeSubrange(range)   //  "lo,  Swif"
    str                         //  "lo,  Swif"
}

str.removeAll()     //  "" , 빈문자열로 만들어주고 메모리 공간마저 삭제한다.

str.removeAll(keepingCapacity: true)    // 메모리 공간의 삭제를 막아주는 역할

str = "Hello, Awesome Swift!!!"

var substr = str.dropLast()     //  원본 문자열에서 마지막 문자열을 제외한 나머지를 공유하는 것
substr = str.dropLast(3)        //  str 문자열에서 마지막 3개의 문자를 제거하고 나머지를 공유하는 것

substr = str.drop(while: {(ch) -> Bool in
    return ch != ","
})
substr  // ", Awesome Swift!!!"

```
<br>

* String Comparison

```
// 1. 비교 연산자 활용
let largeA = "Apple"
let smallA = "apple"
let b = "Banana"

largeA == smallA    // false
largeA != smallA    // true

largeA < smallA     // true
largeA < b          // true
smallA < b          // false


// 2. compare(_:) 메소드 활용
largeA.compare(smallA) == .orderedSame                  // 두 문자열이 같은지 비교
largeA.caseInsensitiveCompare(smallA) == .orderedSame   // 대소문자 구분없이 두 문자열 비교

largeA.compare(smallA, options: [.caseInsensitive]) == .orderedSame

let str = "Hello, Swift Programming!"
let prefix = "Hello"
let suffix = "Programming"

str.hasPrefix(prefix)   // true
str.hasSuffix(suffix)   // false

// 대소문자 상관없이 비교하고싶을땐 이렇게
str.lowercased().hasPrefix(prefix.lowercased()) // true
```
<br>

* String Searching

```
// 1. 단어 검색
let str = "Hello, Swift"
str.contains("Swift")
str.lowercased().contains("swift")  // 대소문자 구분없이 비교하는 방법


// 2. 범위 검색
str.range(of: "Swift")
str.range(of: "swift", options: [.caseInsensitive])


// 3. 공통 접두어 검색
let str2 = "Hello, Programming"
let str3 = str2.lowercased()

var common = str.commonPrefix(with: str2)   // "Hello, "
common = str.commonPrefix(with: str3)       // "" << 공통된 문자열이 없어 빈문자열을 반환

// commonPrefix를 호출한 대상이 누구냐에 따라 결과값으로 나오는 것이 달라진다
str.commonPrefix(with: str3, options: [.caseInsensitive])   // "Hello, "
str3.commonPrefix(with: str, options: [.caseInsensitive])   // "hello, "
```
<br>

* String Options #1

```
// 1. Case Insensitive Option
"A" == "a"  // false

"A".caseInsensitiveCompare("a") == .orderedSame

"A".compare("a", options: [.caseInsensitive]) == .orderedSame

//NSString.CompareOptions.caseInsensitive

// 2. Literal Option

let a = "\u{D55C}"                  // "한"
let b = "\u{1112}\u{1161}\u{11AB}"  // "한"

a == b                              // true
a.compare(b) == .orderedSame        // true

a.compare(b, options: [.literal]) == .orderedSame

// 3. Backwards Option : 문자열의 검색 방향을 바꾸는 역할
// 문자열에서 첫 시작을 leading 끝을 trailing 으로 구분한다.
// leading -> trailing 방향으로 진행된다.

let korean = "행복하세요"
let english = "Be happy"
let arabic = "كن سعيدا"

if let range = english.range(of: "p"){
    english.distance(from: english.startIndex, to: range.lowerBound)
}

if let range = english.range(of: "p", options: [.backwards]){
    english.distance(from: english.startIndex, to: range.lowerBound)
}

// 4. Anchored Option
// 전체 문자열을 대상으로 검색하지 않는다. 검색 범위를 시작 부분이나 마지막 부분으로 제한한다

let str = "Swift Programming"

if let result = str.range(of: "Swift"){
    print(str.distance(from: str.startIndex, to: result.lowerBound))
} else {
    print("not found")
}

if let result = str.range(of: "Swift", options: [.backwards]){
    print(str.distance(from: str.startIndex, to: result.lowerBound))
} else {
    print("not found")
}

if let result = str.range(of: "Swift", options: [.anchored]){
    print(str.distance(from: str.startIndex, to: result.lowerBound))
} else {
    print("not found")
}

if let result = str.range(of: "Swift", options: [.anchored, .backwards]){
    print(str.distance(from: str.startIndex, to: result.lowerBound))
} else {
    print("not found")
}

// 이해 안됨
if let _ = str.range(of: "swift", options: [.anchored, .caseInsensitive]){
    print("Same prefix")
}

```

# Collection

* Array #1

```
// 1. 배열 생성 방법
let nums = [1,2,3]
nums

let srtArray: Array<String>
let strArray2: [String]     // 더 선호되는 방법


// 2. 배열 리터럴과 배열 자료형

let emptyArray: [Int] = []      // 빈 배열 리터럴을 만들어주려면 자료형을 명시해줘야 한다
let emptyArray2 = Array<Int>()  // 정식 문법으로 만든 것
let emptyArray3 = [Int]()

let zeroArray = [Int](repeating: 0, count: 10)  // 0이 10개를 채워진 Int 배열이 생성됨


// 3. 배열 요소의 수 확인 & 접근
nums.count

nums.count == 0     // 배열이 비어있는지 확인하기

nums.isEmpty        // 이렇게 비어있는지 확인하는게 더 좋은 방법


// 4. 서브스크립트 문법
let fruits = ["Apple", "Banana", "Melon"]
fruits[0]

fruits[2]

fruits[0...1]

// 속성을 사용하여 원하는 배열에 접근하는 방법이 더 안전하다
fruits[fruits.startIndex]
fruits[fruits.index(before: fruits.endIndex)]   // endIndex는 마지막 요소의 다음 요소를 의미한다. 그렇기 때문에 .index(before) 메소드를 사용하여 마지막 요소의 이전 요소를 찾아야 진짜 마지막 요소에 접근할 수 있게 되는 것

fruits.first       //   "Apple"
fruits.last        //   "Melon"

emptyArray.first   //   nil >> 배열이 비어있다면 nil을 리턴한다
emptyArray.last    //   nil >> 배열이 비어있다면 nil을 리턴한다

emptyArray[0]      //   이와같이 서브스크립트 문법을 사용하였을 경우 배열이 비어있다면 에러가 나고 종료될 수 있어 좋은 방법은 아니다

```
<br>

* Array #2

```
// 1. 배열 마지막에 새로운 요소 추가

var alphabet = ["A", "B", "C"]

alphabet.append("E")    // 동일한 자료형의 요소만 들어갈 수 있다.
//alphabet.append(2)      // error

alphabet.append(contentsOf: ["F", "G"]) // 2개 이상의 배열 추가 가능

// 2. 특정 위치에 새로운 요소 추가

alphabet.insert("D", at: 3) // at 은 insert 하게되는 순서를 의미

alphabet.insert(contentsOf: ["a", "b", "c"], at: 0)

// insert 메소드를 사용하면 오버헤드가 발생하므로 되도록이면
// append 메소드를 사용하는 것이 좋다

// 3. 특정 범위 교체

alphabet[0...2] = ["x", "y", "z"]   // 서브스크립트 방식을 사용하여 값 변경
alphabet    // ["x", "y", "z", "A", "B", "C", "D", "E", "F", "G"]
alphabet.replaceSubrange(0...2, with: ["a","b","c"])
alphabet    // ["a", "b", "c", "A", "B", "C", "D", "E", "F", "G"]

alphabet[0...2] = ["z"]
alphabet    // ["z", "A", "B", "C", "D", "E", "F", "G"]

alphabet[0..<1] = []    // 빈배열로 만들어주는 작업
alphabet    // ["A", "B", "C", "D", "E", "F", "G"]

// 4. 요소 삭제 (서브스크립트 문법을 사용한 방법 & 메소드를 사용한 방법)

alphabet = ["A", "B", "C", "D", "E", "F", "G"]
alphabet.remove(at: 2)  // "C"
alphabet    // ["A", "B", "D", "E", "F", "G"]

alphabet.removeFirst()  // "A"
alphabet    // ["B", "D", "E", "F", "G"]

alphabet.removeFirst(2) // ["E", "F", "G"] << 삭제된 값을 리턴해주지 않고 나머지 배열만 표시
alphabet    // ["E", "F", "G"]

alphabet.removeAll()
//alphabet.removeFirst() << 배열이 비어있는 상태에서 메소드를 호출한다면 에러가 발생한다.
// 만약 alphabet이 옵셔널 스트링으로 저장되어 있는거라면 nil 값을 반환해준다.

alphabet.popLast()  // nil

alphabet = ["A", "B", "C", "D", "E", "F", "G"]
alphabet.popLast()  // "G"  << 삭제되는 요소를 반환
alphabet    // ["A", "B", "C", "D", "E", "F"]

alphabet.removeSubrange(0...2)  // ["D", "E", "F"]
alphabet    // ["D", "E", "F"]

alphabet[0...2] = []    // 서브스크립트를 사용하여 배열을 삭제하는 방법
alphabet    // []

```
<br>

* Array #3

```
// 1. 배열 비교

let a = ["A", "B", "C"]
let b = ["a", "b", "c"]

a == b
a != b

// 메소드를 통한 비교
a.elementsEqual(b)
a.elementsEqual(b) { (lhs, rhs) -> Bool in                  // 클로저 사용
    return lhs.caseInsensitiveCompare(rhs) == .orderedSame  // 대소문자를 무시하고 비교
}

// 2. 요소 검색 & 인덱스 검색

let nums = [1, 2, 3, 1, 4, 5, 2, 6, 7, 5, 0]
// contains는 단순히 존재여부만 확인
nums.contains(1)    // true
nums.contains(8)    // false

nums.contains { (n) -> Bool in  // true  <<  클로저를 통한 존재여부 확인
    return n % 2 == 0
}

// 인덱스와 요소를 직접 검색
nums.first { (n) -> Bool in
    return n % 2 == 0               //  2 << 짝수인 첫번째 요소를 리턴
}

nums.firstIndex { (n) -> Bool in
    return n % 2 == 0               //  1 << 짝수인 첫번째 인덱스를 리턴
}

nums.firstIndex(of: 1)  //  0
nums.lastIndex(of: 1)   //  3

// 3. 배열 정렬과 역순 정렬
// sort -> 배열을 직접 정렬
// sorted -> 정렬된 새로운 배열을 리턴, 원본을 건들지 않음

// 불변 배열
nums.sorted()   //  [0, 1, 1, 2, 2, 3, 4, 5, 5, 6, 7] , 새롭게 정렬
nums            //  [1, 2, 3, 1, 4, 5, 2, 6, 7, 5, 0] , 원본 배열은 그대로

nums.sorted { (a, b) -> Bool in
    return a > b    //  [7, 6, 5, 5, 4, 3, 2, 2, 1, 1, 0] , 내림차순 정렬
}

nums.sorted().reversed()    // reversed 메소드는 새로운 배열을 생성하지 않는다. 배열의 메모리를 공유하면서                               // 역순으로 열거할 수 있는 형식을 리턴해준다

[Int](nums.sorted().reversed())     //  [7, 6, 5, 5, 4, 3, 2, 2, 1, 1, 0]


// 가변 배열
var mutableNums = nums  //  [1, 2, 3, 1, 4, 5, 2, 6, 7, 5, 0]
mutableNums.sort()      //  [0, 1, 1, 2, 2, 3, 4, 5, 5, 6, 7]
mutableNums.sorted()    //  [0, 1, 1, 2, 2, 3, 4, 5, 5, 6, 7]
mutableNums.reverse()   //  [7, 6, 5, 5, 4, 3, 2, 2, 1, 1, 0]


// 4. 특정 위치의 요소 교체
mutableNums.swapAt(0, 1)    //  [6, 7, 5, 5, 4, 3, 2, 2, 1, 1, 0]
                            //  0, 1 의 자리에는 인덱스를 적어주는 것

// 5. 랜덤 섞기
mutableNums.shuffle()       //  [3, 7, 2, 6, 1, 5, 2, 0, 1, 4, 5]


```
<br>

* Dictionary #1

```
// 1. 딕셔너리의 특징
// 정식 문법 : Dictionart<key,value>
// 단축 문법 : [key:value]

let dict1: Dictionary<String, Int>
let dict2: [String: Int]

// 2. 딕셔너리 리터럴
let words = ["A": "Apple", "B": "Banana", "C": "City"]

// 빈 딕셔너리 생성
let emptyDict: [String: String] = [:]
let emptyDict2 = [String: String]()
let emptyDict3 = Dictionary<String, String>()

// 3. 저장된 요소를 확인
words.count     //  3
words.isEmpty   //  false

// 요소에 접근할땐 서브스크립트 문법을 사용한다
words["A"]      //  "Apple" , Key를 전달
words["Apple"]  //   nil    , Value를 전달

let a = words["E"]                      //  a의 자료형은 옵셔널스트링
let b = words["E", default: "Empty"]    //  b의 자료형은 스트링

for k in words.keys{
    print(k)
}

for v in words.values{
    print(v)
}

for k in words.keys.sorted(){
    print(k)
}

let keys = Array(words.keys)        //  ["C", "A", "B"]
let values = Array(words.values)    //  ["City", "Apple", "Banana"]

```
<br>

* Dictionary #2

```
// 1. 새로운 요소 추가
// 키를 기준으로 추가한다. 서브스크립트 문법을 사용하는 방법이 가장 간단하다

var words = [String: String]()

words["A"] = "Apple"
words["B"] = "Banana"

words.count     //  2
words           //  ["B": "Banana", "A": "Apple"]

words["B"] = "Ball"     // 기존의 key가 존재하기 때문에 value만 교체된다
words                   // ["A": "Apple", "B": "Ball"]

// 메소드를 사용하여 요소 추가 (Insert + Update = Upsert)
words.updateValue("City", forKey: "C")      //  nil, 기존에 C라는 키에 값이 없었기 때문
words.updateValue("Circle", forKey: "C")    //  "City", 새롭게 변경된 값 이전의 값을 리턴해준다

// 2. 요소 삭제
// 서브스크립트 문법을 사용한 경우
words               //  "A": "Apple", "C": "Circle", "B": "Ball"]
words["B"] = nil    //  Key 와 연결된 value를 삭제해주는 방법

words               //  ["A": "Apple", "C": "Circle"]

words["Z"] = nil    //  존재하지 않는 키를 삭제하는 경우 아무런 에러없다

// 메소드를 사용한 경우
words.removeValue(forKey: "A")  //  "Apple", 삭제되는 key의 value 값을 리턴해준다
words                           //  ["C": "Circle"]
words.removeValue(forKey: "A")  //  nil, 삭제될 값이 없기때문에 nil을 반환해줌

words.removeAll()   //  [:], 전체 요소를 삭제할 때 사용

```
<br>

* Dictionary #3

```
// 1. 딕셔너리 비교
// 저장된 key와 value가 같다면 ture를 반환해준다. 순서는 상관없다.
// 대소문자 구분하므로 주의해야 한다
let a = ["A": "Apple", "B": "Banana", "C": "City"]
let b = ["A": "Apple", "C": "City", "B": "Banana"]

a == b  // true
a != b  // false

// 딕셔너리는 항상 일정한 배열을 갖지 않는다. 그렇기 때문에 비교시에 에러가 날 수 있다.
// 딕셔너리는 정렬된 컬렉션이 아니다
//a.elementsEqual(b) { (lhs, rhs) -> Bool in
//    print(lhs.key, rhs.key)
//    return lhs.key.caseInsensitiveCompare(rhs.key) == .orderedSame
//    && lhs.value.caseInsensitiveCompare(rhs.value) == .orderedSame
//}

let akeys = a.keys.sorted() // 오름차순 정리
let bkeys = b.keys.sorted()

akeys.elementsEqual(bkeys) { (lhs, rhs) -> Bool in
    guard lhs.caseInsensitiveCompare(rhs) == .orderedSame else {
        return false
    }
    
    guard let lv = a[lhs], let rv = b[rhs], lv.caseInsensitiveCompare(rv) == .orderedSame else {
        return false
    }
    return true
}

// 2. 딕셔너리 검색
// 검색을 할땐 클로저가 필요하다. 여기서 하는 작업은 클로저를 만들어 별도의 상수에 저장한 뒤 호출하는 형식이다
let words = ["A": "Apple", "B": "Banana", "C": "City"]
let c: ((String, String)) -> Bool = {
    $0.0 == "B" || $0.1.contains("i")   // key에 대문자 B가 포함되어 있거나 value에 소문자 i가 포함되어                                   // 있는 경우 true를 반환
}

words.contains(where: c)    //  true, 클로저에서 조건에 일치하는 것이 있기에 contains에서도 true를 리턴함

let r = words.first(where: c)       //  (key "B", value "Banana") << 튜플 형식으로 리턴해준다.
                            //  값이 저장되어 있지 않은 경우엔 nil을 리턴해준다. (옵셔널 튜플이기 때문)
                            //  딕셔너리이기때문에 리턴되는 결과가 계속 바뀔 수 있는것을 생각
                            //  저장되어 있는 것들의 순서가 일정하지 않기 때문

r?.key
r?.value

words.filter(c) //  반환타입이 Bool인 매개변수 함수 의 결과가 true면 새로운 컨테이너에 값을 담아 반환
```
<br>

# Enumeration

* Enumeration Types

```
// 열거형 -> 연관된 상수들을 하나의 묶음으로 만든 것
// 열거형은 독립적인 자료형. 사용하는 이유는? 1. 가독성 2. 안전성
// 열거형을 사용하지 않으면
// 값만으로도 어떤 역할을 하는지 알려주는 것이 좋은 코드이다

let left = "left"
let center = "center"
let right = "right"

var alignment = center

// 열거형 선언 방법
enum TypeName {
    case caseName
    case caseName, caseName
}

// 실제 사용법
enum Alignment{
    case left
    case right
    case center
}

Alignment.center    //  열거형 이름을 통해 정렬을 표현

var textAlignment = Alignment.center
textAlignment = .left   //  열거형은 이름을 생략할 수 있다. 단, 점은 생략하면 안된다.

// 열거형 비교
if textAlignment == .center {
    
}

switch textAlignment {
case .left:
    print("left")
case .right:
    print("right")
case .center:
    print("center")
}
```
<br>

* Raw Values

```
// 1. Raw Value 문법
기본형
enum TypeName: RawValueType{    // RawValueType -> String, Character, Number Types
case caseName = Value
}

enum Alignment: Int {
    case left
    case right = 100
    case center
}


// 2. Raw Value Type에 따른 기본값
Alignment.left.rawValue     //  0   <- 원시값이 저장되어 있지 않다면 자동으로 0부터 할당된다
Alignment.right.rawValue    //  100
Alignment.center.rawValue   //  101

//Alignment.left.rawValue = 10 // Cannot assign to property: 'rawValue' is immutable

Alignment(rawValue: 0)      //  left
Alignment(rawValue: 200)    //  nil

enum Weekday: String{       // 열거형은 이와 같이 한정된 값을 처리할 때 사용한다.
    case sunday
    case monday = "MON"
    case tuesday
    case wednesday
    case friday
    case saturday
}

Weekday.sunday.rawValue     //  "sunday"
Weekday.monday.rawValue     //  "MON"

enum ControlChar: Character {   // rawValue Type이 Character이기 때문에 자동생성 X. 그러므로 직접 지정해줘야 한다.
    case tab = "\t"
    case newLine = "\n"
}
```
<br>

# Structure and Class

*  Structure and Classes

```
// 1. Structure
struct Person {
    var name: String    // <- property
    var age: Int
    
    func speak() {      // <- method
        print("Hello")
    }
}
// 구조체를 호출하는 방법
let p = Person(name: "Steve", age: 50)  // 생성자를 만들어주는 것
p.name
p.age
p.speak()

// 함수와 메소드를 구분하는 방법 -> 함수는 이름만 호출, 메소드는 인스턴스 이름을 통해 호출

// 2. Classes
class Person {
    var name = "John Doe"
    var age = 0
    
    func speak(){
        print("Hello")
    }
}

```
<br>

*  Initializer Syntax

```
let str = "123"
let num = Int(str)

// 생성자는 인스턴스를 만들때 사용하는 특별한 메소드
// 생성자는 속성 초기화가 가장 중요하고 유일한 목적. 가능한 빠르게 실행될 수 있게 하는것이 중요

class Position {
    var x: Double
    var y: Double
    
    init(){     // 전달해야할 파라미터가 없으므로 빈 괄호 사용
        x = 0.0
        y = 0.0
    }
    
    init(value: Double){    // value 파라미터를 받아 x,y를 초기화
        x = value
        y = value
    }
}

// 생성자를 호출하여 인스턴스를 생성하는 방법
// 1. 파라미터가 없는 생성자를 호출
let a = Position()  // 새로운 인스턴스가 생성됨
a.x   // 0 <- 속성에 저장된 값은 초기값인 0 이다
a.y   // 0

// 2. 파라미터가 있는 경우
let b = Position(value: 100)
b.x   // 100
b.y   // 100

```
<br>

*  Value Types vs Reference Types

```
// Value Type : Structure, Enumeration, Tuple
// Reference Type : Class, Closure

// 속성은 선언과 동시에 기본값을 저장한다. 이렇게 하면 파라미터가 없는 생성자가 제공되는데 이를 기본 생성자 라고 한다.
struct PositionValue {
    var x = 0.0
    var y = 0.0
}

class PositionObject {
    var x = 0.0
    var y = 0.0
}

// 기본 생성자를 이용하여 인스턴스 만들기
var v = PositionValue()

var o = PositionObject()

var v2 = v  //  v 와 v2 가 저장된 공간은 서로다른 메모리 공간
var o2 = o  //  새로운 복사본이 생성되는 것 X , o2 변수에 저장되는 것은 인스턴스가 저장되어 있는 메모리 주소. o 변수에도 값이 저장되어 있는 메모리 주소가 저장되어 있다.
v2.x = 12
v2.y = 34
// 구조체 -> 값 형식 , v2에서 값을 바꿔도 v에 아무런 영향 X, v 와 v2 는 서로 다른 메모리 공간에 위치한다.
v
v2

o2.x = 12
o2.y = 34

// 클래스 -> 참조 형식, 클래스는 새로운 복사본을 생성하지 않고 원본을 전달한다. 더 정확히는 참조를 전달한다. 원본이 전달되기 떄문에 어떤 변수를 통해 속성을 변경하더라도 항상 같은 대상을 바꾸게 된다.
o
o2

// 값 형식을 다른 곳에 저장하거나 파라미터 또는 리턴형으로 전달하면 새로운 복사본이 생성된다.

// 참조 형식은 복사본을 생성하지 않는다. 대신에 인스턴스가 저장되어 있는 메모리 주소를 전달한다. 주소와 값을 별도의 메모리 공간에 저장하고 주소를 통해 값에 접근한다.
```
<br>

*  Nested Types

```
// Nested Types : 포함된 형식, 내포된 형식

// 1. 선언 문법
// 구조 : String.CompareOptions (String,CompareOptions 은 Structure를 의미한다.)

class One {
    struct  Two {
        enum Three {
            case a
            
            class Four {
                
            }
        }
    }
    var a = Two()   // One 클래스 내부에 있는 Two 구조체를 바로 인식할 수 있다.
}

let two: One.Two = One.Two() // 생성자를 만들때 포함관계에 있는 모든 구조를 작성해줘야 한다.
```
<br>

# Property
* 용어 정리  
프로퍼티 : 클래스,구조체,열거형 << 이것들의 객체 인스턴스가 그 내부에 가지고 있는 객체의 상태에 대한 정보  
인스턴스 : 클래스에서 생성된 객체


* Stored Properties
```
// 1. 저장 속성
// 클래스와 구조체에서 선언 가능. 저장 속성은 인스턴스에 속한 속성. 인스턴스가 생성될 때마다 새로운 메모리 공간이 생성된다.

class PersonClass {
    let name: String = "John Doe"
    var age: Int = 33
}

struct PersonStruct {
    let name: String = "John Doe"
    var age: Int = 33
}

// 새로운 인스턴스 만들고 속성에 저장된 값 확인
let p = PersonClass() // 인스턴스 생성
p.name
p.age

// 속성 값 변경
p.age = 30




// 구조체의 가변성은 속성에 영향을 주기때문에 var 로 선언해야한다
var ps = PersonStruct()
ps.name
ps.age
ps.age = 30

// 지연 저장 속성은 초기화를 지연시킨다. 속성에 처음 접근하는 시점에 초기화된다. 항상 변수로 선언해줘야하기 때문에 lazy var 로 선언해준다.
// 생성자에서 초기화 되는 것이 아니기 때문에 선언 시점에 기본값을 저장해야 한다.

struct Image {
    init() {
        print("new image")
    }
}

struct BlogPost {
    let title: String = "Title"
    let content: String = "Content"
    // let attachment: Image = Image() // <- let 으로 설정하는 경우엔 사용하지 않더라도 생성자가 만들어질때마다 호출하게 되어 오버헤드가 발생할 수 있다
    lazy var attachment: Image = Image() // <- 그렇기 때문에 호출했을때만 불러올 수 있는 방법인 lazy var 를 사용하는 것이 좋다.
    
    let date: Date = Date()
    lazy var formattedDate: String = {
       let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .medium
        return f.string(from: date)
    }()
}

var post = BlogPost() // <- 변수로 선언해줘야 attachmenet 를 사용할 수 있다
post.attachment

```
<br>

* Computed Property
```
// Computed Properties : 다른 속성을 기반으로 속성 값이 정해진다는 의미
// 계산 속성은 메모리 공간을 갖지 않는다. 속성에 접근할때마다 다른 값이 리턴될 수 있다.
// 반드시 자료형을 명시하여 사용해야 한다. 저장 속성과 달리 선언 시점에 기본 값을 저장할 수는 없다.
// get 키워드는 속성 값을 읽을때 사용하고 반드시 리턴형이 필요하고
// set 키워드는 속성 값을 저장할때 사용한다.

class Person {
   var name: String
   var yearOfBirth: Int

   init(name: String, year: Int) {
      self.name = name
      self.yearOfBirth = year
   }
    
    var age: Int {
        get {   // 주로 읽기 전용으로 만든다
            let calendar = Calendar.current
            let now = Date()
            let year = calendar.component(.year, from: now)
            return year - yearOfBirth
        }
        set {   // 예시를 들기 위해 만든 것 (지정된 나이를 계속 바꾸는 것도 이상하니깐...)
            let calendar = Calendar.current
            let now = Date()
            let year = calendar.component(.year, from: now)
            yearOfBirth = year - newValue // newValue를 사용한 이유는 set 키워드 옆에 파라미터가 생략되어있기 때문이다.
        }
    }
}

let p = Person(name: "Jaejun", year: 1994)
p.age   // get 블록이 실행된다

p.age = 50      // 값을 저장하는 것이기 때문에 set 블록이 실행된다.
p.yearOfBirth   // 새롭게 저장된 출생연도를 확인할 수 있다.

// 읽기 전용 계산 속성 : get 블록에서 get 키워드와 { } 블록을 생략하는 것
//var age: Int {
//        let calendar = Calendar.current
//        let now = Date()
//        let year = calendar.component(.year, from: now)
//        return year - yearOfBirth
//    }

```
<br>

* Property Observer
```
// 속성 감시자
// willSet : 속성에 값이 저장되기 직전에 호출된다. 새로 저장되는 값은 파라미터로 전달된다. 파라미터 이름을 생략하면 기본 파라미터인 newValue 가 제공된다.
// didSet : 값이 저장된 직후에 호출된다. 파라미터 이름을 생략하면 기본 파라미터인 oldValue 가 제공된다.
// Property Observer 가 되기 위해선 반드시 두 블록중 하나를 구현해야 한다.


class Size {
    var width = 0.0 {
        willSet {
            print(width, "->", newValue)
        }
        didSet {
            print(oldValue, "->", width)
        }
    }
}

let s = Size()
s.width = 123

```
<br>

* Type Property
```
// 형식 속성은 클래스, 구조체, 열거형에 사용될 수 있다. 반드시 형식의 이름을 통해 접근해야 한다.

class Math {
    static let pi = 3.14
}

let m = Math()
// m.pi <- error, pi는 형식 속성이기 때문에 반드시 이름을 통해 접근!
Math.pi // 3.14 , 이와 같이 속성에 처음 접근할때 초기화된다.

enum Weekday: Int {
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
    
    static var today: Weekday {
        let cal = Calendar.current
        let today = Date()
        let weekday = cal.component(.weekday, from: today)
        return Weekday(rawValue: weekday)!
    }
}

Weekday.today   // 해당 요일이 나옴

```
<br>

* self & super
```
/*
 self 는 인스턴스에 자동으로 추가되는 것
 self -> 인스턴스 자체에 접근할때 사용
 self.propertyName -> 인스턴스 속성에 접근할때 사용
 self.method() -> 인스턴스 메소드를 호출할때 사용
 self[index] -> 서브스크립트를 호출할때 사용
 self.init(parameters) -> 동일한 형식에 있는 다른 생성자를 호출할 때 사용
*/

class Size {
   var width = 0.0
   var height = 0.0
    
    func calcArea() -> Double {
        return width * height // self.width * self.height , self 없이 속성에 접근 가능하다.
    }
    // 계산 속성을 추가하고 메소드가 리턴하는 값을 그대로 리턴
    
    var area: Double {
        return calcArea() // self.calcArea() , 주로 self 를 생략하고 호출한다.
    }
    
    func update(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    
    func doSomething() {
        let c = { self.width * self.height } // 클로저에서 인스턴스 내부에 접근하려면 self를 캡쳐해야한다.
    }
    
    static let unit = ""
    
    static func doSomething() {     // 형식 메소드
        //self.width <- 형식 메소드에서 인스턴스 속성에 직접 접근하는것은 불가능
        self.unit   // 둘다 type 맴버이기 때문에 접근 가능하다
    }
}

// 정리
// 1. self는 현재 인스턴스에 접근하기 위해 사용하는 특별한 속성이다.
// 2. self를 type 맴버에서 사용하면 인스턴스가 아닌 형식 자체를 나타낸다.


// 값 형식에서 self를 활용하는 패턴
struct Size2 {
    var width = 0.0
    var height = 0.0

    mutating func reset(value: Double) {
//        width = value
//        height = value
        self = Size2(width: value, height: value)   // 생성자를 통해 초기화가 가능, 클래스에선 사용 할 수 없다.
    }
}
```

# Method and Subscript

* Instance Method
```
/*
 -문법선언-
 func name(parameters) -> ReturnType {
     Code
 }

 메소드 : 특정 함수에 속한 형식.
 Instance Method 는 클래스, 구조체, 열거형에서 사용할 수 있다.
 특정 인스턴스와 연관된 동작을 구현한다. 인스턴스 이름을 통해 호출한다.
 
 **/

class Sample {
    var data = 0
    static var sharedData = 123
    
    func doSomething(){
        print(data)
        Sample.sharedData   // 타입맴버에 접근할땐 클래스 이름을 통해 접근
    }
    
    func call() {
        doSomething()
    }
}

// 인스턴스를 만들고 메소드 호출, 메소드는 반드시 인스턴스 이름으로 호출해야 한다!
let a = Sample()    // a 라는 인스턴스가 생성된 것
a.data              // 데이터 속성에 접근
a.doSomething()
a.call()


// 1. class로 구현한 경우
/*class Size {
    var width = 0.0
    var height = 0.0
    
    func enlarge() {
        width += 0.0
        height += 0.0
    }
}

let s = Size()
s.enlarge()
*/

// 2. 구조체로 구현한 경우
struct Size {
    var width = 0.0
    var height = 0.0

    mutating func enlarge() {   // 값 형식에서 속성을 바꾸는 메소드를 구현할 경우엔 mutating 이 필요
        width += 0.0
        height += 0.0
    }
}

var s = Size()  // 변할 수 있기 때문에 var 에 저장해야 한다.
s.enlarge()

```
<br>

* Type Method

```
/*
 -문법선언-
 static func name(parameters) -> ReturnType {   // 오버라이딩 불가
     statements
 }

 class func name(parameters) -> ReturnType {    // 오버라이딩 가능
     statements
 }

 Type.method(parameters)
 
 타입 메소드는 인스턴스 메소드와 마찬가지로 클래스, 구조체, 열거형애서 구현할 수 있다.
 
 **/

class Circle {
    
    static let pi = 3.14    // 타입 속성 생성
    var radius = 0.0        // 인스턴스 속성 생성
    
    func getArea() -> Double {
        return radius * radius * Circle.pi  // 접근 방법의 차이 확인
    }
    
    class func printPi() { // 타입 속성을 생성했기에 타입 속성에 직접 접근이 가능함, 오버라이딩 가능
        print(pi)
    }
}

Circle.printPi()

class StrokeCircle: Circle {
    override static func printPi() {
        print(pi)
    }
}

```

<br>

* Subcript
```
/*
 - 구현된 subscripts
 instance[index]
 instance[key]
 instance[range]
 
 - 직접 정의하는 subscripts
 subscript(parameters) -> ReturnType {
    get {
        return expression
    }
    set(name) {
        statements
    }
 }
 
 **/



// 기존의 구현된 서브스크립트
let list = ["A", "B", "C"]
list[0] // <- 이런게 subscript

class List {
    var data = [1, 2, 3]
    
    subscript(index: Int) -> Int {
        get {
            return data[index]
        }
        set {
           data[index] = newValue
        }
    }
}

var l = List()
l[0]            //  1, get 블록 사용
l[1] = 123      //  123, set 블록 사용

// 구조체에서 subscript 를 구현하는 경우

struct Matrix {
    var data = [[1,2,3],
                [4,5,6],
                [7,8,9]]
    
    subscript(row: Int, col: Int) -> Int {  //  읽기 전용, get & set 블록 생략
        return data[row][col]
    }
}

let m = Matrix()
m[0,2]  //  2개 이상의 값을 넣어 서브스크립트에서 값을 얻고 싶으면 [ ]안에 ',' 를 통해 접근한다

```

<br>

# Inheritance and Polymorphism

* Inheritance
```
/*
 -문법구조-
 class ClassName: SuperClassName {
 
 }
 
 스위프트는 다중 상속을 지원하지 않는다. 다중상속을 피하기 위해 프로토콜을 사용한다.
 **/


class Figure {
    var name = "Unknown"
    
    init(name: String) {
        self.name = name
    }
    
    func draw() {
        print("draw \(name)")
    }
}

class Circle: Figure {
    var radius = 0.0
}

let c = Circle(name: "Circle")  // Figure 클래스로부터 생성자를 상속받은 것
c.radius
c.name
c.draw()

// sub class 는 super class 로 부터 맴버를 상속받는다 !

// final class 예제
final class Rectangle: Figure {
    var width = 0.0
    var height = 0.0
}

/* Rectangle 클래스가 final로 선언되어 있다는 것의 의미는 다른 클래스는 Rectangle 클래스를 상속할 수 없다는 걸 의미함
class Square: Rectangle {   // Square < Rectangle < Figure
     
}
*/

```
<br>

* Overriding
```
// 1. methods overriding
class Figure {
   var name = "Unknown"

   init(name: String) {
      self.name = name
   }

   func draw() {
      print("draw \(name)")
   }
}

class Circle: Figure {
    var radius = 0.0 // var 로 선언되었기 때문에 읽기, 쓰기 둘다 가능하다.
    var diameter: Double {
        return radius * 2
    }
    override func draw() {   // Figure 에 있는 draw()를 완전히 무시하고 새롭게 정의된 것
    super.draw()    // Figure에 존재하는 draw()를 실행시킴
    print("🏄🏻‍♂️")
    }
}

let c = Circle(name: "Circle")
c.draw()


// 2. Properties overriding

class Oval: Circle {
    override var radius: Double {   // Circle 클래스의 radius를 Override 하여 사용하려면 get, set 블록을 만들어줘야 한다. radius는 var 로 선언되어 있기 때문에!
        get {
            return super.radius
        }
        set {
            super.radius = newValue
        }
    }
    
    override var diameter: Double {
        get {
            return super.diameter
        }
        set {
            super.radius = newValue / 2
        }
    }
}

// 읽기 전용 속성을 읽기 & 쓰기가 가능한 속성으로 overriding 하는 것은 가능
// 읽기 & 쓰기가 가능한 속성을 읽기 전용 속성으로 overriding 하는 것은 불가능


// 3. Properties Observer
class Oval2: Circle {
    override var radius: Double {
        willSet {
            print(newValue)
        }
        didSet {
            print(oldValue)
        }
    }
    
// 불가능한 방법
//    override var diameter: Double {
//        willSet {
//            print(newValue)
//        }
//        didSet {
//            print(oldValue)
//        }
//    }
}

// 4. Overriding 을 금지하는 방법
// 여기 파트 나중에 추가하기
```
<br>

* Upcasting and Downcasting
```
class Figure {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func draw() {
        print("draw \(name)")
    }
}

class Rectangle: Figure {
    var width = 0.0
    var height = 0.0
    
    override func draw() {
        super.draw()
        print("⬛️ \(width) x \(height)")
    }
}

class Square: Rectangle {
   
}

let f = Figure(name: "Unknown") // 새로운 Figure 인스턴스를 생성
f.name

let r = Rectangle(name: "Rect")
r.width
r.height
r.name  // 상속받았으니깐 사용가능

// Upcasting : 서브클래스 인스턴스를 슈퍼클래스 형식으로 저장
let s: Figure = Square(name: "Square")  // 세 가지 속성에 모두 접근 가능하다
//s.width
//s.height
//s.name

// Downcasting :
let downcastedS = s as! Square
downcastedS.name
downcastedS.width
downcastedS.height


class Rhombus: Square {
    var angle = 45.0
}

let dr = s as! Rhombus  // 원본 클래스보다 아래쪽에 있는 서브클래스로 다운캐스팅 하는 것은 허용하지 않는다
```
<br>

* Type Casting
```
/* 1. Type Check Operator
    -표현방법-
    expression is Type
 
*/
let num = 123

num is Int
num is Double
num is String

let t = Triangle(name: "Triangle")
let r = Rectangle(name: "Rect")
let s = Square(name: "Square")
let c = Circle(name: "Circle")

r is Rectangle  // true
r is Figure     // true
r is Square     // false

// type check는 run time에 실행된다!

/* 2. Type Casting Operator
 
 Compile Time Cast >> expression as Type
 Runtime Cast >> expression as? Type (conditional cast) - 옵셔널하고 비슷한
                 expression as! Type (Forced cast) - 강제 추출
 
 */

let nsstr = "str" as NSString

t as? Triangle
t as! Triangle

var upcasted: Figure = s
upcasted = s as Figure  // upcasting은 안전하고 항상 성공한다

upcasted as? Square
upcasted as! Square
upcasted as? Rectangle
upcasted as! Rectangle

upcasted as? Circle
//upcasted as! Circle

let list = [t, r, s, c]     // 서로다른 형식이 들어가 있음 >> Figure 클래스로 upcasting 된 것을 확인할 수 있음

for item in list {
    item.draw()
    
    if let c = item as? Circle {    // downcasting 해서 속성에 접근하는 방식
        c.radius
    }
}
```
<br>

* Any and AnyObject
```
/*
 1. Any, AnyObject - 범용 자료형
 Any : 모든 형식을 저장할 수 있다
 AnyObject : 모든 클래스 형식을 저장할 수 있다
 */

var data: Any = 1  // 형식에 관계없이 모든 데이터를 저장할 수 있다
data = 2.3
data = "str"
data = [1,2,3]
data = NSString()   // NSString 과 String은 서로 호환이 가능하다

var obj: AnyObject = NSString()
//obj = 1

if let str = data as? String {  // String으로 type casting을 해준 것
    print(str.count)
} else if let list = data as? [Int] {   // <- 이런 방법은 타입캐스팅 패턴에서 자세하게 다시
    
}

// 2. Type Casting Pattern : 범용 형식으로 저장되었거나 upcasting된 메소드를 매칭시킬때 사용

switch data {
case let str as String:
    print(str.count)
case let list as [Int]:
    print(list.count)
case is Double:
    print("Double Value")
default:
    break
}
```
<br>

* Overloading
```
/*
 Overloading : 하나의 형식에서 동일한 이름을 가진 다수의 맴버를 구현할 때 사용
 Overloading Rule
 #1. 함수 이름이 동일하면 파라미터 수로 식별
 #2. 함수 이름, 파라미터 수가 동일하면 파라미터 자료형으로 식별
 #3. 함수 이름, 파라미터가 동일하면 Argument Label로 식별
 #4. 함수 이름, 파라미터, Argument Label이 동일하면 리턴형으로 식별
 */

func process(value: Int) {
    print("process Int")
}

func process(value: String) {
    print("process String")
}

func process(value: String, anotherValue: String) {
    
}

func process(_ value: String) { // Argument Label이 생략되어 있음
    
}

process(value: 0)
process(value: "str")
process("str")

func process(value: Double) -> Int {
    return Int(value)
}

func process(value: Double) -> String? {
    return String(value)
}

let result: Int = process(value: 12.34)     // 웬만하면 #4 를 사용하진 말자

// 메소드에서 사용
struct Rectangle {
    func area() -> Double {
        return 0.0
    }
    
    static func area() -> Double {
        return 0.0
    }
}

let r = Rectangle()
r.area()
Rectangle.area()
```
<br>

# Initializer and Deinitializer

* Initializers
```
// 선언과 동시에 기본 값을 저장
class Position {
    var x = 0.0    // 선언과 동시에 초기화하는 방법
    var y = 0.0
    var z: Double? = nil // 속성을 옵셔널로 저장. 옵셔널 속성은 기본값을 저장하고 있지 않으면 자동으로 nil로 초기화됨
    
//    init() {    // 파라미터를 통해 속성을 초기화 하는 경우 사용하는 방법
//        y = 0.0
//    }
}

let p = Position()  // 자동으로 default initializer가 생성된다

/*
 Initializer Syntax
 
 init(parameters) {
    initialization
 }
 
 TypeName(parameters)
 */

class SizeObj {
    var width = 0.0
    var height = 0.0
    
    init(width: Double, height: Double){
        self.width = width
        self.height = height
    }
    
    convenience init(value: Double) {
        //width = value
        //height = value
        self.init(width: value, height: value)  // Initializer Delegation, 이미 구현된 initializer를 불러와 사용하는 방법, Initializer는 overroading을 지원한다
    }
}

```
<br>

* class Initializers
```
// Designated Initializer : 지정 생성자

// Convenience Initializer : 간편 생성자

class Position {
    var x: Double
    var y: Double
    
    init(x: Double, y: Double) {    // Designated Initializer 의 핵심은 모든 속성을 초기화해야한다는 것
        self.x = x
        self.y = y
    }
    
    convenience init(x: Double) {   // 기존에 구현된 init 을 가져와서 사용하는 방식
        self.init(x: x, y: 0.0)
    }
}

class Figure {
   var name: String

   init(name: String) {
      self.name = name
   }

   func draw() {
      print("draw \(name)")
   }
    
    convenience init() {
        self.init(name:"Unknown")
    }
}

class Rectangle: Figure {
    var width: Double = 0.0
    var height: Double = 0.0
    
    init(name: String, width: Double, height: Double) {
        // 현재 클래스에 있는 것부터 작성
        self.width = width
        self.height = height
        // 이후에 상위 클래스에 있는 것 작성
        super.init(name: name)
    }
    
    override init(name: String) {
        width = 0
        height = 0
        super.init(name: name)
    }
    
    convenience init() {
        self.init(name:"Unknown")
    }
}

```
<br>

* Required Initializers
```
/*
Required Initializer : 필수 생성자
-문법구조-
 required init(parameters) {
    initialization
 }
 
*/
class Figure {
   var name: String

   required init(name: String) {  // 이렇게 required 키워드가 붙으면 서브클래스에서 반드시 동일하게 구현해줘야 한다
      self.name = name
   }

   func draw() {
      print("draw \(name)")
   }
}

class Rectangle: Figure {
   var width = 0.0
   var height = 0.0
    
    init() {
        width = 0.0
        height = 0.0
        super.init(name: "unknown")
    }
    required init(name: String) {
        width = 0.0
        height = 0.0
        super.init(name: name)
    }
}

```
<br>

* Initializer Delegation (어려움)
```
/*
Initializer Delegation: 초기화 코드에서 중복을 최대한 제거하고, 모든 속성을 효율적으로 초기화하기 위해 사용한다.
*/

// 값 형식: 상속 불가능, 이니셜라이저 종류가 하나기 때문에 상대적으로 단순
 struct Size {
   var width: Double
   var height: Double

   init(w: Double, h: Double) {
      width = w
      height = h
   }

   init(value: Double) {
        self.init(w: value, h: value)   // Initializer Delegation, 자신의 역할을 첫번째 이니셜라이저에게 위임하는 것
   }
}

/*
참조 형식 : 조금 복잡함
Rule1. A designated initializer must call a designated initializer from its immediate superclass. (Delegate Up)
Rule2. A convenience initializer must call another initializer from the same class. (Delegate Across)
Rule3. A convenience initializer must ultimately call a designated initializer.
*/

class Figure {
    let name: String
    
    init(name: String) {
        self.name = name // designated initializer
    }
    
    convenience init() {
        self.init(name: "unknown") // convenience initializer : 앞에서 정의한 designated initializer를 호출(Delegate Across)
    }
}

class Rectangle: Figure {
    var width = 0.0
    var height = 0.0
    
    init(n: String, w: Double, h: Double) { // designated initializer 호출한 뒤 마지막에 상위 구현을 호출 (Delegate Up)
        width = w
        height = h
        super.init(name: n)
    }
    
    convenience init(value: Double) {
        self.init(n: "rect", w: value, h: value)
    }
}

class Square: Rectangle {   // desiganted initializer 가 없는 클래스
    convenience init(value: Double) {   // convenience 로 만들면 절대로 delegate up 을 할 수 없다
        self.init(n: "Square", w: value, h: value)
    }
    convenience init() {    // convenience intializer 는 최종적으로 designated initializer 를 반드시 호출해야 한다
        self.init(value: 0.0)
    }
}

```
<br>

* Failable Initializer (어려움)
```
/* Failable Initializer : fail -> nil 을 반환해주는 것
-문법구조-
 init?(parameters) {
    initialization
 }
 init!(parameters) {
    initialization
 }
*/


struct Position {
   let x: Double
   let y: Double
    
    init?(x: Double, y: Double) {
        guard x >= 0.0, y >= 0.0 else { return nil }
    
        self.x = x
        self.y = y
    }
    
    init!(value: Double) {
        guard value >= 0.0 else { return nil }
        
        self.x = value
        self.y = value

    }
    
//    init(value: Int) {
//        self.x = value
//        self.y = value
//    }
}

var a = Position(x: 12, y: 34)  // Position

a = Position(x: -12, y: 0)      // nil <- 음수이기때문에 nil 반환

var b = Position(value: 12)     // Position

b = Position(value: -12)        // nil

```
<br>

* Deinitializer
```
/* Deinitializer : 소멸자. 인스턴스가 메모리에서 제거되기 전에 부가적인 정리 작업을 위해 사용한다.
 클래스에서만 사용가능하다. 한개만 생성 가능하고 자동 호출된다.
 -문법구조-
 deinit {
    Deinitialization
 }
 */

class Size {
   var width = 0.0
   var height = 0.0
}

class Position {
   var x = 0.0
   var y = 0.0
}

class Rect {
   var origin = Position()
   var size = Size()
    
    deinit {
        print("deinit \(self)")
    }
}

var r: Rect? = Rect()
r = nil

```
<br>


# Extension

* Extension - Syntax
```
/*
 형식을 확장하는데 사용. 속성, 메소드, 생성자와 같은 맴버들을 형식에 추가하는 것
 사용 범위 -> Class, Structure, Enumeration, Protocol
 형식 선언을 수정할 수 없는 코드여도 문제없이 확장 가능하다.
 extension 을 통해 기존 자료형에 새로운 맴버를 추가하는 것이 가능해진다. 맴버 추가는 가능하지만 기존의 맴버를
 오버라이딩 하는 방법은 불가능. (오버라이딩이 필요하다면 상속을 통해 구현)
 
 extension Type {
    computedProperty
    computedTypeProperty
    instanceMethod
    typeMethod
    initializer
    subscript
    NestedType
 }
 
 */

struct Size {
    var width = 0.0
    var height = 0.0
}

extension Size {    //  <- 확장할 형식의 이름을 작성한다.
    var area: Double {
        return width * height // <- 기존 형식에 접근하는 것이 가능하다.
    }
}

let s = Size()
s.width     // 0
s.height    // 0
s.area      // 0

extension Size: Equatable {     // Size 구조체가 Equatable 을 채용한다는 의미.
    public static func == (lhs: Size, rhs: Size) -> Bool{
        return lhs.width == rhs.width && lhs.height == rhs.height // Size 인스턴스를 비교연산자로 비교할 수 있게 된다.
    }
}

```
<br>

* Adding Properties
```
/*
 extension 으로 추가할 수 있는 속성은? -> 계산 속성으로 제한된다.
 저장 속성, property observer 를 추가하는 것은 불가능 & 형식에 존재하는 속성을 오버라이딩 하는 것 불가능
 */

extension Date {
    var year: Int {
        let cal = Calendar.current
        return cal.component(.year, from: self)
    }
}

let today = Date()  //  "Aug 4, 2020 at 9:19 AM"
today.year  //  2020
// today.month <- month 맴버가 없기때문에 에러가 난다

extension Double {
    var radianValue: Double {
        return (Double.pi * self) / 180.0
    }
    
    var degreeValue: Double {
        return self * 180.0 / Double.pi
    }
}

let dv = 45.0
dv.radianValue  //  0.7853981633974483

```
<br>

* Adding Methods
```
extension Double {
    func toFahrenheit() -> Double {     // 인스턴스 메소드
        return self * 9 / 5 + 32
    }
    
    func toCelsius() -> Double {        // 인스턴스 메소드
        return (self - 32) * 5 / 9
    }
    
    static func convertToFahrenheit(from celsius: Double) -> Double {   // 타입 메소드
        return celsius.toFahrenheit()
    }
    
    static func convertToCelsius(from fahrenheit: Double) -> Double {
        return fahrenheit.toCelsius()
    }
}

let c = 30.0
c.toFahrenheit()    //  86, 화씨 온도로 변환한 값
Double.convertToFahrenheit(from: 30.0)  // 86, 타입 메소드를 사용한 방법

extension Date {
    func toString(format: String = "yyyyMMdd") -> String {
        let privateFormatter = DateFormatter()
        privateFormatter.dateFormat = format
        return privateFormatter.string(from: self)
    }
}

let today = Date()  // "Aug 4, 2020 at 9:33 AM"
today.toString()    // "20200804"

// 날짜 포멧을 직접 argument 로 전달
today.toString(format: "MM/dd/yyyy")    // "08/04/2020"


extension String {
    static func random(length: Int, charactersIn chars: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") -> String {
        var randomString = String()
        randomString.reserveCapacity(length)
        
        for _ in 0 ..< length {
            guard let char = chars.randomElement() else {
                continue
            }
            randomString.append(char)
        }
        return randomString
    }
}

String.random(length: 5)    //  "gvLmM"
```
<br>

* Adding Initializers
```
/*
 extension 으로 생성자 추가
 */

extension Date {
    init?(year: Int, month: Int, day: Int) {
        let cal = Calendar.current
        var comp = DateComponents()
        comp.year = year
        comp.month = month
        comp.day = day
        
        guard let date = cal.date(from: comp) else {
            return nil
        }
        
        self = date // 날짜가 정상적으로 저장되었다면 self에 저장. date 는 구조체로 구현되었기 때문에 self 에 새로운 인스턴스를 할당하는 방식으로 초기화 할 수 있다.
    }
}

Date(year: 2014, month: 4, day: 16)


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1.0)
    }
}

UIColor(red: 0, green: 0, blue: 255)


struct Size {
    var width = 0.0
    var height = 0.0

}

extension Size {
    init(value: Double) {
        width = value
        height = value
    }
}

Size()  // <- 기본으로 제공되는 생성자를 사용
Size(width: 12, height: 34) // <- extension을 통해 생성된 생성자도 사용 가능
```
<br>

* Adding Subscripts
```
extension String {
    subscript(idx: Int) -> String? {
        guard(0..<count).contains(idx) else {
            return nil
        }
        let target = index(startIndex, offsetBy: idx)
        return String(self[target])
    }
}

let str = "Swift"
str[1]      //  "w"
str[100]    //  nil


extension Date {
    subscript(component: Calendar.Component) -> Int? {
        let cal = Calendar.current
        return cal.component(component, from: self)
    }
}

let today = Date()
today[.year]    // 2020
today[.month]   // 8
today[.day]     // 4

```
<br>


# Protocol

* Protocol Syntax
```
/*
 Protocol : 형식에서 공통으로 제공하는 맴버 목록
 
 protocol ProtocolName {
    propertyRequirement
    methodRequirement
    initializerRequirement
    subscriptRequirements
 }
 
 protocol ProtocolName: Protocol, ... {
 
 }
 
 - Adopting Protocols
 
 enum TypeName: ProtocolName, ... {
 
 }
 
 struct TypeName: ProtocolName, ... {
 
 }
 
 class TypeName: SuperClass, ProtocolName, ... {
 
 }
 
 */

 protocol Something {
    func doSomething()
}

struct Size: Something {    // 컴파일러는 Size 구조체가 Something 프로토콜에 선언되어 있는 요구사항을 만족시킨다고 생각
    func doSomething() {
    }
}

/*
 Class-only Protocols
 
 protocol ProtocolName: AnyObject {
 
 }
 */

protocol SomethingObject: AnyObject, Something {   // <- 클래스 전용 프로토콜
    
}

//struct Value: SomethingObject {   <- 클래스 타입이 아니기에 채용할 수 없다.
//
//}

class Object: SomethingObject {
    func doSomething() {
        
    }
}

```
<br>

* Property Requirements
```
/*
 -선언문법-
 
 protocol ProtocolName {
    var name: Type {get set} <- protocol 내부에선 항상 var 키워드 사용
    static var name: Type {get set} <- get : 읽기전용 / set : 쓰기전용
 }
 
 */

protocol Figure {
    static var name: String { get set }
}

struct Rectangle: Figure {
    static var name = "Rect"
}

struct Triangle: Figure {
    static var name = "Triangle"
}

class Circle: Figure {
    class var name: String {
        get {
            return "Circle"
        }
        set {
            
        }
    }
}
```
<br>

* Method Requirements
```
/*
 -선언문법-
 protocol ProtocolName {
    func name(param) -> ReturnType
    static func name(param) -> ReturnType
    mutating func name(param) -> ReturnType
 }
 */

//protocol Resettable {
//    func reset()
//}

// class 구현
//class Size: Resettable {
//    var width = 0.0
//    var height = 0.0
//
//    func reset() {      // <- 프로토콜에 선언되어 있는 메소드 이름, 파라미터 형식, 리턴형이 모두 동일하면 메소드 바디안에 어떤 것이 들어가던 상관없다.
//        width = 0.0
//        height = 0.0
//    }
//}

protocol Resettable {
    mutating func reset()   // <- mutating 은 값 형식에서만 사용하는 키워드
}

// struct 구현
struct Size: Resettable {
    var width = 0.0
    var height = 0.0
    
    mutating func reset() {      // <- 프로토콜에 선언되어 있는 메소드 이름, 파라미터 형식, 리턴형이 모두 동일하면 메소드 바디안에 어떤 것이 들어가던 상관없다.
        width = 0.0
        height = 0.0
    }
}
```
<br>

* Initializer Requirements
```
/*
 -선언문법-
 protocol ProtocolName {
    init(param)
    init?(param)
    init!(param)
 }
 */

/* case1.
protocol Figure {
    var name: String {get}
    init(name: String)
}

struct Rectangle: Figure {
    var name: String    // <- 맴버와이즈 이니셜라이즈 자동으로 생성된다
}
*/

/* case2.
protocol Figure {
    var name: String {get}
    init(n: String)
}

struct Rectangle: Figure {
    var name: String
    init(n: Stirng){    // <- 맴버와이즈 이니셜라이즈가 자동으로 생성되지않기 때문에 이런식으로 만들어준다.
        name = n
    }
 }
*/

protocol Figure {
    var name: String { get }
    init(n: String)
}

class Circle: Figure {
    var name: String
    required init(n: String){
        name = n
    }
 }

final class Triangle: Figure {  // <- final 클래스는 더 이상 상속되지않기 때문에 상속을 고려할 필요가 없다. 그래서 required 키워드가 없어도 괜찮다.
    var name: String
    init(n: String){
           name = n
    }
}

class Oval: Circle {    //  <- Oval 클래스는 Circle 클래스의 맴버와 프로토콜 요구사항을 모두 상속한다.
    var prop: Int
    init() {
        prop = 0
        super.init(n: "Oval")
    }
    
    required convenience init(n: String) {
        self.init()
    }
    
}

protocol Grayscale {
    init?(white: Double)
    
}

struct Color: Grayscale {
    init!(white: Double){
        
    }
}
```
<br>

* Subscript Requirements
```
/*
 -문법구현-
 protocol ProtocolName {
    subscript(param) -> ReturnType { get set }
 }
 */

protocol List {
    subscript(idx: Int) -> Int { get }  // get 키워드만 필수, set 키워드는 상황에 따라 생략 가능하다
}

struct DataStore: List {
    subscript(idx: Int) -> Int {
        get {
            return 0
        }
        set {
        
        }
    }
}
```
<br>

# Memory, Value Type and Reference Type

* Memory Basics
```
```
<br>

* Value Type vs Reference Type
```
// 1. 값 형식 -> 항상 스택에 저장됨, 값을 전달할 때 마다 새로운 복사본이 생성된다.
struct SizeValue {
   var width = 0.0
   var height = 0.0
}

var value = SizeValue()


var value2 = value
value2.width = 1.0
value2.height = 2.0

value   // width 0 height 0
value2  // width 1 height 2


// 2. 참조형식 -> 힙에는 인스턴스가 저장됨, 스택에는 힙 메모리 주소가 저장. 항상 스택을 거쳐 접근해야한다. 항상 스택에 있는 주소를 통해 접근
class SizeObject {
   var width = 0.0
   var height = 0.0
}

var object = SizeObject()

var object2 = object    // 스택에 새로운 메모리 공간이 생성됨. 힙에서는 새로운 메모리 공간이 생성. 인스턴스가 복사되진 않는다.

object2.width = 1.0
object2.height = 2.0

// 모든 인스턴스에 동일한 값이 저장된다 (힙에 인스턴스를 저장하고 스택에 메모리 주소를 저장)
object  // width 1 height 2
object2 // width 1 height 2


// 값
let v = SizeValue()     // 값 자체를 변경하는 것은 불가능하다


// 참조
let o = SizeObject()    // 인스턴스가 저장되어 있는 힙은 변경 가능하다. let 을 통해 스택에 저장되어 있는 주소만 바꿀 수 없도록 고정시켜 놓은 것
o.width = 1.0
o.height = 2.0
```
<br>

* ARC(Automatic Reference Counting)
```
/*
스택에 저장된 것들은 자동으로 제거가 되기때문에 관리할 필요가 없다. 하지만 힙에 저장된 것들은 필요없는 시점에 직접 제거해야한다.
메모리 관리 모델은 힙에 저장되는 데이터를 관리한다. -> 클래스 인스턴스의 메모리를 관리한다.
Reference Count -> 1이상 : 메모리에 유지 / 0: 메모리에서 제거
*/

class Person {
   var name = "John Doe"
   
   deinit {
      print("person deinit")
   }
}

var person1: Person?
var person2: Person?
var person3: Person?

person1 = Person()
person2 = person1
person3 = person1

// nil을 저장하는건 소유권을 포기하는 것. 즉시 참조 count 에서 -2 를 하게 된다.
person1 = nil
person2 = nil
```
<br>

* Strong Reference Cycle
```
// Strong Reference Cycle : nil을 통해 메모리에서 해제했지만 여전히 메모리에서 제거되지 않는 문제
class Person {
   var name = "John Doe"
   var car: Car?
   
   deinit {
      print("person deinit")
   }
}

class Car {
   var model: String
   var lessee: Person?
   
   init(model: String) {
      self.model = model
   }
   
   deinit {
      print("car deinit")
   }
}

var person: Person? = Person()
var rentedCar: Car? = Car(model: "Porsche")

person?.car = rentedCar
rentedCar?.lessee = person

person = nil
rentedCar = nil

// Weak Reference -> weak var name: Type?

class Person {
   var name = "John Doe"
   var car: Car?
   
   deinit {
      print("person deinit")
   }
}

class Car {
   var model: String
   weak var lessee: Person? // 참조는 하지만 소유하진 않는다
   
   init(model: String) {
      self.model = model
   }
   
   deinit {
      print("car deinit")
   }
}

var person: Person? = Person()
var rentedCar: Car? = Car(model: "Porsche")

person?.car = rentedCar
rentedCar?.lessee = person

person = nil
rentedCar = nil

// Unowned Reference
class Person {
   var name = "John Doe"
   var car: Car?

   deinit {
      print("person deinit")
   }
}

class Car {
   var model: String
   unowned var lessee: Person

   init(model: String, lessee: Person) {
      self.model = model
      self.lessee = lessee
   }

   deinit {
      print("car deinit")
   }
}

var person: Person? = Person()
var rentedCar: Car? = Car(model: "Porsche", lessee: person!)

person?.car = rentedCar

person = nil
rentedCar = nil

```
<br>

* Closure Capture List
```
class Car {
   var totalDrivingDistance = 0.0
   var totalUsedGas = 0.0
   
   lazy var gasMileage: () -> Double = { [weak self] in
    guard let strongSelf = self else { return 0.0 }
      return strongSelf.totalDrivingDistance / strongSelf.totalUsedGas
   }
   
   func drive() {
      self.totalDrivingDistance = 1200.0
      self.totalUsedGas = 73.0
   }
   
   deinit {
      print("car deinit")
   }
}

var myCar: Car? = Car()
myCar?.drive()

myCar?.gasMileage()

myCar = nil

/*
 Value Type 문법 구조
 { [valueName] in
   Code
 }
 */
var a = 0
var b = 0
let c = { [a] in print(a,b) }

a = 1
b = 2
c() // 0 2 <- a의 값은 캡쳐 시점에 저장된 값을 출력. 참조대신 복사본을 캡쳐

/*
Reference Type 문법 구조
{ [weak instanceName, unowned instanceName] in
  statements
}
*/
```
<br>

# Generics

* Generic Function
```
/* Generics : 형식에 의존하지 않는 범용코드를 작성할 수 있음. 코드의 재사용과 유지보수의 편의성이 높아진다는 장점이 있음
 
 */

func swapInteger(lhs: inout Int, rhs: inout Int) {
   let tmp = lhs
   lhs = rhs
   rhs = tmp
}

var a = 10
var b = 20

swapInteger(lhs: &a, rhs: &b)
a
b


func swapInteger16(lhs: inout Int16, rhs: inout Int16) {
   // ...
}

func swapInteger64(lhs: inout Int64, rhs: inout Int64) {
   // ...
}

func swapDouble(lhs: inout Double, rhs: inout Double) {
   // ...
}

/*
 -문법구조-
 func name<T>(parameters) -> Type {
    code
 }
 
 <T> 가 의미하는 것은 Type parameter. 함수 내부에서 파라미터 형식이나 리턴형으로 사용된다.
 */

// 형식에 관계없이 모든 값을 파라미터로 전달할 수 있다는 장점이 있다.
func swapValue<T>(lhs: inout T, rhs: inout T) {
   let tmp = lhs
   lhs = rhs
   rhs = tmp
}

a = 1
b = 2
swapValue(lhs: &a, rhs: &b)
a   // 2
b   // 1

var c = 1.2
var d = 3.4
swapValue(lhs: &c, rhs: &d)
c   // 3.4
d   // 1.2

/*
 
 Type Constraints : 형식 제약
 -문법구조-
 <TypeParameter: ClassName>
 <TypeParameter: ProtocolName>
 
 */

func swapValue<T: Equatable>(lhs: inout T, rhs: inout T) {
    if lhs == rhs { return }
    
    let tmp = lhs
    lhs = rhs
    rhs = tmp
}

func swapValue<T: Equatable>(lhs: inout T, rhs: inout T) {
   print("generic version")
   
   if lhs == rhs {
      return
   }
   
   let tmp = lhs
   lhs = rhs
   rhs = tmp
}

func swapValue(lhs: inout String, rhs: inout String) {
    print("specialized version")
    
    if lhs.caseInsensitiveCompare(rhs) == .orderedSame {
        return
    }
    
    let tmp = lhs
    lhs = rhs
    rhs = tmp
}

var a = 1
var b = 2
swapValue(lhs: &a, rhs: &b)     // generic version

var c = "Swift"
var d = "Programming"
swapValue(lhs: &c, rhs: &d)     // specialized version

```
<br>

* Generic Types
```
/*
 Generic Types -문법구조-
 
 class Name<T> {
    code
 }
 struct Name<T> {
    code
 }
 enum Name<T>{
    code
 }
 
 */

struct Color<T> {
    var red: T
    var green: T
    var blue: T
}

var c = Color(red: 128, green: 80, blue: 200) // // Type Parameter 를 추론함

let d: Color = Color(red: 128.0, green: 80.0, blue: 200.0) // Type Parameter 를 추론함

/*
Type Parameter를 보고 예전에 배운 것들을 생각해보면 이런 것들이 있다.
 
let arr: Array<Int>
let dict: Dictionary<String, Double>
 */

extension Color {   // Color<T> <- 이렇게 사용하는 것 불가능
    func getComponents() -> [T] {
        return [red, green, blue]
    }
}

let intColor = Color(red: 1, green: 2, blue: 3)
intColor.getComponents() // <- Type Parameter 가 Int 형식이라는 것을 추론함
// 만약 Int 형식인 것만 허용하려면 extension 구현 부분에서
// extension Color where T == Int 로 고쳐주면 된다

let dblColor = Color(red: 1.0, green: 2.0, blue: 3.0)
dblColor.getComponents() // Double 형식이라는 것을 추론함
```
<br>

* Associated Types
```
/*
 Associated Types 문법구조
 associatedtype Name <- 기존에 함수 이름 뒤에 <T> 를 붙이는 방법 대신에 사용하는 것
 */

protocol QueueCompatible {
    associatedtype Element
    func enqueue(value: Element)
    func dequeue() -> Element?
}

class IntegerQueue: QueueCompatible {
    typealias Element = Int
    
    func enqueue(value: Int) {
        
    }
    func dequeue() -> Int? {
        return 0
    }
}

class DoubleQueue: QueueCompatible {
    func enqueue(value: Double) {
        
    }
    func dequeue() -> Double? {
        return 0
    }
}
```
<br>

# Error Handling

* Error Handling
```
/*
 Error Handling
 1. 함수 (Throwing Function / Method)
 func name(parameters) throws -> ReturnType {
    statesments
 }
 
 2. 생성자 ( Throwing Initializer)
 init(parameters) throws {
    statesments
 }
 
 3. 클로저 (Throwing Closure)
 { (parameters) throws -> ReturnType in
    statesments
 }
*/



enum DataParsingError: Error {
    case invalidType
    case invailidField
    case missingRequiredField(String)
}

// throw문은 에러가 발생된 경우에만 호출된다
func parsing(data: [String: Any]) throws {
    guard let _ = data["name"] else {
        throw
            DataParsingError.missingRequiredField("name")
    }
    
    guard let _ = data["age"] as? Int else {
        throw DataParsingError.invalidType
    }
}

/*
 try Statements
 
 try expression
 try? expression
 try! expression
 
 에러를 처리하는 방법
 1. do-catch Statements
 2. try Expression + Optional Binding
 3. hand over
 */

try? parsing(data: [:])
```
<br>

* do-catch Statements
```
/*
 do-catch 문법구조
 do {
    try expression
    statesments
 } catch pattern {
    statements
 } catch pattern where condition {
    statements
 }
 */
enum DataParsingError: Error {
   case invalidType
   case invalidField
   case missingRequiredField(String)
}

func parsing(data: [String: Any]) throws {
   guard let _ = data["name"] else {
      throw DataParsingError.missingRequiredField("name")
   }
   
   guard let _ = data["age"] as? Int else {
      throw DataParsingError.invalidType
   }
   
   // Parsing
}
func handleError() throws {
    do {
        try parsing(data: ["name":""])
    } catch {
        if let error = error as? DataParsingError {
            switch error {
            case .invalidType:
                print("invalid type")
            default:
                print("handle error")
            }
        }
    }
}
```
<br>

* Optional Try
```
```
<br>

* defer Statements
```
```
<br>

* Result Type #1
```
```
<br>

* Result Type #2
```
```
<br>

# Advanced Topics

* Advanced Condition
```
```
<br>
