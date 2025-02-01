import SwiftUI

struct MainGameBoard: View {
    
    @EnvironmentObject var uiConstants: UIConstantsViewModel
    @EnvironmentObject var statisticsViewModel: StatisticsViewModel
    
    @State var cardsDeck: [Card] = []
    @State var showingCard: Card = Card(imageName: "Next Card", description: "<–––     Slide to start     –––>", type: .initial, firstChoiceText: "START", secondChoiceText: "START", firstChoiceStatistics: StatisticsPoints(society: 0, energyTechnology: 0, economy: 0, ecology: 0), secondChoiceStatistics: StatisticsPoints(society: 0, energyTechnology: 0, economy: 0, ecology: 0), firstChoiceDependentCard: DependentCard(false, index: nil, offset: nil), secondChoiceDependentCard: DependentCard(false, index: nil, offset: nil))
    
    @State var isChangingCard: Bool = false
    @State var cardRotation = 0.0
    
    @State var cardsPlayed: [PlayedCard] = []
    
    @State var crisisStage = false
    @State var hasCrisisStageAppeared = false
    @State var crisisStageProbability = 3
    
    @State var euphoriaStage = false
    @State var hasEuphoriaStageAppeared = false
    @State var euphoriaStageProbability = 3
    
    @State var showSpecialCards = false
    
    @State var gameOver: Bool = false
    
    @State var animationStage = 0
    @State var tutorialInfo = false
    @State var startGame = false
    
    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea()
            
            uiConstants.portraitOrientation
            ? // Portrait View
            AnyView(
                ZStack {
                    
                    //Stats
                    PortraitStatisticsView(tutorialInfo: $tutorialInfo)
                        .opacity(animationStage >= 3 ? 1 : 0)
                        .zIndex(3)
                    
                    VStack {
                        
                        Spacer()
                        
                        VStack {
                            
                            Spacer()
                            
                            // Title
                            Text(crisisStage 
                                 ? "That's unfortunate, an important crisis will occur and you have to choose a sacrifice card..."
                                 : euphoriaStage
                                 ? "Luck is on your side! There will be prosperity in the following years and you can choose a benefit card as a reward!"
                                 : showingCard.description)
                                .font(.custom("NewBorough", size: 32, relativeTo: .title))
                                .frame(width: uiConstants.sW * 0.9, alignment: .top)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .opacity(animationStage >= 2 ? 1 : 0)
                            
                            Spacer(minLength: 0)
                            
                            ZStack {
                                //Cards
                                CardCollection
                                    .scaleEffect(euphoriaStage ? 0.001 : crisisStage ? 0.001 : 1)
                                    .rotationEffect(euphoriaStage ? Angle(degrees: 480) : crisisStage ? Angle(degrees: 480) : Angle(degrees: 0))
                                    .allowsHitTesting(startGame ? true : false)
                                
                                // Euphoria / Crisis Cards
                                euphoriaStage 
                                ? CrisisEuphoriaCardsCollection
                                : 
                                crisisStage
                                ? CrisisEuphoriaCardsCollection
                                : nil
                            }.scaleEffect(animationStage >= 2 ? 1 : 0.001)
                            
                            Spacer(minLength: 0)
                            
                        }.frame(height: uiConstants.sH * 0.7, alignment: .center)
                        
                        Spacer()
                    }
                    .frame(height: uiConstants.sH, alignment: .top)
                        .background(
                            Image("Cards Background")
                                .resizable()
                                .frame(width: uiConstants.sW, height: uiConstants.sH * 0.7)
                                .opacity(animationStage >= 1 ? 1 : 0)
                                .overlay(
                                    crisisStage
                                    ? Color.red.opacity(0.2).transition(AnyTransition.opacity.animation(.easeIn(duration: 2.5)))
                                    : euphoriaStage
                                    ? Color.green.opacity(0.2).transition(AnyTransition.opacity.animation(.easeIn(duration: 2.5)))
                                    : nil
                                )
                            , alignment: .center
                        )
                    
                    // Tutorial View Background
                    Color.black
                        .frame(width: uiConstants.sW, height: uiConstants.sH)
                        .ignoresSafeArea()
                        .opacity(tutorialInfo ? 0.75 : 0)
                        .zIndex(2)
                    
                    tutorialInfo 
                    ? Color.gray.opacity(0.01)
                        .frame(width: uiConstants.sW, height: uiConstants.sH)
                        .ignoresSafeArea()
                        .overlay(
                            Text("Tap to continue...")
                                .foregroundColor(.white)
                                .font(.custom("NewBorough", size: 20))
                                .padding()
                            , alignment: .bottomLeading)
                        .zIndex(5)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                tutorialInfo = false
                                startGame = true
                            }
                        }
                    : nil
                    
                }.frame(width: uiConstants.sW, height: uiConstants.sH)
                    
            )
            
            : // Landscape View
            AnyView(ZStack {
                
                // Stats
                LandscapeStatisticsView(tutorialInfo: $tutorialInfo)
                    .opacity(animationStage >= 3 ? 1 : 0)
                    .zIndex(3)
                
                VStack {
                    
                    Spacer()
                    
                    // Title
                    Text(crisisStage 
                         ? "That's unfortunate, an important crisis will occur and you have to choose a sacrifice card..."
                         : euphoriaStage
                         ? "Luck is on your side! There will be prosperity in the following years and you can choose a benefit card as a reward!"
                         : showingCard.description)
                        .font(.custom("NewBorough", size: 32, relativeTo: .title))
                        .frame(width: uiConstants.sH * 0.55, alignment: .top)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .opacity(animationStage >= 2 ? 1 : 0)
                    
                    Spacer()
                    
                    ZStack {
                        //Cards
                        CardCollection
                            .scaleEffect(euphoriaStage ? 0.001 : crisisStage ? 0.001 : 1)
                            .rotationEffect(euphoriaStage ? Angle(degrees: 480) : crisisStage ? Angle(degrees: 480) : Angle(degrees: 0))
                            .allowsHitTesting(startGame ? true : false)
                        
                        // Euphoria / Crisis Cards
                        euphoriaStage 
                        ? CrisisEuphoriaCardsCollection
                        : 
                        crisisStage
                        ? CrisisEuphoriaCardsCollection
                        : nil
                    }.scaleEffect(animationStage >= 2 ? 1 : 0.001)
                    
                    Spacer(minLength: 0)
                }
                .zIndex(1)
                .background(
                    Image("Cards Background")
                        .resizable()
                        .frame(width: uiConstants.sH * 0.62, height: uiConstants.sW + 4)
                        .opacity(animationStage >= 1 ? 1 : 0)
                        .overlay(
                            crisisStage
                            ? Color.red.opacity(0.2).transition(AnyTransition.opacity.animation(.linear(duration: 2.5)))
                            : euphoriaStage
                            ? Color.green.opacity(0.2).transition(AnyTransition.opacity.animation(.linear(duration: 2.5)))
                            : nil
                        )
                )
                
                // Tutorial View Background
                Color.black
                    .frame(width: uiConstants.sH, height: uiConstants.sW)
                    .ignoresSafeArea()
                    .opacity(tutorialInfo ? 0.75 : 0)
                    .zIndex(2)
                
                tutorialInfo 
                ? Color.gray.opacity(0.01)
                    .frame(width: uiConstants.sH, height: uiConstants.sW)
                    .ignoresSafeArea()
                    .overlay(
                        Text("Tap to continue...")
                            .foregroundColor(.white)
                            .font(.custom("NewBorough", size: 20))
                            .padding()
                        , alignment: .bottomLeading)
                    .zIndex(5)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            tutorialInfo = false
                            startGame = true
                        }
                    }
                : nil
                
            }.frame(width: uiConstants.sH * 0.8, height: uiConstants.sW)
            )
            
            // Game Over Background
            Color.black
                .frame(width: uiConstants.portraitOrientation ? uiConstants.sW : uiConstants.sH, height: uiConstants.portraitOrientation ? uiConstants.sH : uiConstants.sW)
                .ignoresSafeArea()
                .opacity(gameOver ? 0.75 : 0)
                .zIndex(5)
            
            // Game Over View
            GameOverView()
                .zIndex(gameOver ? 10 : -1)
                .scaleEffect(gameOver ? 1 : 0.001)
        }
        .background(
            Image("Game Background")
                .resizable()
                .frame(width: uiConstants.sH , height: uiConstants.sW, alignment: .center)
                .rotationEffect(uiConstants.portraitOrientation ? Angle(degrees: 90) : Angle(degrees: 0))
                .ignoresSafeArea()
        )
        .onAppear {
            // Introduction Animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                withAnimation(.linear(duration: 1.5)) {
                    animationStage = 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.25, execute: {
                    withAnimation(.linear(duration: 1.5)) {
                        animationStage = 2
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                        withAnimation(.linear(duration: 1.5)) {
                            animationStage = 3
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75, execute: {
                            withAnimation(.linear(duration: 1)) {
                                tutorialInfo = true
                            }
                        })
                    })
                })
            })
            
            // Start adding cards
            cardsDeck.append(FirstGameCard)
            addNextCardToDeck()
        }
        .onChange(of: gameOver, perform: { _ in
            showingCard = Card(imageName: "Card Back", description: "GAME OVER", type: .final, firstChoiceText: "", secondChoiceText: "", firstChoiceStatistics: StatisticsPoints(society: 0, energyTechnology: 0, economy: 0, ecology: 0), secondChoiceStatistics: StatisticsPoints(society: 0, energyTechnology: 0, economy: 0, ecology: 0), firstChoiceDependentCard: DependentCard(false, index: nil, offset: nil), secondChoiceDependentCard: DependentCard(false, index: nil, offset: nil))
        })
    }
    
    var CardCollection: some View {
        ZStack {
            Image("Card Back")
                .resizable()
                .frame(width: uiConstants.sW * 0.6, height: uiConstants.sH * 0.5, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .black, radius: 8)
            
            NextCardView(front: {
                Image("Card Back")
                    .resizable()
                    .frame(width: uiConstants.sW * 0.6, height: uiConstants.sH * 0.5, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }, back: {
                CardView(cardsDeck: .constant([]), cardsPlayed: .constant([]), card: showingCard, isHidden: .constant(false), gameOver: .constant(false), onRemove: nil)
            }, cardRotation: $cardRotation, isChangingCard: $isChangingCard)
            
            CardView(cardsDeck: $cardsDeck, cardsPlayed: $cardsPlayed, card: showingCard, isHidden: $isChangingCard, gameOver: $gameOver, onRemove: {
                
                let randomCrisisEuphoriaStage = Int.random(in: 1...100)
                
                // 3% crisis, 3% euphoria, 24% recurrent, 70% independent
                // Increasing 1% crisis & euphoria each turn
                // If it hasn't appeared until turn 8, force crisis/euphoria stage
                // Avoid crisis/euphoria stage during first 2 turns
                
                if hasCrisisStageAppeared || hasEuphoriaStageAppeared {
                    crisisStageProbability = 3
                    euphoriaStageProbability = 3
                } else {
                    if cardsPlayed.count == 8 {
                        crisisStageProbability = 50
                        euphoriaStageProbability = 50
                    } else {
                        crisisStageProbability += 1
                        euphoriaStageProbability += 1
                    }
                }
                
                if cardsPlayed.count <= 3 {
                    crisisStageProbability = 0
                    euphoriaStageProbability = 0
                }
                
                
                if randomCrisisEuphoriaStage <= euphoriaStageProbability {
                    
                    hasEuphoriaStageAppeared = true
                    
                    showingCard.description = ""
                    
                    // Euphoria Stage
                    toggleSpecialStage(isEuphoriaStage: true, isAppear: true)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { showNextCard() })
                    
                } else if randomCrisisEuphoriaStage > euphoriaStageProbability && randomCrisisEuphoriaStage <= euphoriaStageProbability + crisisStageProbability {
                    
                    hasCrisisStageAppeared = true
                    
                    showingCard.description = ""
                    
                    // Crisis Stage
                    toggleSpecialStage(isEuphoriaStage: false, isAppear: true)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { showNextCard() })
                    
                } else {
                    // Normal Card
                    showingCard.description = ""
                    showNextCard()
                }
            })
        }
    }
    
    func showNextCard() {
        print(cardsPlayed)
        
        flipCard()
        addNextCardToDeck()
        
        if showingCard.description == cardsDeck[0].description {
            cardsDeck.move(fromOffsets: IndexSet(integer: 0), toOffset: 1)
        }
        
        withAnimation(.easeInOut(duration: 1.75)) {
            showingCard = cardsDeck[0]
        }
        cardsDeck.removeFirst()
    }
    
    func addNextCardToDeck() {
        
        // Stop adding cards
        guard IndependentCards.count != 0 else { return }
        
        var nextCard: Card
        
        let randomCardTypeNumber = Int.random(in: 0...100)
        
        if randomCardTypeNumber <= 25 {
            // Recurrent Card
            let randomCardNumber = Int.random(in: 0...(RecurrentCards.count - 1))
            nextCard = RecurrentCards[randomCardNumber]
            
        } else {
            // Indepedent Card
            let randomCardNumber = Int.random(in: 0...(IndependentCards.count - 1))
            
            nextCard = IndependentCards[randomCardNumber]
            
            IndependentCards.remove(at: randomCardNumber)
        }
        
        cardsDeck.append(nextCard)
    }
    
    
    func flipCard() {
        self.isChangingCard = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75, execute: { self.isChangingCard = false })
        withAnimation(.linear(duration: 0.75)) {
            self.cardRotation += 180
        }
    }
    
    var CrisisEuphoriaCardsCollection: some View {
        VStack {
            HStack {
                VStack {
                    Image(crisisStage ? "Sacrifice Card (Society)" : "Amenity Card (Society)")
                        .resizable()
                        .frame(width: uiConstants.sH * 0.23, height: uiConstants.sH * 0.23)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: .black, radius: 8)
                        .scaleEffect(showSpecialCards ? 1 : 0.001)
                        .rotationEffect(showSpecialCards ? Angle(degrees: 360) : Angle(degrees: 0))
                        .onTapGesture {
                            toggleSpecialStage(isEuphoriaStage: crisisStage ? false : true, isAppear: false)
                            withAnimation(.linear(duration: 1.25)) {
                                if crisisStage {
                                    if statisticsViewModel.societyBooster == .euphoria {
                                        statisticsViewModel.societyBooster = .none
                                    } else {
                                        statisticsViewModel.societyBooster = .crisis
                                    }
                                    
                                } else {
                                    if statisticsViewModel.societyBooster == .crisis {
                                        statisticsViewModel.societyBooster = .none
                                    } else {
                                        statisticsViewModel.societyBooster = .euphoria
                                    }
                                }
                            }
                        }
                    
                    Text(crisisStage ? "It looks like people are not very happy with your decisions and they will ignore some of your decisions" : "Wow, people are really happy with your good decisions!")
                        .font(.custom("NewBorough", size: 20, relativeTo: .body))
                        .foregroundColor(.white)
                        .padding(.top)
                        .opacity(showSpecialCards ? 0.9 : 0)
                }
                
                Spacer()
                
                VStack {
                    Image(crisisStage ? "Sacrifice Card (Economy)" : "Amenity Card (Economy)")
                        .resizable()
                        .frame(width: uiConstants.sH * 0.23, height: uiConstants.sH * 0.23)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: .black, radius: 8)
                        .scaleEffect(showSpecialCards ? 1 : 0.001)
                        .rotationEffect(showSpecialCards ? Angle(degrees: 360) : Angle(degrees: 0))
                        .onTapGesture {
                            toggleSpecialStage(isEuphoriaStage: crisisStage ? false : true, isAppear: false)
                            withAnimation(.linear(duration: 1.25)) {
                                if crisisStage {
                                    if statisticsViewModel.economyBooster == .euphoria {
                                        statisticsViewModel.economyBooster = .none
                                    } else {
                                        statisticsViewModel.economyBooster = .crisis
                                    }
                                } else {
                                    if statisticsViewModel.economyBooster == .crisis {
                                        statisticsViewModel.economyBooster = .none
                                    } else {
                                        statisticsViewModel.economyBooster = .euphoria
                                    }
                                }
                            }
                        }
                    
                    Text(crisisStage ? "There will be an economic downturn in the next few years..." : "The economy will prosper in the coming years!")
                        .font(.custom("NewBorough", size: 20, relativeTo: .body))
                        .foregroundColor(.white)
                        .padding(.top)
                        .opacity(showSpecialCards ? 0.9 : 0)
                }
            }
            
            Spacer()
            
            VStack {
                Image(crisisStage ? "Sacrifice Card (Energy Technology)" : "Amenity Card (Energy Technology)")
                    .resizable()
                    .frame(width: uiConstants.sH * 0.23, height: uiConstants.sH * 0.23)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(color: .black, radius: 8)
                    .scaleEffect(showSpecialCards ? 1 : 0.001)
                    .rotationEffect(showSpecialCards ? Angle(degrees: 360) : Angle(degrees: 0))
                    .onTapGesture {
                        toggleSpecialStage(isEuphoriaStage: crisisStage ? false : true, isAppear: false)
                        withAnimation(.linear(duration: 1.25)) {
                            if crisisStage {
                                if statisticsViewModel.energyTechnologyBooster == .euphoria {
                                    statisticsViewModel.energyTechnologyBooster = .none
                                } else {
                                    statisticsViewModel.energyTechnologyBooster = .crisis
                                }
                            } else {
                                if statisticsViewModel.energyTechnologyBooster == .crisis {
                                    statisticsViewModel.energyTechnologyBooster = .none
                                } else {
                                    statisticsViewModel.energyTechnologyBooster = .euphoria
                                }
                            }
                        }
                    }
                
                Text(crisisStage ? "There won't be any significant scientific advances in the next few years" : "In the coming years several of the most important scientists of all time will be born!")
                    .font(.custom("NewBorough", size: 20, relativeTo: .body))
                    .foregroundColor(.white)
                    .padding(.top)
                    .opacity(showSpecialCards ? 0.9 : 0)
            }
            
        }.frame(width: uiConstants.portraitOrientation ? uiConstants.sH * 0.63 : uiConstants.sH * 0.58, height: uiConstants.portraitOrientation ? uiConstants.sH * 0.6 : crisisStage ? uiConstants.sH * 0.58 : uiConstants.sH * 0.56)
            .allowsHitTesting(showSpecialCards)
        
    }
    
    func toggleSpecialStage(isEuphoriaStage: Bool, isAppear: Bool) {
        withAnimation(.easeOut(duration: 1.5)) {
            if isAppear {
                if isEuphoriaStage {
                    euphoriaStage.toggle()
                } else {
                    crisisStage.toggle()
                }
            } else {
                showSpecialCards.toggle()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.55, execute: {
            withAnimation(.easeIn(duration: 1.5)) {
                if isAppear {
                    showSpecialCards.toggle()
                } else {
                    if isEuphoriaStage {
                        euphoriaStage.toggle()
                    } else {
                        crisisStage.toggle()
                    }
                }
            }
        })
    }
}
