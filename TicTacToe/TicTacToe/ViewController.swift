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
    private var winner: String? = nil
    private var player1WinCount: Int = 0
    private var player2WinCount: Int = 0
    
    override func viewDidLoad() {
    super.viewDidLoad()
    }
    
    @IBAction func startGame(_ sender: GameButton) {
        func markTheBoard(gameButton: GameButton, mark: String, color: UIColor) {
            gameButton.setTitle(mark, for: .normal)
            gameButton.setTitleColor(color, for: .normal)
            gameButton.isEnabled = false
            TicTacToeBrain.gameBoard[gameButton.row][gameButton.col] = mark
            trackforFullBoard += 1
        }
        
        if TicTacToeBrain.player1 {
            markTheBoard(gameButton: sender, mark: Player.x.mark, color: Player.x.color)
            transitionToNextPlayer(nextPlayerName: Player.o.playerName, nextPlayerMark: Player.o.mark)
        } else {
            markTheBoard(gameButton: sender, mark: Player.o.mark, color: Player.o.color)
            transitionToNextPlayer(nextPlayerName: Player.x.playerName, nextPlayerMark: Player.x.mark)
        }
        
        checkGameboardForWin(player: Player.x.mark)
        checkGameboardForWin(player: Player.o.mark)
    }

    @IBAction func restartGame(_ resetButton: UIButton) {
        buttons.forEach{ $0.setTitle("", for: .normal)}
        displayMessage.text = "Player 1 (X), your turn."
        trackforFullBoard = 0
        winner = nil
        buttons.forEach{ $0.isEnabled = true }
        TicTacToeBrain.player1 = true
        TicTacToeBrain.gameBoard = [[".",".","."],
        [".",".","."],
        [".",".","."]]
    }
    
    private func transitionToNextPlayer(nextPlayerName: String, nextPlayerMark: String) {
        displayMessage.text = "\(nextPlayerName) (\(nextPlayerMark)), your turn."
        TicTacToeBrain.player1 = !TicTacToeBrain.player1
    }
    
    private func checkGameboardForWin(player: String) {
        if TicTacToeBrain.gameBoard[0][0] == player && TicTacToeBrain.gameBoard[0][1] == player && TicTacToeBrain.gameBoard[0][2] == player {
            winner = player
            gameOver()
        } else if TicTacToeBrain.gameBoard[1][0] == player && TicTacToeBrain.gameBoard[1][1] == player && TicTacToeBrain.gameBoard[1][2] == player {
            winner = player
            gameOver()
        } else if TicTacToeBrain.gameBoard[2][0] == player && TicTacToeBrain.gameBoard[2][1] == player && TicTacToeBrain.gameBoard[2][2] == player {
            winner = player
            gameOver()
        } else if TicTacToeBrain.gameBoard[0][0] == player && TicTacToeBrain.gameBoard[1][0] == player && TicTacToeBrain.gameBoard[2][0] == player {
            winner = player
            gameOver()
        } else if TicTacToeBrain.gameBoard[0][1] == player && TicTacToeBrain.gameBoard[1][1] == player && TicTacToeBrain.gameBoard[2][1] == player {
            winner = player
            gameOver()
        } else if TicTacToeBrain.gameBoard[0][2] == player && TicTacToeBrain.gameBoard[1][2] == player && TicTacToeBrain.gameBoard[2][2] == player {
            winner = player
            gameOver()
        } else if TicTacToeBrain.gameBoard[0][0] == player && TicTacToeBrain.gameBoard[1][1] == player && TicTacToeBrain.gameBoard[2][2] == player {
            winner = player
            gameOver()
        } else if TicTacToeBrain.gameBoard[0][2] == player && TicTacToeBrain.gameBoard[1][1] == player && TicTacToeBrain.gameBoard[2][0] == player {
            winner = player
            gameOver()
        } else {
            checkForFullBoard()
        }
    }
    
    private func checkForFullBoard() {
        if trackforFullBoard == 9 {
            gameOver()
            winner = nil
        }
    }
    
    private func gameOver() {
        buttons.forEach{ $0.isEnabled = false }
        if let safeWinner = winner {
            displayMessage.text = "Game Over. \nWinner is \(safeWinner)"
            if safeWinner == Player.x.mark {
                player1WinCount += 1
                player1WinMessage.text = "Player 1 Win: \(player1WinCount)"
            } else if safeWinner == Player.o.mark {
                player2WinCount += 1
                player2WinMessage.text = "Player 2 Win: \(player2WinCount)"
            }
        } else {
            displayMessage.text = "Game Over.\nIt's a tie."
        }
    }
}
