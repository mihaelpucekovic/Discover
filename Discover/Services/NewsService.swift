//
//  NewsService.swift
//  Discover
//
//  Created by Mihael Puceković on 28/09/2020.
//

import UIKit

class NewsService {
    func fetchNews(completion: @escaping ((ResultEnum<Any>?) -> Void)) {
        let urlString = "https://api.ajmo.hr/v3/news/index?isPromoted=1"
        
        guard let url = URL(string: urlString) else {
            return completion(.failure("Failure"))
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return completion(.failure("Failure"))
            }
            
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data, options: [])

                guard let all = jsonData as? [String: Any], let dataNews = all["data"] as? [[String: Any]] else {
                    return completion(.failure("Failure"))
                }
                
                let newsArray = dataNews.compactMap{ json -> News? in
                    if
                        let id = json["id"] as? Int,
                        let imageURL = json["image_url"] as? String,
                        let shareLink = json["share_link"] as? String,
                        let isHighlighted = json["isHighlighted"] as? Bool,
                        let createdAt = json["created_at"] as? Int,
                        let updatedAt = json["updated_at"] as? Int,
                        let caption = json["caption"] as? String,
                        let isPromoted = json["is_promoted"] as? Int,
                        let highlightedText = json["highlighted_text"] as? String,
                        let highlightedIcon = json["highlighted_icon"] as? String,
                        let highlightedGradientColorFirst = json["highlighted_gradient_color_first"] as? String,
                        let highlightedGradientColorSecond = json["highlighted_gradient_color_second"] as? String,
                        let title = json["title"] as? String,
                        let description = json["description"] as? String {
                        
                        let urlString = URL(string: imageURL)
                        let imageData = try? Data(contentsOf: urlString!)
                        
                        let news = News(id: id, imageURL: imageURL, imageData: imageData!, shareLink: shareLink, isHighlighted: isHighlighted, createdAt: createdAt, updatedAt: updatedAt, caption: caption, isPromoted: isPromoted, highlightedText: highlightedText, highlightedIcon: highlightedIcon, highlightedGradientColorFirst: highlightedGradientColorFirst, highlightedGradientColorSecond: highlightedGradientColorSecond, title: title, description: description)
                        return news
                    } else {
                        return nil
                    }
                }
                
                completion(.success(newsArray))
            } catch {
                completion(.failure("Failure"))
            }
        }
        
        dataTask.resume()
    }
}
