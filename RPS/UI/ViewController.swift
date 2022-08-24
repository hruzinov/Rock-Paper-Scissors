//
//  ViewController.swift
//  RPS
//
//  Created by Evhen Gruzinov on 24.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var computerSignLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var userSignRock: UIButton!
    @IBOutlet weak var userSignPaper: UIButton!
    @IBOutlet weak var userSignScissors: UIButton!
    @IBOutlet weak var buttonPlayAgain: UIButton!
    
    var gameState: GameState = .start
    var userSign: Sign = .none
    var computerSign: Sign = .none
    
    // When player tap on figure button
    @IBAction func buttonUserSign(_ sender: UIButton) {
        // Get sign of buttton
        let userSignEmoji = (sender.titleLabel!.text)!
        // Compare emoji and sign, hide another buttons
        switch userSignEmoji {
            case "👊":
                userSign = .rock
                userSignRock.isEnabled = false
                userSignPaper.isHidden = true
                userSignScissors.isHidden = true
            case "✋":
                userSign = .paper
                userSignPaper.isEnabled = false
                userSignRock.isHidden = true
                userSignScissors.isHidden = true
            case "✌️":
                userSign = .scissors
                userSignScissors.isEnabled = false
                userSignRock.isHidden = true
                userSignPaper.isHidden = true
        default:
            print("Unknowed user sign")
            gameState = .error; updateGame()
        }
        // Get computer choice and show it
        computerSignRand()
        computerSignLabel.text = computerSign.emoji
        print("User selected \(userSign) and computer selected \(computerSign)")
        getPlay()
    }
    
    // Restart game button: show and enable all buttons and start new game
    @IBAction func playAgain(_ sender: UIButton) {
        userSignRock.isEnabled = true
        userSignPaper.isEnabled = true
        userSignScissors.isEnabled = true
        userSignRock.isHidden = false
        userSignPaper.isHidden = false
        userSignScissors.isHidden = false
        
        gameState = .start
        updateGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gameState = .start
        updateGame()
    }

    func updateGame() {
        switch gameState {
        case .start:
            computerSignLabel.text = "🤖"
            statusLabel.text = "Rock, Paper or Scissors"
            buttonPlayAgain.isHidden = true
            view.backgroundColor = .gray
        case .win:
            statusLabel.text = "You win. Let's play again?"
            buttonPlayAgain.isHidden = false
            view.backgroundColor = .systemGreen
        case .lose:
            statusLabel.text = "You lose. Let's try again?"
            buttonPlayAgain.isHidden = false
            view.backgroundColor = .systemRed
        case .draw:
            statusLabel.text = "Draw. Let's try again?"
            buttonPlayAgain.isHidden = false
            view.backgroundColor = .orange
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

