//
//  ReusableViewProtocol.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/08/01.
//

import Foundation
import UIKit

protocol ReusableViewProtocol {
    static var reuseIdentifier: String { get }
}

// 확장은 메모리 공간을 차지하는 저장 프로퍼티를 사용하지 못한다.
extension UIViewController: ReusableViewProtocol {
    static var reuseIdentifier: String { // 연산 프로퍼티 get만 사용한다면 get 생략 가능
            return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
            return String(describing: self)
    }
}
