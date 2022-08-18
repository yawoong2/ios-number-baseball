//
//  NumberBaseball.swift
//  NumberBaseball
//
//  Created by Gundy, mene on 2022/08/16.
//

import Foundation

var baseballRandomNumbers: [Int] = makeThreeRandomNumbers()
var remainCount: Int = 9

func makeThreeRandomNumbers() -> [Int] {
    let randomNumbers: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9].shuffled()
    var baseballGameNumbers: [Int] = []
    for index in 1...3 {
        baseballGameNumbers.append(randomNumbers[index])
    }
    return baseballGameNumbers
}

func compare(with numbers: [Int]) -> (Int, Int) {
    var strike: Int = 0
    var ball: Int = 0
    for index in 0...2 {
        if baseballRandomNumbers[index] == numbers[index] {
            strike += 1
        } else if baseballRandomNumbers.contains(numbers[index]) {
            ball += 1
        }
    }
    remainCount -= 1
    return (strike, ball)
}

func checkResult(strike: Int, ball: Int) {
    print("""
          \(strike) 스트라이크, \(ball) 볼
          남은 기회: \(remainCount)
          """)
    if strike == 3 {
        print("사용자 승리!")
    } else if remainCount == 0 {
        print("컴퓨터 승리...!")
    }
}

func startGame() {
    while true {
        let myNumbers: [Int] = inputNumbers()
        let gameScore: (strike: Int, ball: Int) = compare(with: myNumbers)
        checkResult(strike: gameScore.strike, ball: gameScore.ball)
        if gameScore.strike == 3 || remainCount == 0 {
            break
        }
    }
    selectMenu()
}

func selectMenu() {
    print("""
          1. 게임시작
          2. 게임종료
          원하는 기능을 선택해주세요 :
          """, terminator: " ")
    guard let selectedMenu = readLine() else {
        print("입력이 잘못되었습니다")
        selectMenu()
        return
    }
    switch selectedMenu {
    case "1":
        startGame()
    case "2":
        return
    default:
        print("입력이 잘못되었습니다")
        selectMenu()
        return
    }
}

func inputNumbers() -> [Int] {
    var myNumbers: [Int] = []
    print("""
          숫자 3개를 띄어쓰기로 구분하여 입력해주세요.
          중복 숫자는 허용하지 않습니다.
          입력 :
          """, terminator: " ")
    if let input = readLine()?.components(separatedBy: " ") {
        guard input.count == 3 else {
            print("입력이 잘못되었습니다")
            return inputNumbers()
        }
        guard let firstNumber = Int(input[0]) else {
            print("입력이 잘못되었습니다")
            return inputNumbers()
        }
        guard let secondNumber = Int(input[1]) else {
            print("입력이 잘못되었습니다")
            return inputNumbers()
        }
        guard let thirdNumber = Int(input[2]) else {
            print("입력이 잘못되었습니다")
            return inputNumbers()
        }
        if checkUserInput(firstNumber: firstNumber, secondNumber: secondNumber, thirdNumber: thirdNumber) == false {
            return inputNumbers()
        }
        myNumbers += [firstNumber, secondNumber, thirdNumber]
    }
    return myNumbers
}

func checkUserInput(firstNumber: Int, secondNumber: Int, thirdNumber: Int) -> Bool {
    if firstNumber == secondNumber || firstNumber == thirdNumber || secondNumber == thirdNumber {
        print("중복된 숫자를 입력하였습니다")
        return false
    }
    if firstNumber < 1 || secondNumber < 1 || thirdNumber < 1 {
        print("입력이 잘못되었습니다")
        return false
    } else if firstNumber > 9 || secondNumber > 9 || thirdNumber > 9 {
        print("입력이 잘못되었습니다")
        return false
    }
    return true
}
