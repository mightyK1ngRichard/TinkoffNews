//
//  ViewController.swift
//  TinkoffLab
//
//  Created by Дмитрий Пермяков on 03.02.2023.
//

import UIKit

class ViewController: UIViewController {

    let idCell = "mainCell"
    private var InfoFromAPI = [NewsData]()
    @IBOutlet weak var tableView: UITableView!
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        tableView.refreshControl = myRefreshControl
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: idCell)
        APIManager.shared.getNews { [weak self] data in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.InfoFromAPI = data
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        APIManager.shared.getNews { [weak self] data in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.InfoFromAPI = data
                self.tableView.reloadData()
            }
        }
        sender.endRefreshing()
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if InfoFromAPI.count > 20 {
            return 20
        }
        return InfoFromAPI.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! MainTableViewCell
        let dataForCell = InfoFromAPI[indexPath.row]
        cell.titleCell.text = dataForCell.title ?? "Без заголовка"
        let tempCounter = UserDefaults.standard.integer(forKey: dataForCell.author ?? "anonim")
        cell.counterCell.text = "Просмотров: \(tempCounter)"
        if let urlForCell = dataForCell.urlToImage {
            if verifyUrl(urlString: "\(urlForCell)") {
                let url = urlForCell
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            cell.imageCell.image = UIImage(data: data)
                        }
                    } else {
                        DispatchQueue.main.async {
                            cell.imageCell.image = UIImage(named: "tinkoff")
                        }
                    }
                }
            }
        } else {
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    cell.imageCell.image = UIImage(named: "tinkoff")
                }
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataFromCell = InfoFromAPI[indexPath.row]
        // Меняем счётчик.
        if UserDefaults.standard.object(forKey: dataFromCell.content!) != nil {
            let tempCounter = UserDefaults.standard.integer(forKey: dataFromCell.author ?? "anonim")
            UserDefaults.standard.set(tempCounter + 1, forKey: dataFromCell.author ?? "anonim")
            UserDefaults.standard.synchronize()
        } else {
            UserDefaults.standard.set(0, forKey: dataFromCell.author ?? "anonim")
            UserDefaults.standard.synchronize()
        }
        tableView.reloadData()

        if let temp = try? JSONEncoder().encode(dataFromCell) {
            UserDefaults.standard.set(temp, forKey: dataFromCell.getKey())
        }        
        tableView.deselectRow(at: indexPath, animated: true)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc2 = storyBoard.instantiateViewController(withIdentifier: "VCDetails") as? DetailsNewsViewController {
            vc2.keyNews = dataFromCell.getKey()
            show(vc2, sender: nil)
        }
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row > 20 {
//            self.perform(#selector(loadData), with: nil, afterDelay: 1.0)
//        }
//    }
//    @objc func loadData() {
//        return self.tableView.reloadData()
//    }

}

func verifyUrl(urlString: String?) -> Bool {
    guard let urlString = urlString,
          let url = URL(string: urlString) else {
        return false
    }

    return UIApplication.shared.canOpenURL(url)
}
