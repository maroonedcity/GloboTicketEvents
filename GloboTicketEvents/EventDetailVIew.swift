import SwiftUI

struct EventDetailView: View {
    let event: Event
    @Binding var events: [Event]
    @State private var showingEditView = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header section with event type badge
                HStack {
                    Text(event.type.rawValue)
                        .font(.headline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            event.type == .concert ? Color.purple.opacity(0.2) : Color.green.opacity(0.2)
                        )
                        .foregroundColor(event.type == .concert ? .purple : .green)
                        .cornerRadius(8)
                    
                    Spacer()
                    
                    // Date and time
                    VStack(alignment: .trailing) {
                        Text(formattedDate(event.date))
                            .font(.subheadline)
                        Text(formattedTime(event.date))
                            .font(.headline)
                    }
                }
                
                // Title and performers
                VStack(alignment: .leading, spacing: 8) {
                    Text(event.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(event.performers)
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // Venue info
                VStack(alignment: .leading, spacing: 4) {
                    Text("Venue")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Image(systemName: "mappin.circle")
                            .foregroundColor(.red)
                        Text(event.venue)
                            .font(.body)
                    }
                }
                
                // Ticket info
                VStack(alignment: .leading, spacing: 4) {
                    Text("Ticket Price")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Image(systemName: "ticket")
                            .foregroundColor(.blue)
                        Text(event.ticketPrice)
                            .font(.body)
                    }
                }
                
                // Notes section
                if !event.notes.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Additional Information")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text(event.notes)
                            .font(.body)
                            .padding(.top, 2)
                    }
                }
                
                // Add to calendar button
                Button(action: {
                    addToCalendar()
                }) {
                    HStack {
                        Image(systemName: "calendar.badge.plus")
                        Text("Add to Calendar")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    showingEditView = true
                }
            }
        }
        .sheet(isPresented: $showingEditView) {
            EditEventView(event: event, events: $events)
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter.string(from: date)
    }
    
    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
    
    func addToCalendar() {
        // In a real app, this would use EventKit to add to the user's calendar
        print("Adding event to calendar: \(event.title)")
    }
}

