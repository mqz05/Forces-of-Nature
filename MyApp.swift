import SwiftUI

@main
struct MyApp: App {
    
    @StateObject var uiConstants = UIConstantsViewModel()
    @StateObject var statisticsViewModel = StatisticsViewModel()
    
    init() {
        let cfURL = Bundle.main.url(forResource: "NewBorough", withExtension: "ttf")
        
        CTFontManagerRegisterFontsForURL(cfURL! as CFURL, CTFontManagerScope.process, nil)
    }
    
    var body: some Scene {
        WindowGroup {
            GeometryReader { g in
                ZStack{
                    
                    IntroductionView()
                        .environmentObject(statisticsViewModel)
                        .environmentObject(uiConstants)
                    
                        .onChange(of: g.size, perform: { before in 
                            
                            if g.size.width > g.size.height {
                                uiConstants.portraitOrientation = false
                                uiConstants.sW = g.size.height
                                uiConstants.sH = g.size.width
                            } else {
                                uiConstants.portraitOrientation = true
                                uiConstants.sW = g.size.width
                                uiConstants.sH = g.size.height
                            }
                        })
                }
            }.ignoresSafeArea()
            .onAppear {
                if UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height {
                    uiConstants.portraitOrientation = false
                    uiConstants.sW = UIScreen.main.bounds.size.height
                    uiConstants.sH = UIScreen.main.bounds.size.width
                } else {
                    uiConstants.portraitOrientation = true
                }
            }
        }
    }
}
