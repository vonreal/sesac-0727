//
//  RecommendRandomBeerViewController.swift
//  sesac-0727
//
//  Created by 나지운 on 2022/08/01.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

// 의도: API를 통해 있는 맥주 리스트를 버튼을 누르면 랜덤으로 추첨해주는 앱을 만들어보자.
// 선수지식: 네트워크 통신, storyboard, vc
class RecommendRandomBeerViewController: UIViewController {

    @IBOutlet weak var subMainTitleLabel: UILabel!
    @IBOutlet weak var mainTitlelabel: UILabel!
    
    @IBOutlet var lineViewCollections: [UIView]!
    
    @IBOutlet weak var beerImageView: UIImageView!
    
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
    @IBOutlet weak var recommendBeerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBeerInfo()
        designUI()
    }
    
    func setBeerInfo() {
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)[0]
                self.parsingInfoInJson(json: json)
                self.beerImageView.kf.setImage(with: Beer.image_url)
                self.beerNameLabel.text = Beer.name
                self.beerDescriptionLabel.text = Beer.description
            case .failure(let error):
                print(error)
            }
        }
        

    }
    
    func parsingInfoInJson(json: JSON) {
        if let url = json[Beer.jsonKeys.image_url.rawValue].string {
            Beer.image_url = URL(string: url)
        } else {
            Beer.image_url = URL(string: "https://nawmin.com/wp-content/uploads/2022/05/20220515_%E3%83%92%E3%82%99%E3%83%BC%E3%83%AB_01_1-768x768.png")
        }
        Beer.name = json[Beer.jsonKeys.name.rawValue].string
        Beer.description = json[Beer.jsonKeys.description.rawValue].string
    }
    
    func designUI() {
        view.backgroundColor = DefaultColor.backgroundColor
        designLineViews()
        desginMainTitleLabels()
        designBeerLabels()
        designButton()
    }
    
    func designLineViews() {
        for view in lineViewCollections {
            view.layer.borderColor = DefaultColor.contentColor.cgColor
            view.layer.borderWidth = 0.25
        }
    }
    
    func desginMainTitleLabels() {
        subMainTitleLabel.setBrandColor()
        subMainTitleLabel.font = UIFont(name: "CourierNewPS-ItalicMT", size: 18)
        mainTitlelabel.setBrandColor()
        mainTitlelabel.font = UIFont(name: "ghanachoco", size: 28)
    }
    
    func designBeerLabels() {
        beerNameLabel.setTitleDesign()
        beerDescriptionLabel.setContentDesign()
        
        beerNameLabel.numberOfLines = 2
        beerDescriptionLabel.numberOfLines = 5
    }
    
    func designButton() {
        recommendBeerButton.backgroundColor = DefaultColor.brandColor
        recommendBeerButton.setTitle("새로운 맥주 추천 받기", for: .normal)
        recommendBeerButton.setTitleColor(.white, for: .normal)
        recommendBeerButton.layer.cornerRadius = 6
        recommendBeerButton.titleLabel?.font = UIFont(name: "BMDoHyeon-OTF", size: 14)
    }
    
    
    @IBAction func RecommendRandomButtonClicked(_ sender: UIButton) {
        setBeerInfo()
        
    }
}
