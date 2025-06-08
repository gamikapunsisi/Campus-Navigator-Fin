import SwiftUI

struct GuideScreen: View {
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6) //
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                    .frame(height: 115)
                
                ZStack {
                    Image("GuidePageImg")
                        .resizable()
                        .frame(width: 505, height: 466)
                        .opacity(0.5)
                    
                    Image("Play-Button")
                        .resizable()
                        .frame(width: 277, height: 280)
                }
                
                Spacer()
            }
        }
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideScreen()
    }
}
