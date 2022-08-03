//
//  LottoViewController.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController{

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet var lottoNumberLabels: [UILabel]!
//    @IBOutlet weak var lottoPickerView: UIPickerView!
    
    // 코드로 뷰를 만드는 기능이 훨씬 더 많이 남아있슴!
    var lottoPickerView = UIPickerView()
    
    let numberList: [Int] = Array(1...1025).reversed()
    var date: String?
    var currentHwe = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 텍스트 필드 클릭 시 pickerView 팝업
        numberTextField.tintColor = .clear
        numberTextField.inputView = lottoPickerView
        
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        
        
        // 1. 오늘날짜 받아오기
        requestLotto(number: currentHwe, flag: true)
    }
    

    func getCurrentDate() {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        
        if let dd = date {
            if let recentDate = format.date(from: dd) {
                let calender = Calendar.current
                
                let date1 = calender.startOfDay(for: Date.now)
                let date2 = calender.startOfDay(for: recentDate)
                
                let compo = calender.dateComponents([.day], from: date2, to:date1)
                
                if let difDay = compo.day {
                    var week = 0
                    if difDay < 0 {
                        week = (difDay / 7) * -1
                    } else {
                        week = difDay / 7
                    }
                    requestLotto(number: currentHwe + week, flag: false)
                }
            }
        }
    }
    
    
    func requestLotto(number: Int, flag: Bool){
        print("회차: \(number)")
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        // Alamofire -> AF로 접두어 변경
        // Default AF: 200 ~ 299 status code를 success
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                self.date = json["drwNoDate"].string
                self.numberTextField.text = self.date
                
                var index = 1
                for label in self.lottoNumberLabels {
                    label.text = "\(json["drwtNo\(index)"].intValue)"
                    if index == 7 {
                        label.text =  "\(json["bnusNo"].intValue)"
                    }
                    index += 1
                }
                
                if flag {
                    self.getCurrentDate()
                }
                break
                    
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // .count로 접근하는 것보다 0번째의 값에 접근하는게 더 빠르다고 판단했다.
        return numberList[0]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        requestLotto(number: numberList[row], flag: false)
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
}
