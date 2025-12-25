import SwiftUI

struct DetailsView: View {
    var event: Event
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
                    eventTypeId: event.eventTypeId,
                    title: event.title
                )
                
                DetailsHeaderLower(event: event)
                    .padding(.horizontal, 16)

                Divider()
                
                VStack(spacing: 8) {
                    Button(action: { viewModel.handleRegistration(for: event) }) {
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
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Agenda")
                        .font(.system(size: 20))
                        .foregroundStyle(Color("AppBlack"))
                    
                    DetailsAgenda(agenda: event.agenda)
                }
                .padding(.horizontal, 16)
                
                if !event.speakers.isEmpty {
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Featured Speakers")
                            .font(.system(size: 20))
                            .foregroundStyle(Color("AppBlack"))
                        
                        ForEach(event.speakers) { speaker in
                            DetailsSpeaker(speaker: speaker)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainTabView()
}
