import SwiftUI
import Kingfisher

struct Membership: Identifiable, Codable {
    var id = UUID()
    var name: String
    var validity: String
    var details: String
    var logo: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case validity
        case details
        case logo
    }
}

struct MembershipView: View {
    @StateObject private var viewModel = MembershipViewModel()
    @State private var settingsDetent = PresentationDetent.medium
    @State private var memberSelected: Membership? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                // Main content
                List(viewModel.memberList) { member in
                    Button {
                        memberSelected = member
                    } label: {
                        HStack {
                            KFImage(URL(string: member.logo))
                                .resizable()
                                .placeholder {
                                    Image(systemName: "SPEA")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: .infinity)
                                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                                }
                                .onSuccess { result in
                                    print("Image loaded successfully: \(result.cacheType)")
                                }
                                .onFailure { error in
                                    print("Failed to load image: \(error.localizedDescription)")
                                }
                                .cacheMemoryOnly(false)
                                .fade(duration: 0.5)
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                        }
                    }
                }
                .opacity(viewModel.isLoading ? 0 : 1) // Hide list while loading

                // Loading view
                if viewModel.isLoading {
                    VStack {
                        SmallAnimatedLoadingView()
                    }
                }
            }
            .navigationTitle("Your Membership")
            .sheet(item: $memberSelected) { member in
                VStack(alignment: .leading) {
                    Spacer()
                    Text(member.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    Divider()
                    Text(member.validity)
                        .padding()
                    Text(member.details)
                        .padding()
                    Spacer()
                }
                .presentationDetents(
                    [.medium, .large],
                    selection: $settingsDetent
                )
            }
        }
    }
}

#Preview {
    MembershipView()
}
