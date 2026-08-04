import Foundation
import Ignite

struct NormalPost: ArticlePage {
    var body: some HTML {
        Text(article.title)
            .font(.title1)
            .padding(.px(40))
        
        Grid{
            Text("By: \(String(describing: article.author))")
            Text("By: \(String(describing: article.date))")
        }.columns(2)
        
        if let tagLinks = article.tagLinks() {
                    HStack(spacing: .xSmall) {
                        ForEach(tagLinks) { link in
                            link.font(.title3)
                        }
                    }
                }
        
        
        if let image = article.image {
            Image(image, description: article.imageDescription)
                .resizable()
                .cornerRadius(20)
                .frame(maxHeight: 300)
        }
        
        



                Text("\(article.estimatedWordCount) words; \(article.estimatedReadingMinutes) minutes to read.")
    

        Text(article.text)
    }
}
