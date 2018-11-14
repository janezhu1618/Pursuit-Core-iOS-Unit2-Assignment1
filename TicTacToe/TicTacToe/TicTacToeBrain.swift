//
//  TicTacToeBrain.swift
//  TicTacToe
//
//  Created by Alex Paul on 11/8/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class TicTacToeBrain {
    var playerName: String
    var mark: String
    var color: UIColor
    static var player1 = true
    static var gameBoard: [[String]] = [["","",""],
                                        ["","",""],
                                        ["","",""]]
    
    init(playerName: String, mark: String, color: UIColor) {
        self.playerName = playerName
        self.mark = mark
        self.color = color
    }
}


