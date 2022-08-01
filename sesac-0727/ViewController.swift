//
//  ViewController.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/07/27.
//

import UIKit

class ViewController: UIViewController, ViewPrsentableProtocol{
    var backgroundColor: UIColor = .blue
    
    
    static let identifier: String = "ViewController"
    
    var navigationTitleString: String = "대장님의 다마고치"
    
    
    func configureView() {
        navigationTitleString = "고래밥님의 다마고치"
//        backgroundColor = .red
        
        title = navigationTitleString
        view.backgroundColor = backgroundColor
    }
    
    func configureLabel() {
        print("hi")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaultHelper.standard.nickname = "고래밥"
    }


}

