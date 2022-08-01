//
//  Beer.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/08/01.
//

import Foundation

struct Beer {
    private init() {}
    
    enum jsonKeys: String {
        case image_url = "image_url"
        case name = "name"
        case description = "description"
    }
    
    static var image_url: URL? = nil
    static var name: String? = nil
    static var description: String? = nil
}
