//
//  SearchViewController.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/07/27.
//

import UIKit

import Alamofire
import JGProgressHUD
import SwiftyJSON

/*
  Swift Protocol
  - Delegate
  - Datasource
 
  1. 왼팔/오른팔
  2. 테이블뷰 아웃렛 연결
  3. 1 + 2
 */

/**
  각 json
 */

// 프로토콜은 상속 다음에 채택되어야 한다.
class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    //BoxOffice 배열
    var list: [BoxOfficeModel] = []
    
    let hud = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        // 연결고리 작업: 테이블뷰가 해야 할 역할 > 뷰 컨트롤러에게 요청
        connectDelegateAndDataSource()
        
        // 테이블뷰뷰가 사용할 테이블 뷰 셀(XIB) 등록
        // XIB: XML Inteface Builder <= 예전에는 NIB이라는 타입 사용
        registerTableViewCell()
        
        // 어제로 가기
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd" // TMI -> "yyyyMMdd" "YYYYMMdd"
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let dateResult = format.string(from: yesterday!)
        print(dateResult)
        
        //0802 실습
        requestBoxOffice(text: dateResult)
        
    }
    
    func connectDelegateAndDataSource() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        searchBar.delegate = self
    }
    func registerTableViewCell() {
        searchTableView.register(UINib(nibName: ListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.identifier)
        searchTableView.backgroundColor = .clear
    }
    
    func requestBoxOffice(text: String) {
        hud.show(in: self.view)
        let url = EndPoint.boxOfficeURL + "key=\(APIKey.BOXOFFICE)&targetDt=\(text)"
        
        self.list.removeAll() // 언제 이 아이를 넣어줄것이냐
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let movieNm = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    
                    let data = BoxOfficeModel(movieTitle: movieNm, releaseDate: openDt, totalCount: audiAcc)
                    self.list.append(data)
                }
                
                
                self.searchTableView.reloadData()
                self.hud.dismiss()
                
            case .failure(let error):
                self.hud.dismiss()
                print(error)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.font = UIFont(name: "S-CoreDream-3Light", size: 20)
        cell.titleLabel.text = "\(list[indexPath.row].movieTitle): \(list[indexPath.row].releaseDate):\(list[indexPath.row].totalCount)"
        cell.titleLabel.textColor = .white
        cell.backgroundColor = .clear
        
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            requestBoxOffice(text: text)
        }
    }
}
