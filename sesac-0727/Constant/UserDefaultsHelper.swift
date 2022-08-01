//
//  UserDefaultsHelper.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/08/01.
//

import Foundation

class UserDefaultHelper {
    
    // 추가 인스턴스 생성 방지
    private init() { }
    
    static let standard = UserDefaultHelper()
    
    let userDefaults = UserDefaults.standard
    
    enum Key: String {
        case nickname, age
    }
    
    var nickname: String {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set {
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
}

