import Ignite

struct PersonalCard: HTML {
    let photo: String
    let name: String
    let paragraphs: [InlineGroup]

    var body: some HTML {
        Grid {

            Image("/images/\(photo)", description: name).frame(width: .px(200)).width(3)
            Section {

                for paragraph in paragraphs {
                    Text(paragraph)
                }
            }.width(9)
        }
    }
}

extension PersonalCard {
    static let thomas = PersonalCard(
        photo: "photo-thomas.jpg",
        name: "Thomas Holtvedt",
        paragraphs: [
            InlineGroup {
                "Hi, I'm Thomas Holtvedt. I'm a Senior Manager at "
                Link("PwC", target: "https://www.pwc.no/")
                ", a technologist, and a builder."
            },
            InlineGroup {
                "At PwC I work as a business consultant within Microsoft Dynamics "
                "365 Finance. My job is to help organizations optimize complex finance "
                "operations and shape them into systems they can actually rely on: "
                "clean architectures, auditable processes, and teams that trust the "
                "numbers. It's demanding work, and it's where I've sharpened the "
                "instincts I bring to everything else I do."
            },
            InlineGroup {
                "Outside my day job I am a hobby developer, where my favorite subject is game development. "
                "I'm the creator and maintainer of "
                Link("OpenGS", target: "https://github.com/Thomas-Holtvedt/opengs")
                " (Open Grand Strategy), and its sister-project "
                Link(
                    "OpenGS - Map Tool", target: "https://github.com/Thomas-Holtvedt/opengs-maptool"
                )
                ", which is an initiative to create a free and open sourced framework and tool-set for creating Grand Strategy Games. "
                "In addition, I am a partnered YouTuber under the "
                Link("Good Solution Interactive", target: "https://www.youtube.com/@GSInteractive")
                " brand, where I post about coding and game development."
            },
            InlineGroup {
                "As a tech enthusiast I believe the best way to learn something (whether it is AI, a new language, or a framework)"
                " is to build with it, preferably in anger, until it finally clicks. "
                "I am also an avid reader and a lifelong learner who keeps a wide set of interests on purpose. "
                "This site is where I will publish projects, post updates, and share my thinking on tech, AI, programming, business, and whatever else has my attention that week."
            },
            InlineGroup {
                "Underneath all of it, I'm a husband and a dog owner. The long hours and focus I put into consulting, code, and content only work because of who I come home to."
            },
        ]
    )
}
