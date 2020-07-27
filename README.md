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

# String and Character
