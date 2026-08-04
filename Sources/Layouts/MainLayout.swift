import Foundation
import Ignite

struct MainLayout: Layout {
    var body: some Document {
        PlainDocument {
            Head {
                MetaStyle(".navbar .nav-link", style: WhiteNavLinks())
                MetaStyle(".navbar > .container", style: BottomAlignedNavItems())
                MetaStyle(".equal-height > .col", style: StretchedGridItems()).important()
                MetaStyle(".card-body", style: FlexColumnCardBody())
                MetaStyle(".carousel-item", style: FixedCarouselHeight())
            }
            Body {
                NavBar().padding(.bottom, NavBar.navBarHeight)
                content
                IgniteFooter()
            }
        }
    }
}
