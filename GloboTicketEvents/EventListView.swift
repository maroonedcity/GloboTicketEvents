import SwiftUI

struct EventListView: View {
    @State private var events: [Event] = Event.sampleEvents
    @State private var showingAddEvent = false
    @State private var searchText = ""
    @State private var selectedEventType: EventType? = nil
    
    var filteredEvents: [Event] {
        var filtered = events
        
        // Filter by search text
        if !searchText.isEmpty {
            filtered = filtered.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.performers.localizedCaseInsensitiveContains(searchText) ||
                $0.venue.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // Filter by event type
        if let selectedType = selectedEventType {
            filtered = filtered.filter { $0.type == selectedType }
        }
        
        // Sort by date (closest first)
        return filtered.sorted { $0.date < $1.date }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Event type picker
                Picker("Event Type", selection: $selectedEventType) {
                    Text("All Events").tag(nil as EventType?)
                    ForEach(EventType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type as EventType?)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                List {
                    ForEach(filteredEvents) { event in
                        NavigationLink(destination: EventDetailView(event: event, events: $events)) {
                            EventRowView(event: event)
                        }
                    }
                    .onDelete(perform: deleteEvent)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddEvent = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search events, performers, venues")
            .sheet(isPresented: $showingAddEvent) {
                AddEventView(events: $events)
            }
        }
    }
    
    func deleteEvent(at offsets: IndexSet) {
        let eventsToDelete = offsets.map { filteredEvents[$0] }
        for eventToDelete in eventsToDelete {
            if let index = events.firstIndex(where: { $0.id == eventToDelete.id }) {
                events.remove(at: index)
            }
        }
    }
}

