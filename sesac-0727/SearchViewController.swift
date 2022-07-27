//
//  SearchViewController.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/07/27.
//

import UIKit

/*
  Swift Protocol
  - Delegate
  - Datasource
 
  1. 왼팔/오른팔
 */

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var searchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        // 연결고리 작업: 테이블뷰가 해야 할 역할 > 뷰 컨트롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        // 테이블뷰뷰가 사용할 테이블 뷰 셀(XIB) 등록
        // XIB: XML Inteface Builder <= 예전에는 NIB이라는 타입 사용
        searchTableView.register(UINib(nibName: ListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.identifier)
        
        searchTableView.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "HELLO"
        cell.backgroundColor = .clear
        
        return cell
    }
}
