import SwiftUI

struct EditEventView: View {
    let event: Event
    @Binding var events: [Event]
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String
    @State private var type: EventType
    @State private var date: Date
    @State private var venue: String
    @State private var performers: String
    @State private var ticketPrice: String
    @State private var notes: String
    
    init(event: Event, events: Binding<[Event]>) {
        self.event = event
        self._events = events
        
        _title = State(initialValue: event.title)
        _type = State(initialValue: event.type)
        _date = State(initialValue: event.date)
        _venue = State(initialValue: event.venue)
        _performers = State(initialValue: event.performers)
        _ticketPrice = State(initialValue: event.ticketPrice)
        _notes = State(initialValue: event.notes)
    }
    
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
            .navigationTitle("Edit Event")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let index = events.firstIndex(where: { $0.id == event.id }) {
                            var updatedEvent = event
                            updatedEvent.title = title
                            updatedEvent.type = type
                            updatedEvent.date = date
                            updatedEvent.venue = venue
                            updatedEvent.performers = performers
                            updatedEvent.ticketPrice = ticketPrice
                            updatedEvent.notes = notes
                            
                            events[index] = updatedEvent
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(title.isEmpty || venue.isEmpty || performers.isEmpty)
                }
            }
        }
    }
}

