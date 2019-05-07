//
//  NewsHandler.swift
//  uToday
//
// This is going to be the handler for all the news feeds we want to grab to give to the user in the morning...
//  Created by Matthew Jagiela on 3/19/19.
//  Copyright © 2019 Matthew Jagiela. All rights reserved.
//

import UIKit
import NewsAPISwift
import SDWebImage

class NewsHandler: NSObject {
    var summary = ""
    var articles = [NewsArticle]()
    var images = [UIImage]() //This is going to be an array of all downloaded images we get from articles...
    let news = NewsAPI(apiKey: "1aad99aecdcf44f8bce4f9b62316966a")
    let savedData = LocalDataHandler()

    func getArticles(completion: @escaping () -> ()){
        news.getTopHeadlines(country: .us, pageSize: 1, page: 1){ result in
            switch result {
            case .success(let articles):
                self.articles = articles
            case .failure(let error):
                fatalError("ERROR: \(error.localizedDescription)")
            }
            print("DEBUG NEWS: ARTICLE SIZE: \(self.articles.count)")
            for article in self.articles{
                print("DEBUG NEWS: Article : TITLE = \(article.title), SOURCE = \(article.source.name), URL = \(article.url)")
            }
            self.summary = self.articles[0].title
            self.savedData.setNewsSummary(summary: self.getSummary())
            completion()
            
        }
    }
    func getHeadlineTitle(_ index: Int) -> String{ //This is going to take an integer of what we want to find and then pull the EDITED title from the array
        var headlineTitle = articles[index].title //This is going to be
        //var headlineTitle = "Stock - Lower as Wall Street Awaits Fed's Decision on Rates, FedEx Sinks - TheStreet.com"
        headlineTitle.removeFromLast("-")
        return headlineTitle
    }
    func getHeadlineSource(_ index: Int) -> String{
        return articles[index].source.name
    }
    func getHeadlineURL(_ index: Int) -> URL{
        return articles[index].url
    }
    func getSummary() -> String{
        print("DEBUG NEWS: GET SUMMARY")
        return summary
    }
    func getImageURL(_ index:Int) -> URL{
        return articles[index].urlToImage ?? URL(fileURLWithPath: "") //The default is going to return an empty string so we can just placehold our own image there...
    }
    
    

}

extension String { //This is going to be how we remove the source... 
    mutating func removeFromLast(_ ch: Character) {
        if let index = lastIndex(of: ch) {
            removeSubrange(index..<endIndex)
        }
    }
}
