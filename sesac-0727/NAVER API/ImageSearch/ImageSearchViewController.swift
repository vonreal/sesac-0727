//
//  ImageSearchViewController.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/08/03.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class ImageSearchViewController: UIViewController {

    @IBOutlet weak var imageSearchBar: UISearchBar!
    @IBOutlet weak var resultImageCollectionView: UICollectionView!
    
    var searchResultList: [URL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewDelegate()
        searchBarDelegate()
        registerNib()

        designCollectionView()
    }
    
    func collectionViewDelegate() {
        resultImageCollectionView.delegate = self
        resultImageCollectionView.dataSource = self
    }
    func searchBarDelegate() {
        imageSearchBar.delegate = self
    }
    func registerNib() {
        let nibName = UINib(nibName: ImageSearchCollectionViewCell.reuseIdentifier, bundle: nil)
        resultImageCollectionView.register(nibName, forCellWithReuseIdentifier: ImageSearchCollectionViewCell.reuseIdentifier)
    }
    
    func fetchImage(searchText: String) {
        searchResultList.removeAll()
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "맘모스"
        
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=31"
        
        let header: HTTPHeaders = ["X-Naver-Client-Id":APIKey.NAVER_ID, "X-Naver-Client-Secret":APIKey.NAVER_PW]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200...500)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let items = json["items"].arrayValue
                    for item in items {
                        let link = item["link"].stringValue
                        self.searchResultList.append(URL(string: link)!)
                    }
                    self.resultImageCollectionView.reloadData()
                    break
                    
                case .failure(let error):
                    print(error)
                    break
                }
            }
    }
}

extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSearchCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageSearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.searchResultImageView.kf.setImage(with: searchResultList[indexPath.row])
        cell.searchResultImageView.contentMode = .scaleAspectFill
        
        return cell
    }
    
    func designCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 2
        let width = UIScreen.main.bounds.width - (spacing * 2)
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        resultImageCollectionView.collectionViewLayout = layout
    }
}

extension ImageSearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            fetchImage(searchText: text)
        } else {
            searchBar.text = "검색어를 입력해주세요."
        }
    }
}
