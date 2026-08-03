import Foundation
import Ignite

struct WhiteNavLinks: Style {
    func style(content: StyledHTML, environment: EnvironmentConditions) -> StyledHTML {
        content.foregroundStyle(.white)
    }
}

struct BottomAlignedNavItems: Style {
    func style(content: StyledHTML, environment: EnvironmentConditions) -> StyledHTML {
        content.style(.alignItems, "baseline")
    }
}
