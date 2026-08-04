import Ignite

struct ProjectCard: HTML {
    struct Destination {
        let callToAction: String
        let url: String
    }

    let logo: String
    let name: String
    let summary: String
    let paragraphs: [String]
    let images: [String]
    let destination: Destination?

    var body: some HTML {
        Card {

            Image(decorative: "/images/\(logo)").frame(height: .px(80)).class("d-block", "mx-auto")
            if let destination {
                Text(Link(name, target: destination.url)).font(.title4)
            } else {
                Text(name).font(.title4)
            }
            Text(summary)
            for paragraph: String in paragraphs {
                Text(paragraph)
            }
            Section {
                
                if !images.isEmpty {
                    Carousel {
                        for image: String in images {
                            Slide(background: "/images/" + image)
                        }
                    }
                }
                if let destination {
                    Link(destination.callToAction, target: destination.url)
                }
            }.class("mt-auto")
        }
        .style(.height, "100%");
    }
}

extension ProjectCard {
    static let datafunn = ProjectCard(
        logo: "logo-datafunn.svg",
        name: "Datafunn",
        summary: "Co-founder. Data company.",
        paragraphs: [
            """
            A company I co-founded. Public data is for everyone, but at Datafunn \
            we make it easy to actually understand. We were finalists at Alna \
            Gründerhub in December 2024.
            """,
            """
            Panel, our latest product, gives you industry-leading visualization \
            and analysis, built to deliver insight without complexity. Eiendom, \
            our dashboard for the Norwegian housing market, runs on the same \
            foundation.
            """,
        ],
        images: ["datafunn1.jpg", "datafunn2.jpg"],
        destination: .init(callToAction: "Visit Datafunn →", url: "https://datafunn.no/")
    )

    static let panel = ProjectCard(
        logo: "logo-panel.svg",
        name: "Panel",
        summary: "A product by Datafunn. Configurable dashboards.",
        paragraphs: [
            """
            I built Panel full-stack. The pipeline handles automated data \
            ingestion and normalization, and feeds a dynamic front-end that turns \
            the result into visualizations. The main feature is a user-configurable \
            dashboard: people shape their own views around the specific questions \
            they need to answer.
            """,
            """
            Whether you work in policy, investment, planning, or you're just \
            curious, Panel lets you see the patterns, trends, and opportunities \
            straight from the source.
            """,
        ],
        images: ["panel1.jpg", "panel2.jpg"],
        destination: .init(callToAction: "Try Panel →", url: "https://panel.datafunn.no/")
    )

    static let goodSolutionInteractive = ProjectCard(
        logo: "logo-gsi.png",
        name: "Good Solution Interactive",
        summary: "Partnered YouTube channel. Coding and game dev.",
        paragraphs: [
            """
            My YouTube brand, where I publish content on coding and game \
            development, including ongoing build logs for the OpenGS framework.
            """
        ],
        images: ["gsi1.jpg", "gsi2.jpg"],
        destination: .init(
            callToAction: "Subscribe on YouTube →",
            url: "https://www.youtube.com/@GSInteractive"
        )
    )

    static let openGS = ProjectCard(
        logo: "logo-opengs.png",
        name: "OpenGS",
        summary: "Open-source Grand Strategy framework. Godot.",
        paragraphs: [
            """
            An open-source framework for building Grand Strategy Games in the \
            Godot engine. I founded the project and maintain it, along with the \
            roadmap and documentation that ties it to the companion Map Tool. The \
            work focuses on the technical and data-handling problems specific to \
            the genre: economy, diplomacy, and province-based logic. Built in \
            GDScript and C#.
            """
        ],
        images: ["opengs1.jpg", "opengs2.jpg", "opengs3.jpg"],
        destination: .init(
            callToAction: "Star on GitHub →",
            url: "https://github.com/Thomas-Holtvedt/opengs"
        )
    )

    static let openGSMapTool = ProjectCard(
        logo: "logo-opengs-maptool.png",
        name: "OpenGS Map Tool",
        summary: "Companion to OpenGS. World-builder utility.",
        paragraphs: [
            """
            A Python utility that automates game-world creation for OpenGS. It \
            takes visual cartographic data and converts it into the structured \
            game definitions (JSON/CSV) that OpenGS can consume.
            """
        ],
        images: [
            "maptool1.jpg", "maptool2.jpg", "maptool3.jpg",
            "maptool4.jpg", "maptool5.jpg", "maptool6.jpg",
        ],
        destination: .init(
            callToAction: "View on GitHub →",
            url: "https://github.com/Thomas-Holtvedt/opengs-maptool"
        )
    )

    static let undisclosed = ProjectCard(
        logo: "logo-un-emblem.svg",
        name: "Undisclosed Project",
        summary: "Grand strategy game. Built on the OpenGS stack.",
        paragraphs: [
            """
            A grand strategy game in early development, built on top of the OpenGS \
            technology stack. The work is being carried out by an international team \
            of enthusiasts. More details will be shared as the project matures.
            """
        ],
        images: [],
        destination: nil
    )
}
