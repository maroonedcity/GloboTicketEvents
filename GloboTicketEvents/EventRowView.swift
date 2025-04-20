import SwiftUI

struct EventRowView: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                // Event type badge
                Text(event.type.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(
                        event.type == .concert ? Color.purple.opacity(0.2) : Color.green.opacity(0.2)
                    )
                    .foregroundColor(event.type == .concert ? .purple : .green)
                    .cornerRadius(4)
                
                Spacer()
                
                // Date display
                Text(formattedDate(event.date))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Text(event.title)
                .font(.headline)
                .lineLimit(1)
            
            Text(event.performers)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1)
            
            HStack {
                Image(systemName: "mappin.circle")
                    .foregroundColor(.secondary)
                Text(event.venue)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            
            Text(event.ticketPrice)
                .font(.caption)
                .foregroundColor(.blue)
        }
        .padding(.vertical, 4)
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy • h:mm a"
        return formatter.string(from: date)
    }
}

