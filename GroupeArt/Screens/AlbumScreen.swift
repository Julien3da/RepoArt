import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.8, green: 0.8, blue: 0.8)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    Image("rondoudouPicture")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 320)
                        .clipShape(RoundedRectangle(cornerRadius: 80))

                    HeaderCardView()

                    HStack(spacing: 12) {
                        ActionButtonView(
                            title: "Tu as mis 4 / 5",
                            backgroundColor: Color.orange,
                            textColor: .black) {}

                        ActionButtonView(
                            title: "Partager",
                            backgroundColor: Color.black.opacity(0.8),
                            textColor: .white) {}
                    }
                    .padding(.horizontal, 24)

                    TracklistCardView {}

                    ReviewsCardView()
                }
                .padding(.bottom, 24)
            }
        }
    }
}

struct HeaderCardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.7))
                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 6)

            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Bouboule")
                        .font(.system(size: 28, weight: .bold))

                    Text("Rondoudou")
                        .font(.system(size: 17))
                        .foregroundColor(.gray)

                    HStack(spacing: 6) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                        Text("4,6")
                            .font(.system(size: 18, weight: .bold))
                    }

                    Text("Septembre 1969")
                        .font(.system(size: 16))
                        .foregroundColor(.black.opacity(0.65))
                }

                Spacer()

                Image("rondoudouCover")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 145, height: 145)
                    .clipShape(RoundedRectangle(cornerRadius: 28))
            }
            .padding(24)
        }
        .frame(height: 175)
        .padding(.horizontal, 24)
        .offset(y: -40)
        .padding(.bottom, -40)
    }
}

struct ActionButtonView: View {
    let title: String
    let backgroundColor: Color
    let textColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(backgroundColor)
                .clipShape(Capsule())
                .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 4)
        }
    }
}

struct TracklistCardView: View {
    let actionVoirAlbum: () -> Void

    let tracks: [(String, String)] = [
        ("Come Together", "4,7 / 5"),
        ("Something", "4,7 / 5"),
        ("Maxwell’s Silver Hammer", "4,7 / 5"),
        ("Oh! Darling", "4,7 / 5")
    ]

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.72))
                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 6)

            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Spacer()
                    Text("TRACKLIST")
                        .font(.system(size: 24, weight: .black))
                }

                ForEach(0..<tracks.count, id: \.self) { index in
                    HStack(alignment: .top) {
                        Text("\(index + 1)")
                            .font(.system(size: 20))
                            .frame(width: 20)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(tracks[index].0)
                                .font(.system(size: 19, weight: .bold))

                            Text("pokemon")
                                .font(.system(size: 15))
                                .foregroundColor(.orange)
                        }

                        Spacer()

                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.orange)
                            Text(tracks[index].1)
                                .font(.system(size: 17))
                            Text(">")
                                .foregroundColor(.orange)
                        }
                    }

                    if index < tracks.count - 1 {
                        Divider()
                    }
                }

                HStack {
                    Spacer()

                    ActionButtonView(
                        title: "Voir tout l’album",
                        backgroundColor: Color.orange,
                        textColor: .black,
                        action: actionVoirAlbum
                    )
                    .frame(width: 175)

                    Spacer()
                }
                .padding(.top, 8)
            }
            .padding(24)
        }
        .padding(.horizontal, 24)
    }
}

struct ReviewsCardView: View {
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

                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("Spectaculaire !")
                            .font(.system(size: 18, weight: .bold))
                        Spacer()
                        Text("Niconni")
                            .font(.system(size: 14))
                    }

                    Text("★★★★★")
                        .foregroundColor(.orange)

                    Text("printing and typesetting industry. Lorem Ipsum")
                        .font(.system(size: 15))
                        .foregroundColor(.black.opacity(0.8))

                    Divider()
                }

                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("Meilleur album all time")
                            .font(.system(size: 18, weight: .bold))
                        Spacer()
                        Text("Julien3da")
                            .font(.system(size: 14))
                    }

                    Text("★★★★★")
                        .foregroundColor(.orange)

                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.")
                        .font(.system(size: 15))
                        .foregroundColor(.black.opacity(0.8))
                        .lineLimit(3)
                }
            }
            .padding(24)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    ContentView()
}
