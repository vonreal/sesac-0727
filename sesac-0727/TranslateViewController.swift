//
//  TranslateViewController.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/07/28.
//

import UIKit

// 텍스트필드 관련
// UIResponderChain > resignFirstResponder() / becomeFirstResponder()

class TranslateViewController: UIViewController {

    @IBOutlet weak var userInputTextView: UITextView!
    @IBOutlet weak var charCount: UILabel!
    
    let textViewPlaceholderText = "번역할 문장을 입력해 주세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userInputTextView.delegate = self
        
        userInputTextView.text = textViewPlaceholderText
        userInputTextView.textColor = .lightGray
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
