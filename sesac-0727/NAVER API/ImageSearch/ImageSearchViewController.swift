//
//  ImageSearchViewController.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

class ImageSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage(searchText: "과자")
    }
    
    func fetchImage(searchText: String) {
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "맘모스"
        
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=31"
        
        let header: HTTPHeaders = ["X-Naver-Client-Id":APIKey.NAVER_ID, "X-Naver-Client-Secret":APIKey.NAVER_PW]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200...500)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    break
                    
                case .failure(let error):
                    print(error)
                    break
                }
            }
    }
}
