import Foundation
import Ignite

struct Archive: StaticPage {
    @Environment(\.articles) var articles
    
    var title = "Blog Archive"
    var body: some HTML {
        Section {
            Table {
                for article in articles.all {
                    Row {
                        Link(article)
                        article.date
                            .formatted(date: .numeric, time: .shortened)
                        if let tagLinks = article.tagLinks() {
                            HStack(spacing: .xSmall) {
                                ForEach(tagLinks) { link in
                                    link.font(.title3)
                                }
                            }
                        }
                    }
                }
            }header: {
                "Article"
                "Date Published"
                "Tags"
            }
            .tableStyle(.stripedRows)
        }
        .padding(.px(40))
        
    }
}
