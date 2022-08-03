//
//  BeerListCollectionViewController.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/08/03.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class BeerListCollectionViewController: UICollectionViewController {

    var beerList: [BeerInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBeerList()
        designCollectionView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beerList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerListCollectionViewCell.reuseIdentifier, for: indexPath) as? BeerListCollectionViewCell else { return UICollectionViewCell() }
        
        let beerInfo = beerList[indexPath.row]
        cell.beerImageView.kf.setImage(with: beerInfo.image_url)
        cell.beerNameLabel.text = beerInfo.name
        cell.beerDescriptionLabel.text = beerInfo.description
        cell.beerDescriptionLabel.numberOfLines = 0
        cell.mainView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 40).isActive = true
        cell.lineView.layer.borderWidth = 0.5
        cell.lineView.layer.borderColor = UIColor.lightGray.cgColor
//        cell.mainView.backgroundColor = [UIColor.yellow, UIColor.systemPink, UIColor.black].randomElement()
        
        return cell
    }
    
    func designCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        layout.minimumLineSpacing = 40
        
        collectionView.collectionViewLayout = layout
        
    }
    
    func setBeerList() {
        AF.request(EndPoint.beerListURL, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                for index in 0..<JSON(value).arrayValue.count {
                    let json = JSON(value)[index]
                    self.parsingInfoInJson(json: json, index: index)
                }
                self.collectionView.reloadData()
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func parsingInfoInJson(json: JSON, index: Int) {
        var image_url: URL?
        
        if let url = json[Beer.jsonKeys.image_url.rawValue].string {
            image_url = URL(string: url)
        } else {
            image_url = URL(string: "https://nawmin.com/wp-content/uploads/2022/05/20220515_%E3%83%92%E3%82%99%E3%83%BC%E3%83%AB_01_1-768x768.png")
        }
        let name = json[Beer.jsonKeys.name.rawValue].stringValue
        let description = json[Beer.jsonKeys.description.rawValue].stringValue
        
        beerList.append(BeerInfo(image_url: image_url!, name: name, description: description))
    }
}
