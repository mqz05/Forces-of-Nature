//
//  File.swift
//  Forces of Nature
//
//  Created by Mu qi Zhang on 15/4/22.
//

import SwiftUI

struct Card: Identifiable {
    var id = UUID().uuidString
    
    var imageName: String
    var description: String
    var type: CardTypes
    
    var firstChoiceText: String
    var secondChoiceText: String
    
    var firstChoiceStatistics: StatisticsPoints
    var secondChoiceStatistics: StatisticsPoints
    
    var firstChoiceDependentCard: DependentCard
    var secondChoiceDependentCard: DependentCard
}

class StatisticsPoints {
    var society: Double
    var energyTechnology: Double
    var economy: Double
    var ecology: Double
    
    init(society: Double, energyTechnology: Double, economy: Double, ecology: Double) {
        self.society = society
        self.energyTechnology = energyTechnology
        self.economy = economy
        self.ecology = ecology
    }
}

class DependentCard {
    var hasDependentCard: Bool
    var cardIndex: Int
    var cardOffset: Int
    
    init(_ hasDependentCard: Bool, index: Int?, offset: Int?) {
        self.hasDependentCard = hasDependentCard
        self.cardIndex = index ?? 0
        self.cardOffset = offset ?? 0
    }
}

class PlayedCard {
    var title: String
    var type: CardTypes
    var playedPosition: Int
    
    init(_ title: String, type: CardTypes, position: Int) {
        self.title = title
        self.type = type
        self.playedPosition = position
    }
}

enum CardTypes {
    case initial, independent, dependent, recurrent, final
}

let FirstGameCard: Card = Card(imageName: "Mysterious Uranium Card", description: "It seems that a new mysterious unknown material has been found. Should we investigate it?", type: .independent, firstChoiceText: "No, it seems dangerous", secondChoiceText: "Yes, of course!", firstChoiceStatistics: StatisticsPoints(society: 0, energyTechnology: -9, economy: 0, ecology: 3), secondChoiceStatistics: StatisticsPoints(society: -2, energyTechnology: 12, economy: 0, ecology: -3), firstChoiceDependentCard: DependentCard(false, index: nil, offset: nil), secondChoiceDependentCard: DependentCard(true, index: 0, offset: 0))

var IndependentCards: [Card] = [
    
    Card(imageName: "Aerogenerators and Solar Panels Card", description: "Lately the use of solar panels and wind turbines has been booming. Should we build more of them?", type: .independent, firstChoiceText: "Not right now", secondChoiceText: "Of course", firstChoiceStatistics: StatisticsPoints(society: 0, energyTechnology: -8, economy: 0, ecology: 0), secondChoiceStatistics: StatisticsPoints(society: 0, energyTechnology: 8, economy: -4, ecology: 5), firstChoiceDependentCard: DependentCard(false, index: nil, offset: nil), secondChoiceDependentCard: DependentCard(true, index: 1, offset: 1)),
    
    Card(imageName: "Millionaire Card", description: "Some millionaires have offered a big amount of money for some licenses that allows them to extract materials from one of the largest caves on earth. Do you accept the offer?", type: .independent, firstChoiceText: "Never", secondChoiceText: "Ok, but let me see the money first...", firstChoiceStatistics: StatisticsPoints(society: -5, energyTechnology: 0, economy: 0, ecology: 8), secondChoiceStatistics: StatisticsPoints(society: 0, energyTechnology: 5, economy: 8, ecology: -10), firstChoiceDependentCard: DependentCard(false, index: nil, offset: nil), secondChoiceDependentCard: DependentCard(false, index: nil, offset: nil)),
    
    Card(imageName: "Anti-Plastics Card", description: "Should we invest in new scientific projects that are looking for a new material that could replace plastics?", type: .independent, firstChoiceText: "What a waste of money", secondChoiceText: "Sure!", firstChoiceStatistics: StatisticsPoints(society: -3, energyTechnology: 0, economy: 0, ecology: 0), secondChoiceStatistics: StatisticsPoints(society: 3, energyTechnology: 3, economy: -4, ecology: 0), firstChoiceDependentCard: DependentCard(false, index: nil, offset: nil), secondChoiceDependentCard: DependentCard(true, index: 2, offset: 0)),
    
    Card(imageName: "Graduate Card", description: "Should we create a new subject based on teaching and educating children about the climate change and ecology?", type: .independent, firstChoiceText: "I don't think it's a good idea...", secondChoiceText: "Sure!", firstChoiceStatistics: StatisticsPoints(society: -4, energyTechnology: 0, economy: 0, ecology: 0), secondChoiceStatistics: StatisticsPoints(society: 10, energyTechnology: 0, economy: -8, ecology: 4), firstChoiceDependentCard: DependentCard(false, index: nil, offset: nil), secondChoiceDependentCard: DependentCard(false, index: nil, offset: nil)),
    
    Card(imageName: "Radioactive Waste Card", description: "Should we establish a new law which prohibits the excessive production of waste?", type: .independent, firstChoiceText: "That's a bad idea", secondChoiceText: "Yes, why not?", firstChoiceStatistics: StatisticsPoints(society: 2, energyTechnology: 5, economy: 0, ecology: -6), secondChoiceStatistics: StatisticsPoints(society: -8, energyTechnology: 0, economy: -4, ecology: 12), firstChoiceDependentCard: DependentCard(false, index: nil, offset: nil), secondChoiceDependentCard: DependentCard(false, index: nil, offset: nil)),
    
    Card(imageName: "Electric Car Card", description: "A new company that produces electric cars has contacted us to invest in the advertising of these cars. Shall we invest?", type: .independent, firstChoiceText: "I don't think so", secondChoiceText: "Sure! That's a great oportunity", firstChoiceStatistics: StatisticsPoints(society: -2, energyTechnology: -2, economy: 0, ecology: 0), secondChoiceStatistics: StatisticsPoints(society: 3, energyTechnology: 3, economy: -5, ecology: 3), firstChoiceDependentCard: DependentCard(false, index: nil, offset: nil), secondChoiceDependentCard: DependentCard(false, index: nil, offset: nil)),
    
    Card(imageName: "Goats Card", description: "Goats are incredible at cleaning up unwanted weeds and bushes from the fields. Should we promote the use of goats for grazing and land clearing as a substitute for insecticides and herbicides?", type: .independent, firstChoiceText: "I wouldn't trust on goats...", secondChoiceText: "Wow, sure, that sounds amazing!", firstChoiceStatistics: StatisticsPoints(society: 0, energyTechnology: 0, economy: 0, ecology: -3), secondChoiceStatistics: StatisticsPoints(society: 5, energyTechnology: 0, economy: -4, ecology: 6), firstChoiceDependentCard: DependentCard(false, index: nil, offset: nil), secondChoiceDependentCard: DependentCard(false, index: nil, offset: nil))
    
    ]


let DependentCards: [Card] = [
    
    Card(imageName: "Uranium Card", description: "It has been carefully analysed and given the name «Uranium». It's highly radioactive. It can be used to produce a large quantity of energy, although other dangerous things can also be created with it...", type: .dependent, firstChoiceText: "Next", secondChoiceText: "Next", firstChoiceStatistics: StatisticsPoints(society: 0, energyTechnology: 0, economy: 0, ecology: 0), secondChoiceStatistics: StatisticsPoints(society: 0, energyTechnology: 0, economy: 0, ecology: 0), firstChoiceDependentCard: DependentCard(false, index: nil, offset: nil), secondChoiceDependentCard: DependentCard(false, index: nil, offset: nil)),
    
    Card(imageName: "Wind and Sun Card", description: "Last year the climate was not on our side, should we increase the production of non-renewable energy to alleviate the consequences?", type: .dependent, firstChoiceText: "We can't use non-renewable energy", secondChoiceText: "Well, there's no other choice", firstChoiceStatistics: StatisticsPoints(society: 0, energyTechnology: -8, economy: 0, ecology: 10), secondChoiceStatistics: StatisticsPoints(society: -2, energyTechnology: 10, economy: 0, ecology: -8), firstChoiceDependentCard: DependentCard(false, index: nil, offset: nil), secondChoiceDependentCard: DependentCard(false, index: nil, offset: nil)),
    
    Card(imageName: "Failed Anti-Plastics Card", description: "Oh, no relevant progress has been archieved, should we keep trying?", type: .dependent, firstChoiceText: "This is a fraud", secondChoiceText: "Yes, keep on", firstChoiceStatistics: StatisticsPoints(society: -2, energyTechnology: 0, economy: 0, ecology: 0), secondChoiceStatistics: StatisticsPoints(society: 2, energyTechnology: 7, economy: -4, ecology: 10), firstChoiceDependentCard: DependentCard(false, index: nil, offset: nil), secondChoiceDependentCard: DependentCard(true, index: 3, offset: 0)),
    
    Card(imageName: "Next Card", description: "Eureka! A new revolutionary material has just been discovered and it will replace all plastic products during the next few years!", type: .dependent, firstChoiceText: "Great!", secondChoiceText: "Perfect!", firstChoiceStatistics: StatisticsPoints(society: 0, energyTechnology: 0, economy: 0, ecology: 0), secondChoiceStatistics: StatisticsPoints(society: 0, energyTechnology: 0, economy: 0, ecology: 0), firstChoiceDependentCard: DependentCard(false, index: nil, offset: nil), secondChoiceDependentCard: DependentCard(false, index: nil, offset: nil))
    
]

let RecurrentCards: [Card] = [
    
    Card(imageName: "Factory Card", description: "There had been some issues with several factories that produced traditional fuel based cars, should we repair them?", type: .recurrent, firstChoiceText: "No, we shouldn't", secondChoiceText: "Yes, we need them", firstChoiceStatistics: StatisticsPoints(society: 0, energyTechnology: -2, economy: -6, ecology: 10), secondChoiceStatistics: StatisticsPoints(society: 2, energyTechnology: 0, economy: 6, ecology: -8), firstChoiceDependentCard: DependentCard(false, index: nil, offset: nil), secondChoiceDependentCard: DependentCard(false, index: nil, offset: nil)),
    
    Card(imageName: "NGO Card", description: "A nonprofit organization is asking for more funds to increase the amount of talks given to aware people about the climate change. Should we donate more capital?", type: .recurrent, firstChoiceText: "I don't think so", secondChoiceText: "Of course, that's important!", firstChoiceStatistics: StatisticsPoints(society: -12, energyTechnology: 0, economy: 0, ecology: 0), secondChoiceStatistics: StatisticsPoints(society: 8, energyTechnology: 0, economy: -7, ecology: 4), firstChoiceDependentCard: DependentCard(false, index: nil, offset: nil), secondChoiceDependentCard: DependentCard(false, index: nil, offset: nil)),
    
    Card(imageName: "Forest Card", description: "A private company is offering a significant amount of money for licenses that grants them the right to cut down trees and extract the wood from a nearby forest for factories. Do we accept the money?", type: .recurrent, firstChoiceText: "No, they can't have the forest", secondChoiceText: "Hmmm... Fine", firstChoiceStatistics: StatisticsPoints(society: -3, energyTechnology: -3, economy: 0, ecology: 7), secondChoiceStatistics: StatisticsPoints(society: 0, energyTechnology: 3, economy: 5, ecology: -8), firstChoiceDependentCard: DependentCard(false, index: nil, offset: nil), secondChoiceDependentCard: DependentCard(false, index: nil, offset: nil)),
    
    Card(imageName: "Smartphone Card", description: "Smartphones are currently in great demand. Should we increase the production of these latest generation phones?", type: .recurrent, firstChoiceText: "No, the current production is enough", secondChoiceText: "Yes, the more the better", firstChoiceStatistics: StatisticsPoints(society: -4, energyTechnology: -2, economy: 0, ecology: 6), secondChoiceStatistics: StatisticsPoints(society: 4, energyTechnology: 2, economy: 8, ecology: -12), firstChoiceDependentCard: DependentCard(false, index: nil, offset: nil), secondChoiceDependentCard: DependentCard(false, index: nil, offset: nil))
]
