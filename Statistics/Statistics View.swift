import SwiftUI

struct PortraitStatisticsView: View {
    
    @EnvironmentObject var uiConstants: UIConstantsViewModel
    @EnvironmentObject var statisticsViewModel: StatisticsViewModel
    
    @Binding var tutorialInfo: Bool
    
    var body: some View {
        VStack {
            
            HStack {
                StatisticsIcon(.society)
                
                Spacer()
                
                StatisticsIcon(.economy)
                
                Spacer()
                
                StatisticsIcon(.ecology)
                
                Spacer()
                
                StatisticsIcon(.energyTechnology)
            }.frame(width: uiConstants.sW * 0.8)
            
            tutorialInfo 
            ? HStack {
                VStack {
                    Image("Normal Arrow")
                        .rotationEffect(Angle(degrees: -90))
                    
                    Text("Society")
                        .font(.custom("NewBorough", size: 20))
                        .foregroundColor(.white)
                        .padding(.top)
                }
                
                Spacer()
                
                VStack {
                    Image("Normal Arrow")
                        .rotationEffect(Angle(degrees: -90))
                    
                    Text("Economy")
                        .font(.custom("NewBorough", size: 20))
                        .foregroundColor(.white)
                        .padding(.top)
                }
                
                Spacer()
                
                VStack {
                    Image("Normal Arrow")
                        .rotationEffect(Angle(degrees: -90))
                    
                    Text("Ecology")
                        .font(.custom("NewBorough", size: 20))
                        .foregroundColor(.white)
                        .padding(.top)
                }
                
                Spacer()
                
                VStack {
                    Image("Normal Arrow")
                        .rotationEffect(Angle(degrees: -90))
                    
                    Text("Energy/Technology")
                        .font(.custom("NewBorough", size: 20))
                        .foregroundColor(.white)
                        .padding(.top)
                }
                
            }.frame(width: uiConstants.sW * 0.8)
            : nil
            
            Spacer()
            
            tutorialInfo 
            ? Text("You will be asked questions about different issues and dilemmas. You will have to make decisions by sliding the central card to the right or left, depending on the option you choose. You always have to take into account the consequences of your decisions regarding 4 aspects: society, economy, energy and technological advances and, above all, ecology. ")
                .font(.custom("NewBorough", size: 32))
                .foregroundColor(.white)
                .lineSpacing(8)
                .padding(.horizontal)
            : nil
            
            Spacer()
            
                HStack {
                    HStack {
                        Image(statisticsViewModel.societyBooster == .euphoria ? "Euphoria Icon (Society)" : "Crisis Icon (Society)")
                            .resizable()
                            .aspectRatio(nil, contentMode: .fit)
                            .frame(width: uiConstants.sH * 0.1, height: uiConstants.sH * 0.1)
                            .opacity(statisticsViewModel.societyBooster != .none ? 0.9 : 0)
                        
                        Text(statisticsViewModel.societyBooster == .euphoria ? "+20 %" : "-20%")
                            .font(.custom("NewBorough", size: 26))
                            .foregroundColor(statisticsViewModel.societyBooster == .euphoria ? .green : .red)
                            .opacity(statisticsViewModel.societyBooster != .none ? 1 : 0)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Image(statisticsViewModel.economyBooster == .euphoria ? "Euphoria Icon (Economy)" : "Crisis Icon (Economy)")
                            .resizable()
                            .aspectRatio(nil, contentMode: .fit)
                            .frame(width: uiConstants.sH * 0.1, height: uiConstants.sH * 0.1)
                            .opacity(statisticsViewModel.economyBooster != .none ? 0.9 : 0)
                        
                        Text(statisticsViewModel.economyBooster == .euphoria ? "+20 %" : "-20%")
                            .font(.custom("NewBorough", size: 26))
                            .foregroundColor(statisticsViewModel.economyBooster == .euphoria ? .green : .red)
                            .opacity(statisticsViewModel.economyBooster != .none ? 1 : 0)
                    }
                    
                    Spacer()
                    
                    HStack {
                            Image(statisticsViewModel.energyTechnologyBooster == .euphoria ? "Euphoria Icon (Energy Technology)" : "Crisis Icon (Energy Technology)")
                                .resizable()
                                .aspectRatio(nil, contentMode: .fit)
                                .frame(width: uiConstants.sH * 0.1, height: uiConstants.sH * 0.1)
                                .opacity(statisticsViewModel.energyTechnologyBooster != .none ? 0.9 : 0)
                        
                            Text(statisticsViewModel.energyTechnologyBooster == .euphoria ? "+20 %" : "-20%")
                                .font(.custom("NewBorough", size: 26))
                                .foregroundColor(statisticsViewModel.energyTechnologyBooster == .euphoria ? .green : .red)
                                .opacity(statisticsViewModel.energyTechnologyBooster != .none ? 1 : 0)
                        }
                    
                }.frame(width: uiConstants.sW * 0.75)
            
        }
        .frame(width: uiConstants.sW, height: uiConstants.sH * 0.93)
    }
    
}

struct LandscapeStatisticsView: View {
    
    @EnvironmentObject var uiConstants: UIConstantsViewModel
    @EnvironmentObject var statisticsViewModel: StatisticsViewModel
    
    @Binding var tutorialInfo: Bool
    
    var body: some View {
        HStack {
            VStack {
                VStack {
                    Image(statisticsViewModel.societyBooster == .euphoria ? "Euphoria Icon (Society)" : "Crisis Icon (Society)")
                        .resizable()
                        .aspectRatio(nil, contentMode: .fit)
                        .frame(width: uiConstants.sW * 0.15, height: uiConstants.sW * 0.15)
                        .opacity(statisticsViewModel.societyBooster != .none ? 0.9 : 0)
                    
                    Text(statisticsViewModel.societyBooster == .euphoria ? "+20 %" : "-20%")
                        .font(.custom("NewBorough", size: 26))
                        .foregroundColor(statisticsViewModel.societyBooster == .euphoria ? .green : .red)
                        .opacity(statisticsViewModel.societyBooster != .none ? 1 : 0)
                }
                
                Spacer()
                
                VStack {
                    Image(statisticsViewModel.economyBooster == .euphoria ? "Euphoria Icon (Economy)" : "Crisis Icon (Economy)")
                        .resizable()
                        .aspectRatio(nil, contentMode: .fit)
                        .frame(width: uiConstants.sW * 0.15, height: uiConstants.sW * 0.15)
                        .opacity(statisticsViewModel.economyBooster != .none ? 0.9 : 0)
                    
                    Text(statisticsViewModel.economyBooster == .euphoria ? "+20 %" : "-20%")
                        .font(.custom("NewBorough", size: 26))
                        .foregroundColor(statisticsViewModel.economyBooster == .euphoria ? .green : .red)
                        .opacity(statisticsViewModel.economyBooster != .none ? 1 : 0)
                }
                
                Spacer()
                
                VStack {
                    Image(statisticsViewModel.energyTechnologyBooster == .euphoria ? "Euphoria Icon (Energy Technology)" : "Crisis Icon (Energy Technology)")
                        .resizable()
                        .aspectRatio(nil, contentMode: .fit)
                        .frame(width: uiConstants.sW * 0.15, height: uiConstants.sW * 0.15)
                        .opacity(statisticsViewModel.energyTechnologyBooster != .none ? 0.9 : 0)
                    
                    Text(statisticsViewModel.energyTechnologyBooster == .euphoria ? "+20 %" : "-20%")
                        .font(.custom("NewBorough", size: 26))
                        .foregroundColor(statisticsViewModel.energyTechnologyBooster == .euphoria ? .green : .red)
                        .opacity(statisticsViewModel.energyTechnologyBooster != .none ? 1 : 0)
                }
                
            }.frame(height: uiConstants.sW * 0.8)
            
            Spacer()
            
            tutorialInfo 
            ? Text("You will be asked questions about different issues and dilemmas. You will have to make decisions by sliding the central card to the right or left, depending on the option you choose. You always have to take into account the consequences of your decisions regarding 4 aspects: society, economy, energy and technological advances and, above all, ecology. ")
                .font(.custom("NewBorough", size: 32))
                .lineSpacing(8)
                .foregroundColor(.white)
            : nil
            
            Spacer()
            
            tutorialInfo 
            ? VStack {
                HStack {
                    Text("Society")
                        .font(.custom("NewBorough", size: 20))
                        .foregroundColor(.white)
                        .padding(.trailing)
                    Image("Normal Arrow")
                }
                
                Spacer()
                
                HStack {
                    Text("Economy")
                        .font(.custom("NewBorough", size: 20))
                        .foregroundColor(.white)
                        .padding(.trailing)
                    Image("Normal Arrow")
                }
                
                Spacer()
                
                HStack {
                    Text("Ecology")
                        .font(.custom("NewBorough", size: 20))
                        .foregroundColor(.white)
                        .padding(.trailing)
                    Image("Normal Arrow")
                }
                
                Spacer()
                
                HStack {
                    Text("Energy/Technology")
                        .font(.custom("NewBorough", size: 20))
                        .foregroundColor(.white)
                        .padding(.trailing)
                    Image("Normal Arrow")
                }
                
            }.frame(height: uiConstants.sW * 0.9)
            : nil
            
            VStack {
                StatisticsIcon(.society)
                
                Spacer()
                
                StatisticsIcon(.economy)
                
                Spacer()
                
                StatisticsIcon(.ecology)
                
                Spacer()
                
                StatisticsIcon(.energyTechnology)
            }.frame(height: uiConstants.sW * 0.9)
        }.frame(width: uiConstants.sH * 0.9)
    }
    
}

struct StatisticsIcon: View {
    
    @EnvironmentObject var uiConstants: UIConstantsViewModel
    @EnvironmentObject var statisticsViewModel: StatisticsViewModel
    
    var stat: Stat
    
    enum Stat: CaseIterable {
        case ecology
        case economy
        case energyTechnology
        case society
        
        var iconName: String {
            switch self {
            case .ecology: return "Ecology Icon"
            case .economy: return "Economy Icon"
            case .energyTechnology: return "Energy and Technology Icon"
            case .society: return "Society Icon"
            }
        }
    }
    
    init(_ stat: Stat) {
        self.stat = stat
    }
    
    var body: some View {
        ZStack {
            //Icono
            Image("\(stat.iconName)")
                .resizable()
                .frame(width: uiConstants.sW * 0.15, height: uiConstants.sW * 0.15)
                .background(
                    ZStack {
                        // Fondos de color
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: (uiConstants.sW * 0.15) - 2, height: getHeight())
                            .foregroundColor(.gray)
                        
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: (uiConstants.sW * 0.15) - 3, height: getHeight())
                            .foregroundColor(getBackgroundColor())
                            .opacity(getOpacity())
                        
                    }.offset(y: -1)
                    , alignment: .bottom
                )
                .overlay(ZStack {
                    // Variation Arrows
                    if getVariation() != .none {
                        Image(getVariation() == .decrease ? "Decrease Arrow" : "Increase Arrow")
                            .resizable()
                            .transition(.asymmetric(insertion: AnyTransition.opacity.animation(.easeIn(duration: 0.5)).combined(with: AnyTransition.move(edge: getVariation() == .decrease ? .top : .bottom)), removal: AnyTransition.opacity.animation(.easeOut(duration: 0.5))))
                            .scaleEffect(0.5)
                            .opacity(0.8)
                            .offset(y: getVariation() == .decrease ? 35 : -35)
                    }
                })
        }.background(
            RoundedRectangle(cornerRadius: 20)
                .frame(width: (uiConstants.sW * 0.15) - 6, height: (uiConstants.sW * 0.15) - 6, alignment: .center)
                .foregroundColor(Color.white.opacity(0.9))
            , alignment: .center
        )
    }
    
    func getVariation() -> StatsVariation {
        if stat == .ecology {
            return statisticsViewModel.ecologyVariation
        } else if stat == .economy {
            return statisticsViewModel.economyVariation
        } else if stat == .society {
            return statisticsViewModel.societyVariation
        } else {
            return statisticsViewModel.energyTechnologyVariation
        }
    }
    
    func getPoints() -> Double {
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
    
    func getHeight() -> CGFloat {
        return (CGFloat(getPoints()) * (uiConstants.sW * 0.15)) / 100
    }
    
    func getBackgroundColor() -> Color {
        
        if getPoints() > 50 {
            return Color.green
        } else if getPoints() < 50 {
            return Color.red
        } else {
            return Color.clear
        }
    }
    
    func getOpacity() -> CGFloat {
        return (abs(CGFloat(getPoints()) - 50) * 0.75) / 50
    }
}
