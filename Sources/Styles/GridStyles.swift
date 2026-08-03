import Foundation
import Ignite

/// Makes grid columns stretch to the height of the tallest item in the row.
///
/// `Grid` always stamps one of Bootstrap's `align-self-*` utilities onto every
/// column, and those carry `!important`, so the columns hug their content and
/// cards can never match heights. Opt a grid in with `.class("equal-height")`.
struct StretchedGridItems: Style {
    func style(content: StyledHTML, environment: EnvironmentConditions) -> StyledHTML {
        content.style(.alignSelf, "stretch")
    }
}
