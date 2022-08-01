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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 텍스트 필드 클릭 시 pickerView 팝업
        numberTextField.tintColor = .clear
        numberTextField.inputView = lottoPickerView
        
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
    }
    
    func requestLotto(number: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        // Alamofire -> AF로 접두어 변경
        // Default AF: 200 ~ 299 status code를 success
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                
                let date = json["drwNoDate"].string
                self.numberTextField.text = date
                
                var index = 1
                for label in self.lottoNumberLabels {
                    label.text = "\(json["drwtNo\(index)"].intValue)"
                    if index == 7 {
                        label.text =  "\(json["bnusNo"].intValue)"
                    }
                    index += 1
                }
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
        requestLotto(number: numberList[row])
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
}
