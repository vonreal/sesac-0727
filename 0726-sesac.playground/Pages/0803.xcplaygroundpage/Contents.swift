import CoreFoundation

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

// [[0804]]

// 2-1. Calculate

func plus(a: Int, b: Int) -> Int {
    return a + b
}

func minus(a: Int, b: Int) -> Int {
    return a - b
}

func multiply(a: Int, b: Int) -> Int {
    return a * b
}

func divide(a: Int, b: Int) -> Int {
    return a / b
}

func calculate(operand: String) -> (Int, Int) -> Int {
    switch operand {
    case "+": return plus
    case "-": return minus
    case "*": return multiply
    case "/": return divide
    default: return plus
    }
}

calculate(operand: "+")

let resultCalculate = calculate(operand: "+")
resultCalculate(3, 5)



// MARK: - <일급 객체의 특성 - 3: 파라미터로 사용 가능>

/*
    클로저: 이름 없는 함수
 */

// () -> ()
func studyiOS() {
    print("주말에도 공부하기")
}

let studyiOSHarder: () -> () = {
    print("주말에도 공부하기")
}

// in 기준으로 앞 클로저 헤더
let studyiOSHarder2 = { () -> () in
    print("주말에도 공부하기")
}

studyiOSHarder2()


func getStudyWithMe(study: () -> ()) {
    print("getStudyWithMe")
    study()
}

// 코드를 생략하지 않고 클로저 구문 씀. 함수의 매개변수 내에 클로저가 그대로 들어간 형태
// ==> 인라인(Inline) 클로저
getStudyWithMe(study: { () -> () in
    print("랄라랄라")
})

// 함수 뒤에 클로저가 실행
// ==> 트레일링(후행) 클로저
getStudyWithMe() { () -> () in
    print("랄라랄라")
}

func randomNumber(result: (Int) -> String) {
    result(Int.random(in: 1...1999))
}

// 인라인 클로저
randomNumber(result: { (number: Int) -> String in
    return "행운의 숫자는 \(number)입니다."
})


randomNumber(result: { (number: Int) in
    return "행운의 숫자는 \(number)입니다."
})

randomNumber(result: { (number: Int) in
    "행운의 숫자는 \(number)입니다."
})

// 매개변수가 생략되면 할당되어 있는 내부 상수 $0을 사용할 수 있다. ($0, $1, $2)
randomNumber(result: { "행운의 숫자는 \($0)입니다." })

randomNumber(){ "행운의 숫자는 \($0)입니다." }


// 고차함수: filter map reduce

func processTime(code: () -> () ) {
    let start = CFAbsoluteTimeGetCurrent()
    code()
    let end = CFAbsoluteTimeGetCurrent() - start
    print(end)
}

// ex 4.0 이상 학생 고르기
let student = [2.2, 4.5, 3.2, 4.9]

processTime {
    var newStudent: [Double] = []
    
    for student in student {
        if student >= 4.0 {
            newStudent.append(student)
        }
    }
    
    print("조건쓰: \(newStudent)")
}

processTime {
    let filterStudent = student.filter { $0 >= 4.0 }
    
    print("클로저쓰: \(filterStudent)")
}

let number = [Int](1...100)

processTime {
    var newNumber: [Int] = []
    
    for n in number {
        newNumber.append(n * 3)
    }
}

processTime {
    number.map{ $0 * 3 }
}


let movieList = [
    "A":"ANAME",
    "B":"봉준호",
    "C":"CNAME",
    "D":"봉준호"
]


print(movieList.filter {$0.value == "봉준호"}.map {$0.key})

// reduce: 초기값이 필요.

let examScore: [Double] = [100, 200 ,30 ,40 ,50 , 4]

var totalCount: Double = 0

for score in examScore {
    totalCount += score
}

print(totalCount / 8)

let totalCountUsingReduce = examScore.reduce(120) {$0 + $1}

print(totalCountUsingReduce / 8)


// drawingGame: 외부함수, luckyNumber: 내부함수
func drawingGame(item: Int) -> String {
    func luckyNumber(number: Int) -> String {
        return "\(number * Int.random(in: 1...10))"
    }
    
    let result = luckyNumber(number: item)
    
    return result
}

drawingGame(item: 10) // 외부 함수의 생명 주기가 끝났다. -> 내부 함수의 생명주기도 오와리

// 내부 함수를 반환하는 외부 함수로 만들 수 있다.
func drawingGame2(item: Int) -> () -> String {
    
    func luckyNumber() -> String {
        return "\(item * Int.random(in: 1...10))"
    }
    
    return luckyNumber
}

drawingGame2(item: 10) // 내부 함수는 아직 동작하지 않음

let numberResult = drawingGame2(item: 10) // 내부 함수는 아직 동작하지 않음. 외부 함수 생명주기가 끝났음.
print(numberResult()) // 외부 함수의 생명주기가 끝났는데 내부 함수는 사용이 가능한 상황이 됨.
