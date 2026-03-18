import SwiftUI

struct ConcertView: View {
    let concert: Concert
    
    // Background gradient similar to AlbumView
    private var appBackgroundGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 0.96, green: 0.92, blue: 0.85),
                Color(red: 0.90, green: 0.86, blue: 0.80),
                Color(red: 0.82, green: 0.82, blue: 0.82)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    var body: some View {
        ZStack {
            appBackgroundGradient
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {

                    // Cover concert en grand en haut
                    if let urlString = concert.coverURL, let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            ZStack {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .scaleEffect(1.05)
                                    .blur(radius: 20) // Effet flou en arrière-plan comme AlbumView
                                    .overlay(Color.black.opacity(0.3))
                                
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity, maxHeight: 340)
                                    .clipped()
                            }
                        } placeholder: {
                            appBackgroundGradient
                                .overlay(ProgressView())
                        }
                        .frame(maxWidth: .infinity, minHeight: 340, maxHeight: 340)
                        .clipped()
                    } else {
                        appBackgroundGradient
                            .frame(maxWidth: .infinity, minHeight: 340, maxHeight: 340)
                            .overlay(
                                Image(systemName: "music.mic")
                                    .font(.system(size: 60))
                                    .foregroundColor(.black.opacity(0.35))
                            )
                    }

                    ConcertHeaderCardView(concert: concert)

                    HStack(spacing: 12) {
                        Button(action: {}) {
                            Text("Ajouter un avis")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.orange)
                                .clipShape(Capsule())
                                .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 4)
                        }

                        Button(action: {}) {
                            Text("Partager")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.black.opacity(0.8))
                                .clipShape(Capsule())
                                .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 4)
                        }
                    }
                    .padding(.horizontal, 24)

                    // Section Infos Concert (Date, Lieu, Salle)
                    ConcertInfoCardView(concert: concert)
                    
                    // Reviews placeholder (car Concert model n'a pas encore de reviews)
                    ConcertReviewsCardView()
                }
                .padding(.bottom, 24)
            }
            .ignoresSafeArea(edges: .top)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ConcertHeaderCardView: View {
    let concert: Concert

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.7))
                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 6)

            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(concert.concertTitle)
                        .font(.system(size: 22, weight: .bold))
                        .lineLimit(3)
                        .minimumScaleFactor(0.75)
                        .layoutPriority(1)

                    Text(concert.artistName)
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .lineLimit(2)
                        .minimumScaleFactor(0.8)
                    
                    if let date = concert.concertDate {
                        Text(date)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.orange)
                            .padding(.top, 4)
                    }
                }

                Spacer(minLength: 0)
            }
            .padding(16)
        }
        .frame(minHeight: 120)
        .padding(.horizontal, 24)
        .offset(y: -40)
        .padding(.bottom, -40)
    }
}

struct ConcertInfoCardView: View {
    let concert: Concert
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.72))
                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 6)

            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Spacer()
                    Text("INFOS")
                        .font(.system(size: 24, weight: .black))
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    if let location = concert.concertLocation {
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.system(size: 20))
                                .foregroundColor(.orange)
                                .frame(width: 24)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Lieu")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(location)
                                    .font(.system(size: 17, weight: .medium))
                            }
                        }
                        Divider()
                    }
                    
                    if let hall = concert.concertHall {
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "building.2.crop.circle")
                                .font(.system(size: 20))
                                .foregroundColor(.orange)
                                .frame(width: 24)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Salle / Stade")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(hall)
                                    .font(.system(size: 17, weight: .medium))
                            }
                        }
                    }
                    
                    if concert.concertLocation == nil && concert.concertHall == nil {
                         Text("Aucune information supplémentaire disponible.")
                            .foregroundColor(.secondary)
                            .italic()
                    }
                }
            }
            .padding(24)
        }
        .padding(.horizontal, 24)
    }
}

struct ConcertReviewsCardView: View {
    var body: some View {
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

                Text("Aucune review pour ce concert pour le moment.")
                    .foregroundColor(.secondary)
            }
            .padding(24)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    ConcertView(concert: Concert(concertTitle: "Simulation Concert", concertDate: "12 Oct 2024", concertLocation: "Paris, France", concertHall: "Stade de France", artistNameFromArtist: ["The Artist"]))
}
