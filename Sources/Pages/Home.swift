import Foundation
import Ignite

struct Home: StaticPage {
    @Environment(\.articles) var articles
    var title = "Thomas Holtvedt"

    var body: some HTML {
        Section {
            Text("About").font(.title2)
            PersonalCard.thomas
            Text("Contact").font(.title3)
            Grid {
                ContactMethod.pwc
                ContactMethod.personal
            }.columns(2).class("equal-height")
        }.id("about").frame(minHeight: .custom("calc(100vh - \(NavBar.navBarHeight)px)")).padding(
            .px(40)
        )
        .style(.scrollMarginTop, "\(NavBar.navBarHeight)px")

        Section {
            Text("Projects").font(.title2)
            Text("Active").font(.title3)
            Text("Projects that I am actively working on or is being actively maintained.")
            Grid {
                ProjectCard.goodSolutionInteractive
                ProjectCard.openGS
                ProjectCard.openGSMapTool
                ProjectCard.undisclosed
            }.columns(2).class("equal-height")
            Text("Archive").font(.title3)
            Text("Projects that are no longer active, but deserve a mention.")
            Grid {
                ProjectCard.datafunn
                ProjectCard.panel
            }.columns(2).class("equal-height")
        }.id("projects").frame(minHeight: .custom("calc(100vh - \(NavBar.navBarHeight)px)"))
            .padding(
                .px(40)
            )
            .style(.scrollMarginTop, "\(NavBar.navBarHeight)px")

        Section {
            Text("Blog").font(.title2)
            Text("Latest Articles")
            Grid(articles.all.sorted { $0.date > $1.date }.prefix(4), alignment: .top) { item in
                    ArticlePreview(for: item)
                        .width(3)
                        .margin(.bottom)
                }
            
            Link("Read more in the article archive", target: Archive())
        }.id("blog").frame(minHeight: .custom("calc(100vh - \(NavBar.navBarHeight)px)")).padding(
            .px(40)
        )
        .style(.scrollMarginTop, "\(NavBar.navBarHeight)px")
    }
}
