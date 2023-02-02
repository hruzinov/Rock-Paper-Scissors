//
//  ContentView.swift
//  RPS
//
//  Created by Evhen Gruzinov on 24.08.2022.
//

import SwiftUI

struct GameView: View {
    
    @State var showingButtonRock = true
    @State var showingButtonPaper = true
    @State var showingButtonScissors = true
    
    @State var enabledButtonRock = true
    @State var enabledButtonPaper = true
    @State var enabledButtonScissors = true
    
    @State var showingButtonPlayAgain = false
    @State var computerSignLabel = "🤖"
    @State var statusLabel = "Rock, Paper or Scissors"
    
    @State var gameState: GameState = .start
    @State var userSign: Sign = .none
    @State var computerSign: Sign = .none
    @State var backgroundColor: Color = .gray
    
    var body: some View {
        VStack {
            Spacer()
            Text(computerSignLabel)
                .font(.system(size: 70))
                .padding(30)
            Text(statusLabel)
                .font(.system(size: 28))
            Spacer()
            HStack(spacing: 20) {
                Spacer()
                if showingButtonRock {
                    Button("✊") {
                        userSign = .rock
                        showingButtonPaper = false
                        showingButtonScissors = false
                        enabledButtonRock = false
                        getPlay()
                    }.font(.system(size: 70))
                        .disabled(!enabledButtonRock)
                }
                if showingButtonPaper {
                    Button("✋") {
                        userSign = .paper
                        showingButtonRock = false
                        showingButtonScissors = false
                        enabledButtonPaper = false
                        getPlay()
                    }.font(.system(size: 70))
                        .disabled(!enabledButtonPaper)
                }
                if showingButtonScissors {
                    Button("✌️") {
                        userSign = .scissors
                        showingButtonPaper = false
                        showingButtonRock = false
                        enabledButtonScissors = false
                        getPlay()
                    }.font(.system(size: 70))
                        .disabled(!enabledButtonScissors)
                }
                Spacer()
            }.padding([.bottom, .top], 55)
            if showingButtonPlayAgain {
                Button("Restart game") {
                    enabledButtonRock = true
                    enabledButtonPaper = true
                    enabledButtonScissors = true
                    showingButtonRock = true
                    showingButtonPaper = true
                    showingButtonScissors = true
                    
                    gameState = .start
                    updateGame()
                }.font(.system(size: 28)).padding()
            } else {
                Text(" ").font(.system(size: 28)).padding()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(Color.white)
        .background(backgroundColor)
        .edgesIgnoringSafeArea([.top, .bottom])
    }
    
    func updateGame() {
        switch gameState {
        case .start:
            computerSignLabel = "🤖"
            statusLabel = "Rock, Paper or Scissors"
            showingButtonPlayAgain = false
            backgroundColor = .gray
        case .win:
            statusLabel = "You win. Let's play again?"
            showingButtonPlayAgain = true
            backgroundColor = .green
        case .lose:
            statusLabel = "You lose. Let's try again?"
            showingButtonPlayAgain = true
            backgroundColor = .red
        case .draw:
            statusLabel = "Draw. Let's try again?"
            showingButtonPlayAgain = true
            backgroundColor = .orange
        case .error:
            print("-_- why are you here? Get away!")
            gameState = .start
            updateGame()
        }
    }
    
    func computerSignRand() {
        let computerVote = Int.random(in: 0...2)
        switch computerVote {
        case 0: computerSign = .rock
        case 1: computerSign = .paper
        case 2: computerSign = .scissors
        default:
            print("42")
            gameState = .error
            updateGame()
        }
    }
    
    // Comparison players and computer coices
    func getPlay() {
        computerSignRand()
        computerSignLabel = computerSign.rawValue
        print("User selected \(userSign) and computer selected \(computerSign)")
        
        if computerSign == userSign { gameState = .draw; print("Draw") } else {
            if userSign == .rock {
                if computerSign == .scissors { // Rock > Scissors
                    print("User Win")
                    gameState = .win
                } else { // Rock < Paper
                    print("User Lose")
                    gameState = .lose
                }
            } else if userSign == .paper {
                if computerSign == .rock { // Paper > Rock
                    print("User Win")
                    gameState = .win
                } else { // Paper < Scissors
                    print("User Lose")
                    gameState = .lose
                }
            } else { // User selected Scissors
                if computerSign == .paper { //Scissors > Paper
                    print("User Win")
                    gameState = .win
                } else { // Scissors < Rock
                    print("User Lose")
                    gameState = .lose
                }
            }
        }
        updateGame()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
