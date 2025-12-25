import SwiftUI

struct DetailsView: View {
    @State var event: Event
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = ViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image("leftArrow")
                    }
                    Spacer()
                    Text("Event Details")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color("AppBlack"))
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                
                DetailsHeader(
                    imageUrl: event.imageUrl,
                    eventTypeId: event.eventTypeId ?? 0,
                    title: event.title
                )
                
                DetailsHeaderLower(event: event)
                    .padding(.horizontal, 16)

                Divider()
                
                VStack(spacing: 8) {
                    Button(action: {
                        Task {
                            await viewModel.handleRegistration(for: event)
                            await refreshEvent()
                        }
                    }) {
                        HStack(spacing: 8) {
                            if viewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            }
                            Text(viewModel.buttonText(for: event))
                                .font(.system(size: 13, weight: .medium))
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(viewModel.buttonColor(for: event))
                        .cornerRadius(6)
                    }
                    .disabled(viewModel.isLoading)
                    
                    Text("Registration closes on \(Formatters.shared.formatStartDateMonth(for: event)) at \(event.startDateTime)")
                        .foregroundStyle(Color("AppGray"))
                        .font(.system(size: 12))
                }
                .padding(.horizontal, 16)
                
                Divider()
                
                if let description = event.description {
                    DetailsAbout(description: description)
                        .padding(.horizontal, 16)
                }
                
                Divider()
                
                if let agenda = event.agenda, !agenda.isEmpty {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Agenda")
                            .font(.system(size: 20))
                            .foregroundStyle(Color("AppBlack"))
                        
                        DetailsAgenda(agenda: agenda)
                    }
                    .padding(.horizontal, 16)
                    
                    Divider()
                }
                
                if let speakers = event.speakers, !speakers.isEmpty {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Featured Speakers")
                            .font(.system(size: 20))
                            .foregroundStyle(Color("AppBlack"))
                        
                        ForEach(speakers) { speaker in
                            DetailsSpeaker(speaker: speaker)
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    Divider()
                }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .task {
            await viewModel.loadRegistrationStatus(for: event)
        }
    }
    
    private func refreshEvent() async {
        do {
            let response: EventsResponse = try await NetworkManager.shared.getData(
                from: "/Events",
                queryParams: ["pageSize": "100"]
            )
            
            if let updatedEvent = response.items.first(where: { $0.id == event.id }) {
                event = updatedEvent
            }
        } catch {
            print("Could not refresh event: \(error)")
        }
    }
}

#Preview {
    MainTabView()
}
