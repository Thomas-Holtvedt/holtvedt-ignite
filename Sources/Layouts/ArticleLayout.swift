import Foundation
import Ignite

struct ArticleLayout: ArticlePage {
    var body: some HTML {
        Section {
            Grid(alignment: .top) {
                Section {
                    Text(article.title)  //First header or filename as backup
                        .font(.title1)
                    if let image = article.image {
                        Image(image, description: article.imageDescription)
                    }
                    // Choose to disable subtitle, makes writing a bit confusing. Only used in overviews etc.
                    //Text(article.subtitle ?? "").font(.title2)
                    Text(article.text)
                }.width(9)
                Section {  //Meta Data Section on the right
                    Card {
                        Text {
                            "Published: \(article.date.formatted(date: .long, time: .omitted))"
                        }
                        Text {
                            "Last Modified: \(article.lastModified.formatted(date: .long, time: .omitted))"
                        }
                        Text(
                            "\(article.estimatedWordCount) words; \(article.estimatedReadingMinutes) minutes to read."
                        )
                    } header: {
                        Text {
                            "Author: \(article.author ?? "")"
                        }
                    } footer: {
                        if let tagLinks = article.tagLinks() {
                            HStack(spacing: .xSmall) {
                                ForEach(tagLinks) { link in
                                    link
                                }
                            }
                        }
                        Link("Read more articles in the archive", target: Archive())
                    }
                }
                .width(3)
            }
        }.padding(.px(40))
    }
}
