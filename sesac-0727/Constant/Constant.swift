//
//  Constant.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/08/01.
//

import Foundation

struct APIKey {
    static let BOXOFFICE = "a3a9c300b11ca832e223a122b8ed15b0"
    
    static let NAVER_ID = "WxcthuiNXMQ2va3HfZp3"
    static let NAVER_PW = "llPAg2oQwJ"
}

struct EndPoint {
    static let boxOfficeURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    static let translateURL = "https://openapi.naver.com/v1/papago/n2mt"
}

// after - 1
//enum StoryboardName {
//    case Main
//    case Search
//    case Setting
//}
//// 사용시 StoryboardName.Main

// after - 2
//struct StoryboardName {
//    static let main = "Main"
//    static let search = "Search"
//    static let setting = "Setting"
//}

// after - 3
/*
 1. strcut type property vs enum type property
    -> 구조체는 인스턴스를 생성할 수 있는 여지가 있기 때문에 메모리를 사용하게 된다. 열거형으로 했을 경우에는 인스턴스 생성 방지가 가능하다.
 2. enum case vs enum static
    -> 이 둘의 차이가 무엇인가?
    -> 값의 중복의 유무, 원시값의 타입에 대한 제약
 */
enum StoryboardName { // 열거형은 인스턴스 생성이 불가능하기 때문에 저장속성은 생성이 불가능하나, 타입 속성은 생성이 가능하다.
    static var main = "Main"
    static let search = "Search"
    static let setting = "Setting"
}

// 위와 동일하나 struct의 인스턴스 생성을 방지하는 법
//struct StoryboardName {
//
//    private init() {}
//
//    static let main = "Main"
//    static let search = "Search"
//    static let setting = "Setting"
//}


//// 나의 실험
////enum UserDefaultValue {
//    static var nickname: String {
//        get {
//            return UserDefaults.standard.string(forKey: "nickname")
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: "nickname")
//        }
//
//    }
////}
//
//
//enum FontName: String {
//    case title =
//}
