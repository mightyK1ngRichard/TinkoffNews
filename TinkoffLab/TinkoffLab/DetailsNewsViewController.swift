//
//  DetailsNewsViewController.swift
//  TinkoffLab
//
//  Created by Дмитрий Пермяков on 04.02.2023.
//

import UIKit

class DetailsNewsViewController: UIViewController {

    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var dateNews: UILabel!
    @IBOutlet weak var descriptionNews: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var sourceNews: UILabel!
    @IBOutlet weak var buttonNews: UIButton!
    
    private var linkForVC: URL?
    var keyNews: String?
    override func viewDidLoad() {
        super.viewDidLoad()
//        titleNews.adjustsFontSizeToFitWidth = true
        if let data = UserDefaults.standard.object(forKey: keyNews!) {
            if let dataUD = try? JSONDecoder().decode(NewsData.self, from: data as! Data) {
                titleNews.text = dataUD.title ?? "Без заголовка"
                titleNews.font = .systemFont(ofSize: 20, weight: .bold)
                dateNews.text = dataUD.publishedAt ?? "Дата публикации неизвестна"
                descriptionNews.text = dataUD.description ?? "Описание отсутствует"
                // TODO: - подумать, как избежать повторной проверки.
                if let urlForCell = dataUD.urlToImage {
                    if verifyUrl(urlString: "\(urlForCell)") {
                        let url = urlForCell
                        DispatchQueue.global().async {
                            if let data = try? Data(contentsOf: url) {
                                DispatchQueue.main.async {
                                    self.imageNews.image = UIImage(data: data)
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.imageNews.image = UIImage(named: "tinkoff")
                                }
                            }
                        }
                    }
                } else {
                    DispatchQueue.global().async {
                        DispatchQueue.main.async {
                            self.imageNews.image = UIImage(named: "tinkoff")
                        }
                    }
                }
                // -
                
                sourceNews.text = "Источник: \(dataUD.source ?? "не известен")"
                if dataUD.url != nil {
                    buttonNews.setTitle(String(describing: dataUD.url!), for: .normal)
                    linkForVC = dataUD.url!
                } else {
                    buttonNews.isHidden = true
                }
            }
        }
    }
    
    
    @IBAction func pressLink(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc2 = storyBoard.instantiateViewController(withIdentifier: "VC2") as? WebNewsViewController {
            vc2.linkToNews = linkForVC!
            show(vc2, sender: nil)
        }
    }
    
}
