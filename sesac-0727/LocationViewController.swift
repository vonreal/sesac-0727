//
//  LocationViewController.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/07/29.
//

import UIKit

class LocationViewController: UIViewController {

    // Notification - 1. Local Notification을 담당하는 객체 생성
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func noticationButtonClicked(_ sender: UIButton) {
        requestAuthorization()
    }
    
    // Notification - 2. 권한 요청
    func requestAuthorization() {
        
        let authorizationOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        notificationCenter.requestAuthorization(options: authorizationOptions) { success, error in
            if success {
                self.sendNotification()
            }
        }
    }
    
    // Notification - 3. 권한 허용한 사용자에게 알림 요청(언제, 어떤 콘텐츠를 보낼것인가가 들어가야함)
    // iOS 시스템에서 알림을 담당 > 알림을 등록하는 코드가 필요
    
    
    /*
     1. 뱃지 제거? > 언제 제거하는게 맞을까?
     2. 노티 제거? > 노티의 유효 기간은? > 카톡(오픈채팅, 단톡)
     3. 포그라운드 수신? > 
     */
    
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "다마고치를 키워보세요"
        notificationContent.subtitle = "오늘 행운의 숫자는 \(Int.random(in: 1...100))입니다."
        notificationContent.body = "저는 따끔따끔 다마고치입니다. 배고파요."
        notificationContent.badge = 40
        
        // 언제 보낼 것인가? 1. 시간 간격 2. 캘린더 3. 위치에 따라 설정 가능
        // 시간 간격은 60초 이상 설정해야 반복 가능
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        
//        var dateComponents = DateComponents()
//        dateComponents.minute = 15
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // content와 trigger을 담아 알림을 요청
        // identifier: 여러개를 다르게 관리할 것인지 아니면 하나만 관리할 것인지
        // 여러개를 보내고 싶으면 identifier가 다 달라야 함. -> 타임스탬프 사용할수도
        // 만약 알림 관리 할 필요 x -> 알림 클릭하면 앱을 켜주는 정도.
        // 만약 알림 관리 할 필요 o -> +1, 고유 이름, 규칙 등
        let request = UNNotificationRequest(identifier: "wka", content: notificationContent, trigger: trigger)
        
        notificationCenter.add(request)
    }
}
