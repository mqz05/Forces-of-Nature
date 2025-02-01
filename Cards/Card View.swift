import SwiftUI

struct CardView: View {
    
    @EnvironmentObject var uiConstants: UIConstantsViewModel
    @EnvironmentObject var statisticsViewModel: StatisticsViewModel
    
    @Binding var cardsDeck: [Card]
    @Binding var cardsPlayed: [PlayedCard]
    
    var card: Card
    var onRemove: (() -> Void)? = nil
    
    @State private var translation: CGSize = .zero
    @State private var swipeStatus: CardChoice = .none
    @Binding var isHidden: Bool
    
    @Binding var gameOver: Bool
    
    let thresholdPercentage: CGFloat = 0.3
    @State var gesturePercentage = 0.0
    
    private enum CardChoice: Int {
        case agree, disagree, none
    }
    
    private func getGesturePercentage(from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / uiConstants.sW
    }
    
    init(cardsDeck: Binding<[Card]>, cardsPlayed: Binding<[PlayedCard]>, card: Card, isHidden: Binding<Bool>, gameOver: Binding<Bool>, onRemove: (() -> Void)?) {
        self._cardsDeck = cardsDeck
        self._cardsPlayed = cardsPlayed
        self.card = card
        
        self._isHidden = isHidden
        self._gameOver = gameOver
        
        self.onRemove = onRemove
    }
    
    var body: some View {
        ZStack {
            Image(card.imageName)
                .resizable()
                .opacity(1 - (0.2 * abs(gesturePercentage)))
                .frame(width: uiConstants.sW * 0.6, height: uiConstants.sH * 0.5, alignment: .center)
                .overlay(
                    CardChoiceText(self.swipeStatus == .agree ? card.secondChoiceText : card.firstChoiceText, translation: $translation).opacity(self.swipeStatus == .none ? 0 : 1)
                    , alignment: .top)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            card.imageName == "Next Card"
            ? Text("Next").font(.custom("NewBorough", size: 64)).foregroundColor(.white)
            : nil
        }
        
        .allowsHitTesting(!gameOver)
        .opacity(isHidden ? 0 : 1)
        .offset(x: self.translation.width, y: 0)
        .rotationEffect(.degrees(Double(self.translation.width / uiConstants.sW) * 25), anchor: .bottom)
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation(.interactiveSpring()) {
                        
                        self.translation = value.translation
                        
                        gesturePercentage = self.getGesturePercentage(from: value)
                        
                        if gesturePercentage > 0 {
                            self.swipeStatus = .agree
                        } else if gesturePercentage < 0 {
                            self.swipeStatus = .disagree
                        } else {
                            self.swipeStatus = .none
                        }
                    }
                    
                }.onEnded { value in
                    if abs(self.getGesturePercentage( from: value)) > self.thresholdPercentage {
                        
                        cardsPlayed.append(PlayedCard(card.imageName, type: card.type, position: cardsPlayed.count))
                        
                        
                        withAnimation(.easeOut(duration: 0.25)) {
                            
                            gesturePercentage = 3
                            
                            if self.swipeStatus == .disagree {
                                addStats(card.firstChoiceStatistics)
                                
                                // Add dependent cards
                                if card.firstChoiceDependentCard.hasDependentCard != false {
                                    if cardsDeck.count - 1 <= card.firstChoiceDependentCard.cardOffset {
                                        cardsDeck.append(DependentCards[card.firstChoiceDependentCard.cardIndex])
                                    } else {
                                        cardsDeck.insert(DependentCards[card.firstChoiceDependentCard.cardIndex], at: card.firstChoiceDependentCard.cardOffset)
                                    }
                                }
                                
                            } else if self.swipeStatus == .agree {
                                addStats(card.secondChoiceStatistics)
                                
                                // Add dependent cards
                                if card.secondChoiceDependentCard.hasDependentCard != false {
                                    if cardsDeck.count - 1 <= card.secondChoiceDependentCard.cardOffset {
                                        cardsDeck.append(DependentCards[card.secondChoiceDependentCard.cardIndex])
                                    } else {
                                        cardsDeck.insert(DependentCards[card.secondChoiceDependentCard.cardIndex], at: card.secondChoiceDependentCard.cardOffset)
                                    }
                                }
                            }
                        }
                        
                        if cardsDeck.count == 0 {
                            let missingRecurrentCards = getMissingRecurrentCards()
                            
                            if missingRecurrentCards.count != 0 {
                                
                                // Check if recurrent cards have appeared. If not, add them before ending game
                                cardsDeck.append(contentsOf: getMissingRecurrentCards())
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                                    onRemove?()
                                    self.translation = .zero
                                    self.swipeStatus = .none
                                    self.gesturePercentage = 0
                                })
                                
                            } else {
                                // End Game
                                withAnimation(.linear(duration: 1.25)) {
                                    gameOver = true
                                }
                                
                                self.translation = .zero
                                self.swipeStatus = .none
                                self.gesturePercentage = 0
                            }
                            
                        } else {
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                                onRemove?()
                                self.translation = .zero
                                self.swipeStatus = .none
                                self.gesturePercentage = 0
                            })
                        }
                        
                    } else {
                        withAnimation(.interactiveSpring()) {
                            self.translation = .zero
                            self.swipeStatus = .none
                            self.gesturePercentage = 0
                        }
                    }
                }
            
        )
    }
    
    func getMissingRecurrentCards() -> [Card]{
        var recurrentCardsPlayed: [String] = []
        
        // Get played Recurrent Cards
        for (_, v) in cardsPlayed.enumerated() {
            if v.type == .recurrent {
                recurrentCardsPlayed.append(v.title)
            }
        }
        
        // Delete repeated played Cards
        let uniqueRecurrentCardsPlayed = Set(recurrentCardsPlayed)
        
        // Check if all recurrent cards where played
        guard uniqueRecurrentCardsPlayed.count < 4 else {
            return []
        }
        
        // Get all existing Recurrent Cards names
        var allRecurrentCards: [String] = []
        for i in 0...(RecurrentCards.count - 1) {
            allRecurrentCards.append(RecurrentCards[i].imageName)
        }
        
        let allRecurrentCardsSet = Set<String>(allRecurrentCards)
        
        // Get missing Cards names
        let missingRecurrentCardsNames = Array(allRecurrentCardsSet.subtracting(uniqueRecurrentCardsPlayed))
        
        // Get the Cards by their name
        var missingRecurrentCards: [Card] = []
        
        for (_, v1) in RecurrentCards.enumerated() {
            for (_, v2) in missingRecurrentCardsNames.enumerated() {
                if v2 == v1.imageName {
                    missingRecurrentCards.append(v1)
                }
            }
        }
        
        return missingRecurrentCards
    }
    
    func addStats(_ stats: StatisticsPoints) {
        let addedStats = stats
        
        // Check if there are Boosters
        if statisticsViewModel.economyBooster == .euphoria {
            addedStats.economy += (abs(stats.economy)) * 0.2
        } else if statisticsViewModel.economyBooster == .crisis {
            addedStats.economy -= (abs(stats.economy)) * 0.2
        }
        
        if statisticsViewModel.societyBooster == .euphoria {
            addedStats.society += (abs(stats.society)) * 0.2
        } else if statisticsViewModel.societyBooster == .crisis{
            addedStats.society -= (abs(stats.society)) * 0.2
        }
        
        if statisticsViewModel.energyTechnologyBooster == .euphoria {
            addedStats.energyTechnology += (abs(stats.energyTechnology)) * 0.2
        } else if statisticsViewModel.energyTechnologyBooster == .crisis {
            addedStats.energyTechnology -= (abs(stats.energyTechnology)) * 0.2
        }
        
        // Variation Arrow Animation
        withAnimation(.linear(duration: 1)) {
            if stats.ecology > 0 {
                statisticsViewModel.ecologyVariation = .increase
            } else if stats.ecology < 0 {
                statisticsViewModel.ecologyVariation = .decrease
            }
            
            if stats.economy > 0 {
                statisticsViewModel.economyVariation = .increase
            } else if stats.economy < 0 {
                statisticsViewModel.economyVariation = .decrease
            }
            
            if stats.society > 0 {
                statisticsViewModel.societyVariation = .increase
            } else if stats.society < 0 {
                statisticsViewModel.societyVariation = .decrease
            }
            
            if stats.energyTechnology > 0 {
                statisticsViewModel.energyTechnologyVariation = .increase
            } else if stats.energyTechnology < 0 {
                statisticsViewModel.energyTechnologyVariation = .decrease
            }
        }
        
        // Stop Arrow Animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.85, execute: {
            statisticsViewModel.ecologyVariation = .none
            statisticsViewModel.economyVariation = .none
            statisticsViewModel.societyVariation = .none
            statisticsViewModel.energyTechnologyVariation = .none
        })
        
        
        // Add Stats
        if (statisticsViewModel.ecologyPoints + addedStats.ecology) <= 0 {
            // Game Over
            withAnimation(.linear(duration: 1.25)) {
                gameOver = true
            }
            statisticsViewModel.ecologyPoints = 0
        } else if (statisticsViewModel.ecologyPoints + addedStats.ecology) < 100 {
            
            statisticsViewModel.ecologyPoints += addedStats.ecology
            
            
        } else {
            statisticsViewModel.ecologyPoints = 100
        }
        
        if (statisticsViewModel.economyPoints + addedStats.economy) <= 0 {
            // Game Over
            withAnimation(.linear(duration: 1.25)) {
                gameOver = true
            }
            statisticsViewModel.economyPoints = 0
        } else if (statisticsViewModel.economyPoints + addedStats.economy) < 100 {
            statisticsViewModel.economyPoints += addedStats.economy
        } else {
            statisticsViewModel.economyPoints = 100
        }
        
        if (statisticsViewModel.societyPoints + addedStats.society) <= 0 {
            // Game Over
            withAnimation(.linear(duration: 1.25)) {
                gameOver = true
            }
            statisticsViewModel.societyPoints = 0
        } else if (statisticsViewModel.societyPoints + addedStats.society) < 100 {
            statisticsViewModel.societyPoints += addedStats.society
        } else {
            statisticsViewModel.societyPoints = 100
        }
        
        if (statisticsViewModel.energyTechnologyPoints + addedStats.energyTechnology) <= 0 {
            // Game Over
            withAnimation(.linear(duration: 1.25)) {
                gameOver = true
            }
            statisticsViewModel.energyTechnologyPoints = 0
        } else if (statisticsViewModel.energyTechnologyPoints + addedStats.energyTechnology) < 100 {
            statisticsViewModel.energyTechnologyPoints += addedStats.energyTechnology
        } else {
            statisticsViewModel.energyTechnologyPoints = 100
        }
    }
    
    
    struct CardChoiceText: View {
        
        @EnvironmentObject var uiConstants: UIConstantsViewModel
        
        @Binding var translation: CGSize
        
        var text: String
        
        init(_ text: String, translation: Binding<CGSize>) {
            self.text = text
            self._translation = translation
        }
        
        var body: some View {
            HStack {
                
                translation.width < 0 ? Spacer() : nil
                
                Text(text)
                    .font(.custom("NewBorough", size: 24, relativeTo: .body))
                    .padding()
                    .cornerRadius(10)
                    .foregroundColor(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 3.0)
                    ).padding(24)
                    .rotationEffect(.degrees(Double(self.translation.width / uiConstants.sW) * -25), anchor: .bottom)
                
                translation.width > 0 ? Spacer() : nil
            }
            .background(Color.white.opacity(0.15).clipShape(RoundedRectangle(cornerRadius: 20)))
        }
    }
}


struct NextCardView<Front, Back>: View where Front: View, Back: View {
    
    var front: () -> Front
    var back: () -> Back
    
    @Binding var cardRotation: Double
    @Binding var isChangingCard: Bool
    
    @State private var flipped = false
    @State private var backRotation = 0.0
    
    init(@ViewBuilder front: @escaping () -> Front , @ViewBuilder back: @escaping () -> Back, cardRotation: Binding<Double>, isChangingCard: Binding<Bool>) {
        self.front = front
        self.back = back
        
        self._cardRotation = cardRotation
        self._isChangingCard = isChangingCard
    }
    
    var body: some View {
        ZStack{
            if flipped {
                back()
            } else {
                front()
            }
        }
        .rotation3DEffect(.degrees(backRotation), axis: (x: 0, y: 1, z: 0))
        .rotation3DEffect(.degrees(cardRotation), axis: (x: 0, y: 1, z: 0))
        .onChange(of: isChangingCard, perform: { isFlipping in
            if isFlipping {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.375, execute: {
                    flipped.toggle()
                    backRotation += 180
                })
            } else {
                flipped.toggle()
            }
        })
    }
}
