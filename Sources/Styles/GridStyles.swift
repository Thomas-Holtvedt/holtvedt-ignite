import Foundation
import Ignite


struct StretchedGridItems: Style {
    func style(content: StyledHTML, environment: EnvironmentConditions) -> StyledHTML {
        content.style(.alignSelf, "stretch")
    }
}

struct FlexColumnCardBody: Style {
    func style(content: StyledHTML, environment: EnvironmentConditions) -> StyledHTML {
        content
            .style(.display, "flex")
            .style(.flexDirection, "column")
    }
}

struct FixedCarouselHeight: Style {
    func style(content: StyledHTML, environment: EnvironmentConditions) -> StyledHTML {
        content
            .style(.height, "300px")
    }
}
