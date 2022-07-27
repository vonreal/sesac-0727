import Darwin
import Foundation

struct User {
    static var originalName = "진짜이름"
    var nickname = "고래밥"
}

var user1 = User()
user1.nickname = "올라프"
User.originalName = "리JACK"
print(user1.nickname, User.originalName)

var user2 = User()
print(user2.nickname, User.originalName)

var user3 = User()
print(user3.nickname, User.originalName)

var user4 = User()
print(user4.nickname, User.originalName)


struct BMI {
    var nickname: String
    var weight: Double
    var height: Double
    
    var BMIResult: String {
        get {
            let bmiValue = (weight * height) / height
            let bmiStatus = bmiValue < 18.5 ? "저체중" : "정상 이상"
            return "\(nickname)님의 BMI 지수는 \(bmiValue)로 \(bmiStatus)입니다!"
        }
    }
}

let bmi = BMI(nickname: "고래밥", weight: 56, height: 168)

let result = bmi.BMIResult

print(result)


class FoodRestaurant {
    let name = "잭치킨"
    var totalOrderCount = 10
    
    var nowOrder: Int {
        get {
            return totalOrderCount * 5000
        }
        
        set {
            totalOrderCount += newValue
        }
    }
}

let food = FoodRestaurant()

food.nowOrder = 5
print(food.nowOrder)

food.nowOrder = 20
print(food.nowOrder)

food.nowOrder = 100
print(food.nowOrder)

// 열거형은 타입 자체 > 인스턴스 생성이 불가능하다 > 초기화 구문 X
// 인스턴스 생성을 통해서 접근할 수 있는 인스턴스 저장 프로퍼티 사용 불가!
// 메모리의 관점 + 열거형이 컴파일 타임에 확정되어야 한다! > 인스턴스 연산 프로퍼티는 열거형에서 사용할 수 있다.
// 타입 저장 프로퍼티 => 열거형에서 사용 가능!
enum ViewType {
    case start
    case change
    
    var nickname: String {
        return "aa"
    }
    
    static var title = "시작하기"
} // 열거형은 인스턴스 생성이 불가능하다.

ViewType.title


class TypeFoodRestaurant {
    static let name = "잭치킨" // 타입 상수 저장 프로퍼티
    static var totalOrderCount = 10 {// 총 주문건수
        willSet {
            print("나 변경된다??! 변경할거다?!! \(newValue)로 변경한다!!")
        }
        didSet {
            print("나 이미 변경됨 ㅋㅋ  이전값 \(oldValue)임 ㅅㄱ ")
        }
    }
    static var nowOrder: Int {
        get {
            return totalOrderCount * 5000
        }
        
        set {
            totalOrderCount += newValue // 기본 파라미터 newValue, 변경 가능!
        }
    }
}

TypeFoodRestaurant.nowOrder // 타입 연산 프로퍼티 Get
TypeFoodRestaurant.nowOrder = 15 // 타입 연산 프로퍼티 Set
TypeFoodRestaurant.nowOrder

TypeFoodRestaurant.nowOrder

// Property Observer: 저장 프로퍼티에서 주로 사용되고, 저장 프로퍼티 값을 관찰을 하다가 변경이 될 것 같을 때 또는 변경이 되었을 때 호출됨!


// 메서드: 타입 메서드 & 인스턴스 메서드

class Coffee {
    static var name = "아메리카노"
    static var shot = 2
    var pirce = 4900
    
    static func plusShot() {
        shot += 1
        // price += 300 // static 함수에서는 인스턴스에 접근이 안된다.
    }
    
    static func minusShot() {
        shot -= 1
    }
}

class Latte: Coffee {
    override class func plusShot() {
        
    }
}
