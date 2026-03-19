import SwiftUI

struct ConcertView: View {

    @State private var concertVM = ConcertViewModel()
    @State private var userMark: Int? = nil
    var specificConcert: Concert? = nil
    
    private var displayedConcert: Concert? {
        specificConcert ?? concertVM.randomConcert
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.8, green: 0.8, blue: 0.8)
                .ignoresSafeArea()

            if let concert = displayedConcert {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 18) {

                        if let urlString = concert.coverURL, let url = URL(string: urlString) {
                            AsyncImage(url: url) { image in
                                ZStack {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .scaleEffect(1.05)
                                    Color.black.opacity(0.35)
                                }
                            } placeholder: {
                                Color.gray.opacity(0.3)
                                    .overlay(ProgressView())
                            }
                            .frame(maxWidth: .infinity, minHeight: 340, maxHeight: 340)
                            .clipped()
                        } else {
                            Color.gray.opacity(0.3)
                                .frame(maxWidth: .infinity, minHeight: 340, maxHeight: 340)
                                .overlay(
                                    Image(systemName: "music.note")
                                        .font(.system(size: 60))
                                        .foregroundColor(.gray)
                                )
                        }

                        // Renomé pour différencier de AlbumView
                        ConcertHeaderCardView(concert: concert)

                        HStack(spacing: 12) {
                            if let mark = userMark {
                                ActionButtonView(
                                    title: "",
                                    backgroundColor: Color.orange,
                                    textColor: .black
                                ) {}
                                .overlay(
                                    HStack(spacing: 4) {
                                        ForEach(1...5, id: \.self) { index in
                                            Image(systemName: index <= mark ? "star.fill" : "star")
                                                .foregroundColor(.black)
                                                .font(.system(size: 18, weight: .bold))
                                        }
                                    }
                                )
                            } else {
                                NavigationLink {
                                    PostReviewV(concert: concert, onReviewPosted: { mark in
                                        userMark = mark
                                    })
                                } label: {
                                    Text("Ajouter un avis")
                                        .font(.system(size: 17, weight: .bold))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 52)
                                        .background(Color.orangeArt)
                                        .clipShape(Capsule())
                                        .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 4)
                                }
                            }

                            ActionButtonView(
                                title: "Partager",
                                backgroundColor: Color.black.opacity(0.8),
                                textColor: .white) {}
                        }
                        .padding(.horizontal, 24)

                        // Renomé pour différencier de AlbumView
                        ConcertReviewsCardView(concert: concert)
                    }
                    .padding(.bottom, 24)
                }
                .ignoresSafeArea(edges: .top)
            } else {
                ProgressView("Chargement d'un concert…")
            }
        }
        .task {
            if specificConcert == nil {
                do {
                    try await concertVM.fetchRandomConcert()
                } catch {
                    print("Erreur: \(error)")
                }
            }
        }
    }
}

// Renomé pour différencier de AlbumView
struct ConcertHeaderCardView: View {
    let concert: Concert
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.7))
                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 6)

            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(concert.concertTitle)
                        .font(.system(size: 28, weight: .bold))


                    Text(concert.artistName)
                        .font(.system(size: 17))
                    
                    if let year = concert.concertDate {
                        Text(year)
                            .font(.system(size: 16))
                            .foregroundColor(.black.opacity(0.65))
                            .fontWeight(.thin)
                    }

                    HStack(spacing: 6) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                        // Enlevé car "triché" avec une fausse note
                        //la note global de concert n'ex
//                        Text(String(format: "%.1f", concert.globalReview))
                        Text("4,5")
                            .font(.system(size: 18, weight: .bold))
                    }
                }

                Spacer()

                if let urlString = concert.artistPicURL, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                            .overlay(ProgressView())
                    }
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 28))
                } else {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 145, height: 145)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.gray)
                        )
                }
            }
            .padding(24)
        }
        .frame(height: 175)
        .padding(.horizontal, 24)
        .offset(y: -40)
        .padding(.bottom, -40)
    }
}
// enlevé car normalement pas besoin !!
//struct ActionButtonView: View {
//    let title: String
//    let backgroundColor: Color
//    let textColor: Color
//    let action: () -> Void
//
//    var body: some View {
//        Button(action: action) {
//            Text(title)
//                .font(.system(size: 17, weight: .bold))
//                .foregroundColor(textColor)
//                .frame(maxWidth: .infinity)
//                .frame(height: 52)
//                .background(backgroundColor)
//                .clipShape(Capsule())
//                .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 4)
//        }
//    }
//}

// Renomé pour différencier de AlbumView
struct ConcertReviewsCardView: View {
    let concert: Concert
    
    var body: some View {
        let titles = concert.reviewTitleFromTopReview ?? []
        let reviews = concert.userReviewFromTopReview ?? []
        let usernames = concert.usernameFromTopReview ?? []
        let marks = concert.markFromTopReview ?? []
        
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.72))
                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 6)

            VStack(alignment: .leading, spacing: 18) {
                HStack {
                    Spacer()
                    Text("REVIEWS")
                        .font(.system(size: 24, weight: .black))
                }

                if titles.isEmpty {
                    Text("Aucune review pour ce concert")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(0..<titles.count, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text(titles[index])
                                    .font(.system(size: 18, weight: .bold))
                                Spacer()
                                if index < usernames.count {
                                    Text(usernames[index])
                                        .font(.system(size: 14))
                                }
                            }

                            if index < marks.count {
                                HStack(spacing: 2) {
                                    ForEach(0..<Int(marks[index]), id: \.self) { _ in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.orange)
                                            .font(.system(size: 14))
                                    }
                                    ForEach(0..<(5 - Int(marks[index])), id: \.self) { _ in
                                        Image(systemName: "star")
                                            .foregroundColor(.orange)
                                            .font(.system(size: 14))
                                    }
                                }
                            }

                            if index < reviews.count {
                                Text(reviews[index])
                                    .font(.system(size: 15))
                                    .foregroundColor(.black.opacity(0.8))
                                    .lineLimit(3)
                            }

                            if index < titles.count - 1 {
                                Divider()
                            }
                        }
                    }
                }
            }
            .padding(24)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    ConcertView()
}
