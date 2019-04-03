//: Playground - noun: a place where people can play

import UIKit

//Deinit được call tự động
//khi nào cần thiết thì mới phải khai báo deinit
//deinit của con tự động call deinit của cha ở cuối deinit của con
//con không gọi thì deinit của cha cũng được gọi ngầm định

//example

class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested : Int) -> Int {
        let numberOfCoinsToVend = min(coinsInBank, numberOfCoinsRequested)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins : Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse : Int
    init(coins : Int) {
        self.coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins : Int) {
        self.coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        Bank.receive(coins: self.coinsInPurse)
    }
}

var playerOne : Player? = Player(coins: 100)
print("a new player has join the game with: \(playerOne!.coinsInPurse) coins")
print("the bank now only has \(Bank.coinsInBank) coins left")

playerOne!.win(coins: 2_000)

print("the bank now only has \(playerOne!.coinsInPurse) coins left")

playerOne = nil

print("player 1 has left the game")
print("the bank now has \(Bank.coinsInBank) coins")
