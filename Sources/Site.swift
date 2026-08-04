import Foundation
import Ignite

@main
struct IgniteWebsite {
    static func main() async {
        var site = HoltvedtSite()

        do {
            try await site.publish()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct HoltvedtSite: Site {
    var name = "Thomas Holtvedt"
    var titleSuffix = " - Consultant, Technologist, Builder"
    var url = URL(static: "https://www.holtvedt.com")
    var builtInIconsEnabled = true

    var author = "Thomas Holtvedt"

    var homePage = Home()
    var layout = MainLayout()

    var staticPages: [any StaticPage] {
        Archive()
    }
    var articlePages: [any ArticlePage] {
        NormalPost()
    }
}
