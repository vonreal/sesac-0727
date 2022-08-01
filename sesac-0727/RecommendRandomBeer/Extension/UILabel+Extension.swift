//
//  UILabel+Extension.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/08/01.
//

import UIKit

extension UILabel {
    func setBrandColor() {
        self.textColor = DefaultColor.brandColor
    }
    
    func setTitleDesign() {
        self.textColor = DefaultColor.titleColor
        self.font = UIFont(name: "BMDoHyeon-OTF", size: 18)
        self.textAlignment = .center
    }
    
    func setSubTitleDesign() {
        self.textColor = DefaultColor.subTitleColor
        self.font = UIFont(name: "BMDoHyeon-OTF", size: 16)
        self.numberOfLines = 0
        self.textAlignment = .center
    }
    
    func setContentDesign() {
        self.textColor = DefaultColor.subTitleColor
        self.font = .systemFont(ofSize: 16)
        self.numberOfLines = 5
        self.textAlignment = .center
    }
}
