import Ignite

struct NavBar: HTML {

    private let height: Int = 200
    public static let navBarHeight: Int = 200
    private let headerPhoto = "/images/photo-barcode-night.jpg"
    var body: some HTML {

        NavigationBar(
            logo: Span("Thomas Holtvedt").font(.system(size: .rem(2.8), weight: .bold))
                .letterSpacing(3).foregroundStyle(.light)
        ) {
            //Had to use complete links as "/#section", caused a bug with with postfix /
            Link("About", target: URL(static: "https://holtvedt.com/#about"))
            Link("Projects", target: URL(static: "https://holtvedt.com/#projects"))
            Link("Articles", target: URL(static: "https://holtvedt.com/#articles"))
            Link("LinkedIn", target: "https://www.linkedin.com/in/thomas-holtvedt/")
            Link("GitHub", target: "https://github.com/Thomas-Holtvedt/")
            Link("YouTube", target: "https://www.youtube.com/@GSInteractive")
        }
        .background(
            image: headerPhoto, contentMode: .fill,
            position: .position(
                vertical: .percent(35), relativeTo: .top, horizontal: .percent(0),
                relativeTo: .center)
        )
        .position(.fixedTop)
        .frame(minHeight: height)
        .style(.alignItems, "flex-end")
        .style(.boxShadow, "inset 0 0 0 100vh rgba(0, 0, 0, 0.5)")
        .font(.system(size: .rem(1.5)))
    }
}
