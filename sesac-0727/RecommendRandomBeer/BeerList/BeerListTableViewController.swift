//
//  BeerListTableViewController.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class BeerListTableViewController: UITableViewController {

    var beerList: [BeerInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = DefaultColor.backgroundColor
        setBeerInfos()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerListTableViewCell.reuseIdentifier, for: indexPath) as? BeerListTableViewCell else { return UITableViewCell() }
        
        cell.beerImageView.kf.setImage(with: beerList[indexPath.row].image_url)
        cell.beerNameLabel.text = beerList[indexPath.row].name
        cell.beerDescriptionLabel.text = beerList[indexPath.row].description
        
        cell.beerNameLabel.setTitleDesign()
        cell.beerNameLabel.numberOfLines = 2
        
        cell.beerDescriptionLabel.setContentDesign()
        cell.beerDescriptionLabel.numberOfLines = 0
        cell.beerDescriptionLabel.textAlignment = .left
        
        cell.backgroundColor = .clear
        
        return cell
    }

    func setBeerInfos() {
        
        AF.request(EndPoint.beerListURL, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                for index in 0..<JSON(value).arrayValue.count {
                    let json = JSON(value)[index]
                    self.parsingInfoInJson(json: json, index: index)
                }
                self.tableView.reloadData()
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
