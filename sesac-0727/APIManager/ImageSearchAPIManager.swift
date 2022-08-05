//
//  ImageSearchAPIManager.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/08/05.
//

import Foundation

import Alamofire
import SwiftyJSON

// 클래스 싱글톤 패턴 vs 구조체 싱글톤 패턴
class ImageSearchAPIManager {
    
    private init() {}
    
    static let shard = ImageSearchAPIManager()
    
    typealias completionHandelr = (Int, [URL]) -> Void
    
    func fetchImageData(searchText: String, startPage: Int, completionHandler: @escaping completionHandelr) {
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "맘모스"
        
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=\(startPage)"
        
        let header: HTTPHeaders = ["X-Naver-Client-Id":APIKey.NAVER_ID, "X-Naver-Client-Secret":APIKey.NAVER_PW]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200...500)
            .responseData(queue: .global()) { response in // AF에서 제공해주는 비동기!!!!!!1
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    let total = json["total"].intValue
                    let urlList = json["items"].arrayValue.map { URL(string: $0["link"].stringValue)! }
        
                    completionHandler(total, urlList)
                    break
                    
                case .failure(let error):
                    print(error)
                    break
                }
            }
    }
}
