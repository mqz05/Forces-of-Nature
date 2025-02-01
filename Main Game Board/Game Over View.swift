import SwiftUI

struct GameOverView: View {
    
    @EnvironmentObject var uiConstants: UIConstantsViewModel
    @EnvironmentObject var statisticsViewModel: StatisticsViewModel
    
    enum StatType {
        case society, economy, energyTechnology, ecology
    }
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.black)
            
            VStack {
                Text("GAME OVER")
                    .foregroundColor(.white)
                    .font(.custom("NewBorough", size: 56, relativeTo: .largeTitle))
                    
                
                Spacer()
                
                HStack {
                    GameStats
                    
                    Spacer()
                }.padding()
                
            }.frame(width: uiConstants.portraitOrientation ? uiConstants.sW * 0.85 : uiConstants.sH * 0.75, height: uiConstants.portraitOrientation ? uiConstants.sH * 0.68 : uiConstants.sW * 0.8)
            
            
        }.frame(width: uiConstants.portraitOrientation ? uiConstants.sW * 0.9 : uiConstants.sH * 0.8, height: uiConstants.portraitOrientation ? uiConstants.sH * 0.75 : uiConstants.sW * 0.9)
    }
    
    var GameStats: some View {
        VStack(alignment: .leading) {
            
            // Ecology Stats
            HStack {
                Image("Ecology Icon")
                    .resizable()
                    .frame(width: uiConstants.sW * 0.15, height: uiConstants.sW * 0.15)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: (uiConstants.sW * 0.15) - 6, height: (uiConstants.sW * 0.15) - 6, alignment: .center)
                                .foregroundColor(Color.white.opacity(0.9))
                            
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: (uiConstants.sW * 0.15) - 6, height: (uiConstants.sW * 0.15) - 6, alignment: .center)
                                .foregroundColor(getBackgroundColor(stat: .ecology))
                                .opacity(getOpacity(stat: .ecology))
                        }
                        , alignment: .center
                    )
                
                VStack(alignment: .leading) {
                    ProgressBar(stat: .ecology, large: false)
                    
                    Text(String(format: "%.2f", statisticsViewModel.ecologyPoints) + " / 100")
                        .foregroundColor(.white)
                        .font(.custom("NewBorough", size: 20))
                        .padding(.top)
                    
                }.padding(.leading)
            }
            .frame(alignment: .topLeading)
            .scaleEffect(1.25, anchor: .leading)
            .padding(.top)
            
            
            // Society Stats
            HStack {
                VStack(alignment: .trailing) {
                    ProgressBar(stat: .society, large: true)
                    
                    Text(String(format: "%.2f", statisticsViewModel.societyPoints) + " / 100")
                        .foregroundColor(.white)
                        .font(.custom("NewBorough", size: 20))
                        .padding(.top)
                    
                }.padding(.trailing)
                
                Image("Society Icon")
                    .resizable()
                    .frame(width: uiConstants.sW * 0.15, height: uiConstants.sW * 0.15)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: (uiConstants.sW * 0.15) - 6, height: (uiConstants.sW * 0.15) - 6, alignment: .center)
                                .foregroundColor(Color.white.opacity(0.9))
                            
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: (uiConstants.sW * 0.15) - 6, height: (uiConstants.sW * 0.15) - 6, alignment: .center)
                                .foregroundColor(getBackgroundColor(stat: .society))
                                .opacity(getOpacity(stat: .society))
                        }
                        , alignment: .center
                    )
            }.frame(alignment: .topLeading)
                .padding(.top)
            
            
            // Economy Stats
            HStack {
                Image("Economy Icon")
                    .resizable()
                    .frame(width: uiConstants.sW * 0.15, height: uiConstants.sW * 0.15)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: (uiConstants.sW * 0.15) - 6, height: (uiConstants.sW * 0.15) - 6, alignment: .center)
                                .foregroundColor(Color.white.opacity(0.9))
                            
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: (uiConstants.sW * 0.15) - 6, height: (uiConstants.sW * 0.15) - 6, alignment: .center)
                                .foregroundColor(getBackgroundColor(stat: .economy))
                                .opacity(getOpacity(stat: .economy))
                        }
                        , alignment: .center
                    )
                
                VStack(alignment: .leading) {
                    ProgressBar(stat: .economy, large: true)
                    
                    Text(String(format: "%.2f", statisticsViewModel.economyPoints) + " / 100")
                        .foregroundColor(.white)
                        .font(.custom("NewBorough", size: 20))
                        .padding(.top)
                    
                }.padding(.leading)
            }.frame(alignment: .topLeading)
                .padding(.top)
            
            
            // Energy Technology Stats
            HStack {
                
                VStack(alignment: .trailing) {
                    ProgressBar(stat: .energyTechnology, large: true)
                    
                    Text(String(format: "%.2f", statisticsViewModel.energyTechnologyPoints) + " / 100")
                        .foregroundColor(.white)
                        .font(.custom("NewBorough", size: 20))
                        .padding(.top)
                    
                }.padding(.trailing)
                
                Image("Energy and Technology Icon")
                    .resizable()
                    .frame(width: uiConstants.sW * 0.15, height: uiConstants.sW * 0.15)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: (uiConstants.sW * 0.15) - 6, height: (uiConstants.sW * 0.15) - 6, alignment: .center)
                                .foregroundColor(Color.white.opacity(0.9))
                            
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: (uiConstants.sW * 0.15) - 6, height: (uiConstants.sW * 0.15) - 6, alignment: .center)
                                .foregroundColor(getBackgroundColor(stat: .energyTechnology))
                                .opacity(getOpacity(stat: .energyTechnology))
                        }
                        , alignment: .center
                    )
            }.frame(alignment: .topLeading)
                .padding(.top)
        }
    }
    
    @ViewBuilder
    func ProgressBar(stat: StatType, large: Bool) -> some View {
        
        let width = uiConstants.portraitOrientation ? uiConstants.sW * 0.595 : uiConstants.sH * 0.595
        
        ZStack {
            Capsule()
                .frame(width: large ? width : (width - 160), height: 45)
                .foregroundColor(.gray)
                .overlay(
                    LinearGradient(colors: [Color.blue, Color.indigo], startPoint: .leading, endPoint: .trailing)
                        .clipShape(Capsule())
                        .frame(width: large ? width * getProgressPercentage(stat: stat) : (width - 160) * getProgressPercentage(stat: stat))
                    , alignment: .leading
                )
        }
    }
    
    func getProgressPercentage(stat: StatType) -> Double {
        var percentage: Double = 0
        
        switch stat {
        case .economy:
            percentage = statisticsViewModel.economyPoints / 100
        case .ecology:
            percentage = statisticsViewModel.ecologyPoints / 100
        case .energyTechnology:
            percentage = statisticsViewModel.energyTechnologyPoints / 100
        case .society:
            percentage = statisticsViewModel.societyPoints / 100
        }
        
        return percentage
    }
    
    func getPoints(stat: StatType) -> Double {
        if stat == .ecology {
            return statisticsViewModel.ecologyPoints
        } else if stat == .economy {
            return statisticsViewModel.economyPoints
        } else if stat == .society {
            return statisticsViewModel.societyPoints
        } else {
            return statisticsViewModel.energyTechnologyPoints
        }
    }
    
    func getBackgroundColor(stat: StatType) -> Color {
        
        if getPoints(stat: stat) > 50 {
            return Color.green
        } else if getPoints(stat: stat) < 50 {
            return Color.red
        } else {
            return Color.clear
        }
    }
    
    func getOpacity(stat: StatType) -> CGFloat {
        return (abs(CGFloat(getPoints(stat: stat)) - 50) * 0.75) / 50
    }
}
