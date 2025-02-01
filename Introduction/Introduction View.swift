import SwiftUI

struct IntroductionView: View {
    
    @EnvironmentObject var uiConstants: UIConstantsViewModel
    
    @State var currentImageStage = 0
    @State var isChangingImage = false
    
    @State var currentTextStage = 0
    @State var introductionText = introAnimationText[0]
    @State var hideContinueText = false
    
    @State var presentGameBoard = false
    
    var body: some View {
        ZStack {
            
            Color.black.ignoresSafeArea()
        
        Image(uiConstants.portraitOrientation ? verticalIntroPhotos[currentImageStage] : horizontalIntroPhotos[currentImageStage])
            .resizable()
            .ignoresSafeArea()
            .frame(width: uiConstants.portraitOrientation ? uiConstants.sW : uiConstants.sH, height: uiConstants.portraitOrientation ? uiConstants.sH : uiConstants.sW)
            .opacity(isChangingImage ? 0 : 1)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 9.5, repeats: true, block: { _ in
                    passToNextImage()
                })
            }
            
            VStack {
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.black.opacity(0.4))
                        .frame(width: uiConstants.portraitOrientation ? uiConstants.sW : uiConstants.sH, height: uiConstants.portraitOrientation ? 300 : 240)
                        .ignoresSafeArea()
                        .overlay(
                            Text("Tap to continue  >")
                                .foregroundColor(.white)
                                .font(.custom("NewBorough", size: 20))
                                .padding([.trailing, .bottom])
                                .padding(.trailing)
                                .opacity(hideContinueText ? 0 : 1)
                            , alignment: .bottomTrailing)
                    
                    Text(introductionText)
                        .font(.custom("NewBorough", size: 36))
                        .foregroundColor(.white)
                        .frame(height: uiConstants.portraitOrientation ? 265 : 205, alignment: .topLeading)
                        .lineSpacing(8)
                        .ignoresSafeArea()
                        .padding([.horizontal, .top])
                }
            }.frame(width: uiConstants.portraitOrientation ? uiConstants.sW : uiConstants.sH, height: uiConstants.portraitOrientation ? uiConstants.sH : uiConstants.sW)
        }
        .onTapGesture {
            
            introductionText = ""
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                if currentTextStage != (introAnimationText.count - 1) {
                    withAnimation(.linear(duration: 1.25)) {
                        currentTextStage += 1
                        introductionText = introAnimationText[currentTextStage]
                    }
                } else {
                    withAnimation(.linear(duration: 1.4)) {
                        isChangingImage = true
                    }
                    presentGameBoard = true
                }
            })
            
            if !isChangingImage {
                passToNextImage()
            }
        }
        .onChange(of: introductionText, perform: { _ in
            withAnimation(.linear(duration: 1.25)) {
                hideContinueText.toggle()
            }
        })
        .fullScreenCover(isPresented: $presentGameBoard, content: MainGameBoard.init)
    }
    
    func passToNextImage() {
        withAnimation(.linear(duration: 1.4)) {
            isChangingImage = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            
            if currentImageStage != 5 {
                currentImageStage += 1
            } else {
                currentImageStage = 0
            }
            
            withAnimation(.linear(duration: 1.4)) {
                isChangingImage = false
            }
        })
    }
}
