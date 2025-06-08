import SwiftUI

struct MapScreen: View {
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    
    private let minZoom: CGFloat = 1.0
    private let maxZoom: CGFloat = 3.0
    private let zoomStep: CGFloat = 0.5
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
    
            let mapWidth = screenWidth * 2
            let mapHeight = screenHeight * 2
            
            Image("MapCot")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: mapWidth, height: mapHeight)
                .scaleEffect(scale)
                .offset(x: offset.width, y: offset.height)
                .gesture(
                
                    SimultaneousGesture(
        
                        MagnificationGesture()
                            .onChanged { value in
                                let delta = value / lastScale
                                lastScale = value
                                
                                // Limit zoom in and out
                                let newScale = scale * delta
                                scale = min(max(newScale, minZoom), maxZoom)
                            }
                            .onEnded { _ in
                                lastScale = 1.0
                            },
                        
                        
                        DragGesture()
                            .onChanged { value in
        
                                let newOffset = CGSize(
                                    width: lastOffset.width + value.translation.width,
                                    height: lastOffset.height + value.translation.height
                                )
                                
                        
                                if scale <= minZoom {
                                    // Limit horizontal movement
                                    let horizontalLimit = max(0, (mapWidth * scale - screenWidth) / 2)
                                    offset.width = max(min(newOffset.width, horizontalLimit), -horizontalLimit)
                                    
                                    // Limit vertical movement
                                    let verticalLimit = max(0, (mapHeight * scale - screenHeight) / 2)
                                    offset.height = max(min(newOffset.height, verticalLimit), -verticalLimit)
                                } else {
                                    // When zoomed in, allow free movement within bounds
                                    offset = newOffset
                                }
                            }
                            .onEnded { _ in
                                lastOffset = offset
                            }
                    )
                )
                .clipped()
        }
        .background(Color.white)
    }
}

struct MapScreen_Previews: PreviewProvider {
    static var previews: some View {
        MapScreen()
    }
}
