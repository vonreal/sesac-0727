//
//  ViewPresentableProtocol.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/07/28.
//

import Foundation
import UIKit

/*
 -----Protocol
 -----Delegate
 */

// 프로토콜은 규약이자 필요한 요소를 명세할 뿐, 실질적인 구현부는 작성하지 않는다!
// 실질적인 구현은 프로토콜을 채택, 준수한 타입이 구현한다!
// 클래스, 구조체, 익스텐션, 열거형
// 클래스는 단일 상속만 가능하지만, 프로토콜은 채택 갯수에 제한이 없습니다!
// @objc optional > 선택적 요청(Optional Requirment)
// 프로토콜 프로퍼티, 프로토콜 메서드

@objc
protocol ViewPrsentableProtocol {
    
    // 만약 get만 명시했다면, get 기능만 최소한으로 구현되어 있어야한다!. 고로 프로토콜에서의 속성은 최소한의 필수 옵션을 나타낸다.
    var navigationTitleString: String { get set }
    var backgroundColor: UIColor { get }
    static var identifier: String { get }
    
    func configureView()
    func configureLabel()
    
    @objc optional func configureLagel()
    @objc optional func happy()
}


/*
 ex. 테이블뷰
 */

@objc
protocol JackTableViewProtocol {
    func numberOfRowInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell
    @objc optional func didSelectRowAt()
}
