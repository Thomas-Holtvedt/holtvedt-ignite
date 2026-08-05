import Foundation
import Ignite

struct NormalPost: ArticlePage {
    var body: some HTML {
        Text(article.title)
            .font(.title1)
            .padding(.px(40))
        
        Grid{
            Section {
                
                Text(article.text)
            }.width(9)
            
            Card {
                Text(article.author ?? "")
                //Text(article.Date).formatted(date: .numeric, time: .shortened)
                
                Text("\(article.estimatedWordCount) words; \(article.estimatedReadingMinutes) minutes to read.")
                if let tagLinks = article.tagLinks() {
                            HStack(spacing: .xSmall) {
                                ForEach(tagLinks) { link in
                                    link.font(.title3)
                                }
                            }
                        }
            }.width(3)

        }
        
        
        
        if let image = article.image {
            Image(image, description: article.imageDescription)
                .resizable()
                .cornerRadius(20)
                .frame(maxHeight: 300)
        }
    }
}
