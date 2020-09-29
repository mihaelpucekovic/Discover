//
//  Database.swift
//  Discover
//
//  Created by Mihael Puceković on 28/09/2020.
//

import Foundation
import CoreData

class Database {
    func fetchNewsFromDatabase(context: NSManagedObjectContext?) -> [News] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsCD")
        var newsTemp = [News]()

        do {
            let result = try context?.fetch(request)

            for data in result as! [NSManagedObject] {
                let id = data.value(forKey: "id") as? Int ?? 0
                let imageURL = data.value(forKey: "imageURL") as? String ?? ""
                let imageData = data.value(forKey: "imageData") as? Data ?? Data()
                let shareLink = data.value(forKey: "shareLink") as? String ?? ""
                let isHighlighted = data.value(forKey: "isHighlighted") as? Bool ?? false
                let createdAt = data.value(forKey: "createdAt") as? Int ?? 0
                let updatedAt = data.value(forKey: "updatedAt") as? Int ?? 0
                let caption = data.value(forKey: "caption") as? String ?? ""
                let isPromoted = data.value(forKey: "isPromoted") as? Int ?? 0
                let highlightedText = data.value(forKey: "highlightedText") as? String ?? ""
                let highlightedIcon = data.value(forKey: "highlightedIcon") as? String ?? ""
                let highlightedGradientColorFirst = data.value(forKey: "highlightedGradientColorFirst") as? String ?? ""
                let highlightedGradientColorSecond = data.value(forKey: "highlightedGradientColorSecond") as? String ?? ""
                let title = data.value(forKey: "title") as? String ?? ""
                let description = data.value(forKey: "desc") as? String ?? ""
              
                let news = News(id: id, imageURL: imageURL, imageData: imageData, shareLink: shareLink, isHighlighted: isHighlighted, createdAt: createdAt, updatedAt: updatedAt, caption: caption, isPromoted: isPromoted, highlightedText: highlightedText, highlightedIcon: highlightedIcon, highlightedGradientColorFirst: highlightedGradientColorFirst, highlightedGradientColorSecond: highlightedGradientColorSecond, title: title, description: description)
                    
                newsTemp.append(news)
            }
            
            return newsTemp
        } catch {
            return [News]()
        }
    }
    
    func saveAndUpdateNews(newsAPI: [News], newsDB: [News], context: NSManagedObjectContext?) {
        for news in newsAPI {
            if newsDB.contains(where: { $0.id == news.id }) {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsCD")
                request.predicate = NSPredicate(format: "id = %@", "\(news.id)")

                do {
                    let result = try context?.fetch(request)
                    let newsUpdate = result![0] as! NSManagedObject

                    newsUpdate.setValue(news.id, forKey: "id")
                    newsUpdate.setValue(news.imageURL, forKey: "imageURL")
                    newsUpdate.setValue(news.imageData, forKey: "imageData")
                    newsUpdate.setValue(news.shareLink, forKey: "shareLink")
                    newsUpdate.setValue(news.isHighlighted, forKey: "isHighlighted")
                    newsUpdate.setValue(news.createdAt, forKey: "createdAt")
                    newsUpdate.setValue(news.updatedAt, forKey: "updatedAt")
                    newsUpdate.setValue(news.caption, forKey: "caption")
                    newsUpdate.setValue(news.isPromoted, forKey: "isPromoted")
                    newsUpdate.setValue(news.highlightedText, forKey: "highlightedText")
                    newsUpdate.setValue(news.highlightedIcon, forKey: "highlightedIcon")
                    newsUpdate.setValue(news.highlightedGradientColorFirst, forKey: "highlightedGradientColorFirst")
                    newsUpdate.setValue(news.highlightedGradientColorSecond, forKey: "highlightedGradientColorSecond")
                    newsUpdate.setValue(news.title, forKey: "title")
                    newsUpdate.setValue(news.description, forKey: "desc")
                } catch {
                    print("News update failed.")
                }
            } else {
                let entity = NSEntityDescription.entity(forEntityName: "NewsCD", in: context!)
                let newNews = NSManagedObject(entity: entity!, insertInto: context)
                newNews.setValue(news.id, forKey: "id")
                newNews.setValue(news.imageURL, forKey: "imageURL")
                newNews.setValue(news.imageData, forKey: "imageData")
                newNews.setValue(news.shareLink, forKey: "shareLink")
                newNews.setValue(news.isHighlighted, forKey: "isHighlighted")
                newNews.setValue(news.createdAt, forKey: "createdAt")
                newNews.setValue(news.updatedAt, forKey: "updatedAt")
                newNews.setValue(news.caption, forKey: "caption")
                newNews.setValue(news.isPromoted, forKey: "isPromoted")
                newNews.setValue(news.highlightedText, forKey: "highlightedText")
                newNews.setValue(news.highlightedIcon, forKey: "highlightedIcon")
                newNews.setValue(news.highlightedGradientColorFirst, forKey: "highlightedGradientColorFirst")
                newNews.setValue(news.highlightedGradientColorSecond, forKey: "highlightedGradientColorSecond")
                newNews.setValue(news.title, forKey: "title")
                newNews.setValue(news.description, forKey: "desc")
            }

            do {
                try context?.save()
            } catch {
               print("Error during saving.")
            }
        }
    }
}
