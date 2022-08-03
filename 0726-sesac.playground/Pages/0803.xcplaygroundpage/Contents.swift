
// MARK: - [일급 객체]

// 스위프트 특징: 1) 객체지향 2) 함수형(일급객체의 특성을 지님) 3) 프로토콜

/*
 [일급 객체의 특징]
     1. 변수나 상수에 할당 가능
     2. 파라미터로 사용 가능
     3. 반환 값으로 사용 가능
 */

func checkBankInformation(bank: String) -> Bool {
    let bankArray = ["우리", "신한", "국민"]
    return bankArray.contains(bank) ? true : false
}

let checkResult = checkBankInformation(bank: "우리") // (1급 객체의 특성은 아님)


// MARK: - <일급 객체의 특성 - 1: 변수나 상수에 할당 가능>
// 단지 함수만 대입, 타입이 함수형태이다.
// let checkAccount: (String) -> Bool
let checkAccount = checkBankInformation

// 호출을 해주어야 실행
checkAccount("카카오뱅크")

// Swift3 부터 괄호 명시!
// Function Type: (String) -> String
func hello(username: String) -> String {
    return "저는 \(username)입니다."
}

// Function Type: (String, Int) -> String
func hello(nickname: String, age: Int) -> String {
    return "저는 \(nickname), \(age)살 입니다."
}


// [에러발생: Ambiguos]: 오버로딩 특성으로 함수를 구분하기 힘들다.
//let result = hello

// [해결]: 타입 어노테이션 명시
//let result: (String) -> String = hello
let ageResult: (String, Int) -> String = hello

ageResult("고래밥", 30)


// 또 새로운 파라미터로 만들었지만 타입이 중복되기 때문에 에러가 발생하게 된다.
// 타입 어노테이션만으로 함수를 구별할 수 없는 상황도 존재
// [해결]: 함수 표기법을 사용한다면 함수를 구별 가능하다.
let result = hello(username:)

func hello(nickname: String) -> String {
    return "저는 \(nickname)입니다람쥐보스."
}

let result2 = hello(nickname:)

print(result("고래밥"))
print(result2("몬스터"))



// MARK: - <일급 객체의 특성 - 2: 파라미터로 사용 가능>
func oddNumber() {
    print("홀수")
}

func evenNumber() {
    print("짝수")
}

func resultNumber(number: Int, odd: ()->(), even: ()->()) {
    return number.isMultiple(of: 2) ? even() : odd()
}

resultNumber(number: 9, odd: oddNumber, even: evenNumber)

// 클로저
resultNumber(number: 10) {
    print("odd 데스")
} even: {
    print("even 데스")
}

