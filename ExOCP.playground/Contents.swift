import Foundation

/* OCP 를 적절하게 사용한 예제 */
protocol AnimalCare {
    func feed()
    func checkHealth()
}

// 동물 구조체 설계
struct LionCare: AnimalCare {
    func feed() { print("고기 먹이기") }
    func checkHealth() { }
}

struct ElephantCare: AnimalCare {
    func feed() { print("풀 먹이기") }
    func checkHealth() { }
}

struct MonkeyCare: AnimalCare {
    func feed() { print("바나나 먹이기") }
    func checkHealth() { }
}

class Animal {
    let name: String
    let careStrategy: AnimalCare
    
    init(name: String, careStrategy: AnimalCare) {
        self.name = name
        self.careStrategy = careStrategy
    }
    
    func performDailyRoutine() {
        careStrategy.feed()
        careStrategy.checkHealth()
    }
}

let lion = Animal(name: "Line", careStrategy: LionCare())
let elephant = Animal(name: "Elephant", careStrategy: ElephantCare())
let monkey = Animal(name: "Monkey", careStrategy: MonkeyCare())


/* OCP 지키지 않았을때 생기는 문제 */
class Animal {
    let name: String
    let type: String

    init(name: String, type: String) {
        self.name = name
        self.type = type
    }

    func performDailyRoutine() {
        switch type {
        case "Lion":
            feedLion()
            checkHealthOfLion()
        case "Elephant":
            feedElephant()
            checkHealthOfElephant()
        // 새로운 동물 종류를 추가할 때마다 이 부분을 수정해야 함
        default:
            print("Unknown animal type")
        }
    }

    private func feedLion() {
        print("Feeding the lion with meat.")
    }

    private func checkHealthOfLion() {
        print("Performing health check for the lion.")
    }

    private func feedElephant() {
        print("Feeding the elephant with fruits and vegetables.")
    }

    private func checkHealthOfElephant() {
        print("Performing health check for the elephant.")
    }
}

