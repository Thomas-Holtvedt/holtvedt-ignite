import Foundation
import Ignite

struct TagArchive: TagPage {
    var body: some HTML {
        Section {
            Text(tag.name).font(.title2)
            Table {
                for article in tag.articles {
                    Row {
                        Link(article)
                        Text(article.subtitle ?? "")
                        article.date
                            .formatted(date: .long, time: .omitted)
                        article.lastModified
                            .formatted(date: .long, time: .omitted)
                        if let tagLinks = article.tagLinks() {
                            HStack(spacing: .xSmall) {
                                ForEach(tagLinks) { link in
                                    link
                                }
                            }
                        }
                    }
                }
            } header: {
                "Article"
                "Subtitle"
                "Date Published"
                "Last Modified"
                "Tags"
            }
            .tableStyle(.stripedRows)
            Link("Back to full archive", target: Archive())
        }
        .padding(.px(40))
    }
}
