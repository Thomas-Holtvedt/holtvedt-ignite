import Ignite

struct ContactMethod: HTML {
    let header: String
    let email: String
    let description: String

    var body: some HTML {
        Text(header).font(.title4)
        Text(Link(email, target: "mailto:\(email)"))
        Text(description)
    }
}

extension ContactMethod {
    static let pwc = ContactMethod(
        header: "Microsoft Platform and Consulting",
        email: "thomas.holtvedt@pwc.com",
        description: """
            My own area of expertise is Dynamics 365 Finance, but the PwC team \
            around me delivers end-to-end on the full Microsoft platform, with \
            specialists across finance, CE, AI, Supply Chain and BI. If your \
            organization has a project or needs assistance in that space, reach \
            out here and I'll route you to the right people. It doesn't have to \
            be Finance or Dynamics.
            """
    )

    static let personal = ContactMethod(
        header: "Personal and everything else",
        email: "thomas.holtvedt@gmail.com",
        description: """
            For contact regarding the Open Grand Strategy project, \
            collaborations, contributions, invitations or anything else.
            """
    )
}
