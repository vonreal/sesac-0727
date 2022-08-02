//
//  TranslateViewController.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

// 텍스트필드 관련
// UIResponderChain > resignFirstResponder() / becomeFirstResponder()

class TranslateViewController: UIViewController {

    @IBOutlet weak var userInputTextView: UITextView!
    @IBOutlet weak var charCount: UILabel!
    @IBOutlet weak var resultTextView: UITextView!
    
    let textViewPlaceholderText = "번역할 문장을 입력해 주세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userInputTextView.delegate = self
        
        userInputTextView.text = textViewPlaceholderText
        userInputTextView.font = UIFont(name: "ghanachoco", size: 30)
        userInputTextView.textColor = .lightGray
    }
    func requestTranslateData(data: String) {
        let url = EndPoint.translateURL
        
        let paramter: Parameters = ["source": "ko", "target":"en", "text":data]
        let header: HTTPHeaders = ["X-Naver-Client-Id":APIKey.NAVER_ID, "X-Naver-Client-Secret":APIKey.NAVER_PW]
        
        AF.request(url, method: .post, parameters: paramter, headers: header)
            .validate(statusCode: 200...500)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    let statusCode = response.response?.statusCode ?? 500
                    if statusCode == 200 {
                        self.resultTextView.text = json["message"]["result"]["translatedText"].string
                    } else {
                        self.resultTextView.text = json["errorMessage"].string
                    }
                    break
                    
                case .failure(let error):
                    print(error)
                    break
                }
            }
    }
    
    @IBAction func translateButtonClicked(_ sender: UIButton) {
        requestTranslateData(data: userInputTextView.text)
    }
    
}


extension TranslateViewController: UITextViewDelegate{
    
    // 텍스트뷰의 텍스트가 변할 때마다 호출
    func textViewDidChange(_ textView: UITextView) {
        charCount.text = "\(textView.text.count)"
    }
    
    // 편집이 시작될 때, 커서가 시작될 때
    // 텍스트뷰 글자: 플레이스 홀더랑 글자가 같으면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Begin")
        
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 편집이 끝났을 때, 커서가 없어지는 순간
    // 텍스트뷰 글자: 사용자가 아무 글자도 안 썼으면 플레이스 홀더 글자 보이게 해!
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End")
        
        if textView.text.isEmpty {
            textView.text = textViewPlaceholderText
            textView.textColor = .lightGray
        }
    }
    
}
