import Foundation

enum EventType: String, Codable, CaseIterable {
    case concert = "Concert"
    case sportingEvent = "Sporting Event"
}

struct Event: Identifiable, Codable {
    var id = UUID()
    var title: String
    var type: EventType
    var date: Date
    var venue: String
    var performers: String  // Artists/bands or teams
    var ticketPrice: String
    var notes: String
    
    static var sampleEvents: [Event] {
        [
            Event(
                title: "Taylor Swift: The Eras Tour",
                type: .concert,
                date: Date().addingTimeInterval(1209600), // 2 weeks in the future
                venue: "Madison Square Garden, New York",
                performers: "Taylor Swift",
                ticketPrice: "$99 - $399",
                notes: "Runtime approximately 3.5 hours"
            ),
            Event(
                title: "NBA Finals: Game 3",
                type: .sportingEvent,
                date: Date().addingTimeInterval(864000), // 10 days in the future
                venue: "TD Garden, Boston",
                performers: "Boston Celtics vs. Denver Nuggets",
                ticketPrice: "$150 - $2500",
                notes: "Doors open 2 hours before tipoff"
            ),
            Event(
                title: "Coldplay: Music of the Spheres",
                type: .concert,
                date: Date().addingTimeInterval(1728000), // 20 days in the future
                venue: "SoFi Stadium, Los Angeles",
                performers: "Coldplay",
                ticketPrice: "$75 - $350",
                notes: "Special guest: H.E.R."
            ),
            Event(
                title: "MLB: Yankees vs. Red Sox",
                type: .sportingEvent,
                date: Date().addingTimeInterval(432000), // 5 days in the future
                venue: "Yankee Stadium, New York",
                performers: "New York Yankees vs. Boston Red Sox",
                ticketPrice: "$40 - $200",
                notes: "Rivalry game - expect heavy traffic"
            )
        ]
    }
}
