import SwiftUI

class UIConstantsViewModel: ObservableObject {
    
    // Screen Width & Height
    @Published var sW = UIScreen.main.bounds.size.width
    @Published var sH = UIScreen.main.bounds.size.height
    
    // Portrait / Landscape
    @Published var portraitOrientation: Bool = false
}

