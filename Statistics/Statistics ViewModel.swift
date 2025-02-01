import SwiftUI

class StatisticsViewModel: ObservableObject {
    @Published var ecologyPoints: Double = 50
    @Published var economyPoints: Double = 50
    @Published var energyTechnologyPoints: Double = 50
    @Published var societyPoints: Double = 50
    
    @Published var economyBooster: StatsBooster = .none
    @Published var energyTechnologyBooster: StatsBooster = .none
    @Published var societyBooster: StatsBooster = .none
    
    @Published var ecologyVariation: StatsVariation = .none
    @Published var economyVariation: StatsVariation = .none
    @Published var energyTechnologyVariation: StatsVariation = .none
    @Published var societyVariation: StatsVariation = .none
}

enum StatsBooster {
    case none, crisis, euphoria
}

enum StatsVariation {
    case none, increase, decrease
}
