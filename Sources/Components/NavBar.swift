import Ignite

struct NavBar: HTML {
    private let headerPhoto = "/images/photo-barcode-night.jpg"
    var body: some HTML {

        NavigationBar(logo: "Thomas Holtvedt") {

            Link("About", target: "#about")
            Link("Projects", target: "#projects")
            Link("Blog", target: "#blog")
            Link("LinkedIn", target: "https://www.linkedin.com/in/thomas-holtvedt/")
            Link("GitHub", target: "https://github.com/Thomas-Holtvedt/")
            Link("YouTube", target: "https://www.youtube.com/@GSInteractive")
        }
        .background(image: headerPhoto, contentMode: .fill)
        .position(.fixedTop)
    }
}
