//
//  Model.swift
//  TinkoffLab
//
//  Created by Дмитрий Пермяков on 03.02.2023.
//

import Foundation

struct Status: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Articles]
}

struct Articles: Decodable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: String?
    let content: String?
}

struct Source: Decodable {
    let id: String?
    let name: String?
}

extension Articles {
    func GetSourceData() -> (String?, String?){
        return (source.id, source.name)
    }
}
var idArticles = 0

struct NewsData: Codable, Equatable{
    let source: String?
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: String?
    let content: String?
    var counterTouch: Int
    
    func setNews() {
        if let temp = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(temp, forKey: self.getKey())
        }
    }
    
    func getKey() -> String {
        return self.content ?? "noncontent"
    }
}

class APIManager {
    static let shared = APIManager()
    
    let urlString = "https://newsapi.org/v2/everything?q=keyword&apiKey=5bb077a0181341b99bf6345c40f3b2d9"
    func getNews(completion: @escaping ([NewsData]) -> Void) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            let _ = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data else { return }
                if let newsInfo = try? JSONDecoder().decode(Status.self, from: data) {
                    var dataFromNews: [NewsData] = []
                    for el in newsInfo.articles {
                        let tempData = NewsData(source: el.source.name, author: el.author, title: el.title, description: el.description, url: el.url, urlToImage: el.urlToImage, publishedAt: el.publishedAt, content: el.content, counterTouch: 0)
                        tempData.setNews()
                        dataFromNews.append(tempData)
                        UserDefaults.standard.set(0, forKey: tempData.content ?? "noncontent")
                    }
                    completion(dataFromNews)
                } else {
                    print("ERROR")
                }
            }.resume()
        }
    }

}
