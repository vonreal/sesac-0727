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
    
    @IBOutlet weak var exTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 커스텀 폰트 -> 폰트 네임 확인
//        for family in UIFont.familyNames {
//            print("======\(family)=======")
//            for font in UIFont.fontNames(forFamilyName: family) {
//                print(font)
//            }
//        }
        exTextView.font = UIFont(name: "S-CoreDream-3Light", size: 14)
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
     - 권한 허용 해야만 알림이 온다.
     - 권한 허용 문구 시스템적으로 최초 한 번만 뜬다.
     - 허용 안 된 경우 애플 설정으로 직접 유도하는 코드를 구성해야 한다.
     
     - 기본적으로 알림은 포그라운드에서 수신되지 않는다.
     - 로컬 알림에서 60초 이상 반복 가능 / 갯수 제한 64개 / 커스텀 사운드 30초
     
     
     1. 뱃지 제거? > 언제 제거하는게 맞을까?
     2. 노티 제거? > 노티의 유효 기간은? > 카톡(오픈채팅, 단톡)
     3. 포그라운드 수신? > 딜리게이트 메서드로 해결!
     
     +a
    - 노티는 앱 실행이 기본인데, 특정 노티를 클릭할 때 특정 화면으로 가고 싶다면?
    - 포그라운드 수신, 특정 화면에서는 안받고 특정 조건에 대해서만 포그라운드 수신을 하고 싶다면?
    - iOS 15 집중모드 등 5~6 우선순위 존재!
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
    
    
    @IBAction func downloadIamge(_ sender: UIButton) {
        let url = "https://apod.nasa.gov/apod/image/2208/M13_final2_sinfirma.jpg"
        
        print("1", Thread.isMainThread) // 일반적으로 모든 코드는 main스레드에서 움직이고 있다(디폴트: 메인 스레드)
        DispatchQueue.global().async { // 동시 여러 작업 가능하게 해줘! (순서대로 실행되는 코드의 규칙을 깨버렸다)
            print("2", Thread.isMainThread)
            let data = try! Data(contentsOf: URL(string: url)!)
            let image = UIImage(data: data)
            
            
            DispatchQueue.main.async {
                print("3", Thread.isMainThread)
                self.imageView.image = image // UIImageView.image must be used from main thread only라는 보라색 경고! (사용자에게 보여지는 건 굉장히 중요한 작업)
            }
        }
        print("4", Thread.isMainThread)
    }
}
