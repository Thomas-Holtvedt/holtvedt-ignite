import Foundation
import Ignite

struct Home: StaticPage {
    var title = "Thomas Holtvedt"

    var body: some HTML {
        Section {
            Text("About").font(.title2)
            PersonalCard.thomas
            Text("Contact").font(.title3)
            Grid {
                ContactMethod.pwc
                ContactMethod.personal
            }.columns(2)
        }.id("about")

        Section {
            Text("Projects").font(.title2)
            Text("Active").font(.title3)
            Text("Projects that I am actively working on or is being actively maintained.")
            Grid {
                ProjectCard.goodSolutionInteractive
                ProjectCard.openGS
                ProjectCard.openGSMapTool
                ProjectCard.undisclosed
            }.columns(2)
            Text("Archive").font(.title3)
            Text("Projects that are no longer active, but deserve a mention.")
            Grid {
                ProjectCard.datafunn
                ProjectCard.panel
            }.columns(2)
        }.id("projects")

        Section {
            Text("Blog").font(.title2)
            Text("Placeholder Blog")
        }.id("blog")
    }
}
