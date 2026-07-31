import Foundation
import Ignite

struct MainLayout: Layout {
    var body: some Document {
        Body {
            NavBar().padding(.bottom, 100)
            content
            IgniteFooter()
        }
    }
}
