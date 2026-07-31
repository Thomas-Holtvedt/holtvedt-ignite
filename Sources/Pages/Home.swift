import Foundation
import Ignite

struct Home: StaticPage {
    var title = "Thomas Holtvedt"

    var body: some HTML {
        Section {
            Text("About").font(.title2)
            PersonalCard.thomas
            Text("Contact").font(.title3)
            ContactMethod.pwc
            ContactMethod.personal
        }.id("about")

        Section {
            Text("Projects").font(.title2)
            Text("Active").font(.title3)
            Text("Projects that I am actively working on or is being actively maintained.")
            ProjectCard.goodSolutionInteractive
            ProjectCard.openGS
            ProjectCard.openGSMapTool
            ProjectCard.undisclosed
            Text("Archive").font(.title3)
            Text("Projects that are no longer active, but deserve a mention.")
            ProjectCard.datafunn
            ProjectCard.panel
        }.id("projects")

        Section {
            Text("Blog").font(.title2)
            Text("Placeholder Blog")
        }.id("blog")
    }
}
