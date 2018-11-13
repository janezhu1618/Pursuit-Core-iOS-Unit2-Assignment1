//
//  ViewController.swift
//  TicTacToe
//
//  Created by Alex Paul on 11/8/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayMessage: UILabel!
    @IBOutlet var buttons: [GameButton]!
    @IBOutlet weak var player1WinMessage: UILabel!
    @IBOutlet weak var player2WinMessage: UILabel!
    private var xMarkedOnBoard: [GameButton] = []
    private var oMarkedOnBoard: [GameButton] = []
    private var trackforFullBoard: Int = 0
    private var winner: String? = ""
    private var player1WinCount: Int = 0
    private var player2WinCount: Int = 0
    
    override func viewDidLoad() {
    super.viewDidLoad()
    }
    
    @IBAction func startGame(_ sender: GameButton) {
        if TicTacToeBrain.player1 {
            putPlayerMark(gameButton: sender, mark: Player.x.mark, color: Player.x.color, collectingArr: &xMarkedOnBoard)
            transitionToNextPlayer(nextPlayerName: Player.o.playerName, nextPlayerMark: Player.o.mark)
        } else {
            putPlayerMark(gameButton: sender, mark: Player.o.mark, color: Player.o.color, collectingArr: &oMarkedOnBoard)
            transitionToNextPlayer(nextPlayerName: Player.x.playerName, nextPlayerMark: Player.x.mark)
        }
        
    if xMarkedOnBoard.count >= 3 {
        checkforWin(arr: xMarkedOnBoard, player: Player.x.playerName)
        }
    if oMarkedOnBoard.count >= 3 {
        checkforWin(arr: oMarkedOnBoard, player: Player.o.playerName)
        }
    }
    
    func gameOver() {
        buttons.forEach{ $0.isEnabled = false }
        if let safeWinner = winner {
            displayMessage.text = "Game Over. \nWinner is \(safeWinner)"
            if safeWinner == "Player 1" {
                player1WinCount += 1
                player1WinMessage.text = "Player 1 Win: \(player1WinCount)"
            } else {
                player2WinCount += 1
                player2WinMessage.text = "Player 2 Win: \(player2WinCount)"
            }
        } else {
            displayMessage.text = "Game Over.\nIt's a tie."
        }
    }

    @IBAction func restartGame(_ resetButton: UIButton) {
        buttons.forEach{ $0.setTitle("", for: .normal)}
        displayMessage.text = "Player 1 (X), your turn."
        trackforFullBoard = 0
        buttons.forEach{ $0.isEnabled = true }
        TicTacToeBrain.player1 = true
        xMarkedOnBoard.removeAll()
        oMarkedOnBoard.removeAll()
    }
    
    private func putPlayerMark(gameButton: GameButton, mark: String, color: UIColor, collectingArr: inout [GameButton]) {
        gameButton.setTitle(mark, for: .normal)
        gameButton.setTitleColor(color, for: .normal)
        gameButton.isEnabled = false
        collectingArr.append(gameButton)
        trackforFullBoard += 1
    }
    
    private func transitionToNextPlayer(nextPlayerName: String, nextPlayerMark: String) {
        displayMessage.text = "\(nextPlayerName) (\(nextPlayerMark)), your turn."
        TicTacToeBrain.player1 = !TicTacToeBrain.player1
    }
    
    private func checkforWin(arr: [GameButton], player: String) {
        print("experiemntal branch")
        for button1 in arr[0..<arr.count-2] {
            for button2 in arr[0..<arr.count-1] {
                for button3 in arr[0..<arr.count] {
                    if ((button2.row == button1.row && button3.row == button1.row) ||
                        (button2.col == button1.col && button3.col == button1.col) ||
                        (button1.row == button1.col && button2.row == button2.col && button3.row == button3.col) ||
                        ((button1.row + button1.col == 2) && (button2.row + button2.col == 2) && (button3.row + button3.col == 2)))
                        && button1 != button2 && button2 != button3 && button1 != button3 {
                        winner = player
                        gameOver()
                        }
                    else if trackforFullBoard == 9 {
                        winner = nil
                        gameOver()
                    }
                }
            }
        }
    }
}

