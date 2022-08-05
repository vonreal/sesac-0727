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
    
    // 네트워크 요청할 시작 페이지 넘버
    var startPage = 1
    var total = 0
    
    var searchResultList: [URL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewDelegate()
        
        resultImageCollectionView.prefetchDataSource = self
        
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
        ImageSearchAPIManager.shard.fetchImageData(searchText: searchText, startPage: startPage) { totalCount, list in
            self.total = totalCount
            self.searchResultList.append(contentsOf: list)
            self.resultImageCollectionView.reloadData()
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
        cell.backgroundColor = .lightGray
        
        return cell
    }
    
    func designCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 2
        let width = UIScreen.main.bounds.width - (spacing * 4)
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        resultImageCollectionView.collectionViewLayout = layout
    }
    
    // MARK: - [페이지네이션]
    // <페이지네이션 방법1> - 컬렉션뷰가 특정 셀을 그리려는 시점에 호출되는 메서드.
    // 마지막 셀에 사용자가 위치해있는지 명확하게 확인하기가 어려움
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//    }
    
    // <페이지네이션 방법2> - UIScrollViewDelegateProtocol
    // 테이블뷰/컬렉션뷰 스크롤뷰를 상속받고 있어서, 스크롤뷰 프로토콜을 사용할 수 있음
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
//    }
//
}

// <페이지네이션 방법3> - 용량이 큰 이미지를 다운받아 셀에 보여주려고 하는 경우에 효과적
// 셀이 화면에 보이기 전에 미리 필요한 리소스를 다운받을 수 있고, 필요하지 않다면 데이터를 취소할 수도 있음.
// iOS10 이상, 스크롤 성능 향상됨.
extension ImageSearchViewController: UICollectionViewDataSourcePrefetching {
    
    // 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if searchResultList.count - 1 == indexPath.item, total > indexPath.item {
                startPage += 30
                
                fetchImage(searchText: imageSearchBar.text!)
            }
        }
        
        print("====\(indexPaths)")
    }
    
    // 취소: 직접 취소하는 기능을 구현해야 함
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("취소====\(indexPaths)")
    }
    
    
}

extension ImageSearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            fetchImage(searchText: text)
        } else {
            searchBar.text = "검색어를 입력해주세요."
        }
    }
    
    // 취소 버튼 눌렀을때
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResultList.removeAll()
        resultImageCollectionView.reloadData()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
    }
}
