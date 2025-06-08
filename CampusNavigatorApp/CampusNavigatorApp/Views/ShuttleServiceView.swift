import SwiftUI
import AVKit

struct ShuttleServiceView: View {
    let updates = [
        (id: 1, route: "Courier Anna is at Lecture Hall 11 and ready to deliver items"),
        (id: 2, route: "Courier Mike heading from Lecture Hall 22 to the Main Hall")
    ]
    
    @State private var player = AVPlayer(url: Bundle.main.url(forResource: "MapVideo", withExtension: "mp4") ?? URL(string: "about:blank")!)
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
        
            Image("shape")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 500)
                .edgesIgnoringSafeArea(.top)
                .position(x: UIScreen.main.bounds.width / 2, y: 0)
            
            
            VStack(spacing: 0) {
                // Header
                HStack {
                  
                    
                    Text("Dispatch Service")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Live indicator
                    HStack(spacing: 4) {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 6, height: 6)
                        
                        Text("LIVE")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.red)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.red.opacity(0.2))
                    .cornerRadius(12)
                }
                .padding(.horizontal, 16)
                .padding(.top, 40)
                .padding(.bottom, 16)
            //    .background(Color(hexString: "34495E"))
                
                // Video player showing map
                ZStack(alignment: .bottom) {
                    VideoPlayer(player: player)
                        .onAppear {
                            player.play()
                            player.actionAtItemEnd = .none
                            
                            // Loop video
                            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                                player.seek(to: CMTime.zero)
                                player.play()
                            }
                        }
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                    
                    HStack {
                        Text("Live Dispatch Updates")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {
                            // Refresh action
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.bottom, -16)
                    .padding(.horizontal, 16)
                }
                
                // Updates list
                VStack(spacing: 12) {
                    ForEach(updates, id: \.id) { update in
                        ShuttleUpdateCardView(
                            route: update.route,
                            onRequest: {
                                print("Request for: \(update.id)")
                            },
                            onDeny: {
                                print("Deny for: \(update.id)")
                            }
                        )
                    }
                }
                .padding(.top, 32)
                .padding(.horizontal, 16)
                
                Spacer()
            }
        }
        .statusBar(hidden: true)
    }
}


// Preview provider
struct ShuttleServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ShuttleServiceView()
    }
}
