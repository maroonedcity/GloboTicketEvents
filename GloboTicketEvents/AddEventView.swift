import SwiftUI

struct AddEventView: View {
    @Binding var events: [Event]
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var type: EventType = .concert
    @State private var date = Date()
    @State private var venue = ""
    @State private var performers = ""
    @State private var ticketPrice = ""
    @State private var notes = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Event Details")) {
                    TextField("Event Title", text: $title)
                    
                    Picker("Event Type", selection: $type) {
                        ForEach(EventType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    
                    DatePicker("Date & Time", selection: $date)
                }
                
                Section(header: Text("Venue & Performers")) {
                    TextField("Venue", text: $venue)
                    TextField(type == .concert ? "Artists/Bands" : "Teams", text: $performers)
                }
                
                Section(header: Text("Ticket Information")) {
                    TextField("Price Range", text: $ticketPrice)
                        .keyboardType(.default)
                }
                
                Section(header: Text("Additional Information")) {
                    TextEditor(text: $notes)
                        .frame(height: 100)
                }
            }
            .navigationTitle("Add Event")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newEvent = Event(
                            title: title,
                            type: type,
                            date: date,
                            venue: venue,
                            performers: performers,
                            ticketPrice: ticketPrice,
                            notes: notes
                        )
                        events.append(newEvent)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(title.isEmpty || venue.isEmpty || performers.isEmpty)
                }
            }
        }
    }
}
